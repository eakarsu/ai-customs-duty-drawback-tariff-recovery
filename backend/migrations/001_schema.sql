CREATE TABLE IF NOT EXISTS app_users(
  id BIGSERIAL PRIMARY KEY,email TEXT UNIQUE NOT NULL,name TEXT NOT NULL,role TEXT NOT NULL,password_hash TEXT NOT NULL,created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS workflow_cases(
  id BIGSERIAL PRIMARY KEY,workflow_id TEXT NOT NULL,reference TEXT UNIQUE NOT NULL,subject TEXT NOT NULL,owner TEXT NOT NULL,state TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,payload JSONB NOT NULL DEFAULT '{}'::jsonb,created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS audit_events(
  id BIGSERIAL PRIMARY KEY,event_time TIMESTAMPTZ NOT NULL DEFAULT NOW(),actor TEXT NOT NULL,action TEXT NOT NULL,object_type TEXT NOT NULL,object_reference TEXT NOT NULL,detail TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS saved_analyses(
  id BIGSERIAL PRIMARY KEY,workflow_id TEXT NOT NULL,actor TEXT NOT NULL,analysis_type TEXT NOT NULL,inputs JSONB NOT NULL,result JSONB NOT NULL,provider TEXT NOT NULL,model TEXT,created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS integration_state(
  id TEXT PRIMARY KEY,name TEXT NOT NULL,category TEXT NOT NULL,mode TEXT NOT NULL,status TEXT NOT NULL,last_tested TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS idx_workflow_cases_workflow ON workflow_cases(workflow_id);
CREATE INDEX IF NOT EXISTS idx_workflow_cases_due ON workflow_cases(due_date);
CREATE INDEX IF NOT EXISTS idx_audit_events_time ON audit_events(event_time DESC);

CREATE TABLE IF NOT EXISTS "op_import_normalize"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_entryNumber" TEXT NOT NULL,
  "data_importDate" DATE NOT NULL,
  "data_htsCode" TEXT NOT NULL,
  "data_dutyPaid" NUMERIC(16,2) NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_import_normalize_due ON "op_import_normalize"(due_date);

CREATE TABLE IF NOT EXISTS "op_export_match"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_importEntry" TEXT NOT NULL,
  "data_exportReference" TEXT NOT NULL,
  "data_matchMethod" TEXT NOT NULL,
  "data_quantity" NUMERIC(16,2) NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_export_match_due ON "op_export_match"(due_date);

CREATE TABLE IF NOT EXISTS "op_eligibility"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_claimant" TEXT NOT NULL,
  "data_drawbackType" TEXT NOT NULL,
  "data_exportDate" DATE NOT NULL,
  "data_eligibilityNotes" TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_eligibility_due ON "op_eligibility"(due_date);

CREATE TABLE IF NOT EXISTS "op_claim_build"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_claimNumber" TEXT NOT NULL,
  "data_claimPeriod" TEXT NOT NULL,
  "data_claimedAmount" NUMERIC(16,2) NOT NULL,
  "data_missingEvidence" TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_claim_build_due ON "op_claim_build"(due_date);

CREATE TABLE IF NOT EXISTS "op_section_301"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_product" TEXT NOT NULL,
  "data_country" TEXT NOT NULL,
  "data_section301Paid" NUMERIC(16,2) NOT NULL,
  "data_exportProgram" TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_section_301_due ON "op_section_301"(due_date);

CREATE TABLE IF NOT EXISTS "op_broker_audit"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_broker" TEXT NOT NULL,
  "data_entryPopulation" NUMERIC(16,2) NOT NULL,
  "data_exceptionType" TEXT NOT NULL,
  "data_exceptionDetails" TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_broker_audit_due ON "op_broker_audit"(due_date);

CREATE TABLE IF NOT EXISTS "op_liquidation"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_entryNumber" TEXT NOT NULL,
  "data_liquidationDate" DATE NOT NULL,
  "data_filingDeadline" DATE NOT NULL,
  "data_deadlineStatus" TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_liquidation_due ON "op_liquidation"(due_date);

CREATE TABLE IF NOT EXISTS "op_recovery_forecast"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_businessUnit" TEXT NOT NULL,
  "data_period" TEXT NOT NULL,
  "data_eligibleDuties" NUMERIC(16,2) NOT NULL,
  "data_confidence" TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_recovery_forecast_due ON "op_recovery_forecast"(due_date);

CREATE TABLE IF NOT EXISTS "op_import_ledger"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_entryNumber" TEXT NOT NULL,
  "data_htsCode" TEXT NOT NULL,
  "data_customsValue" NUMERIC(16,2) NOT NULL,
  "data_liquidationDate" DATE NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_import_ledger_due ON "op_import_ledger"(due_date);

CREATE TABLE IF NOT EXISTS "op_export_register"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_exportReference" TEXT NOT NULL,
  "data_destination" TEXT NOT NULL,
  "data_exportDate" DATE NOT NULL,
  "data_exportValue" NUMERIC(16,2) NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_export_register_due ON "op_export_register"(due_date);

CREATE TABLE IF NOT EXISTS "op_classification_master"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_sku" TEXT NOT NULL,
  "data_product" TEXT NOT NULL,
  "data_htsCode" TEXT NOT NULL,
  "data_countryOfOrigin" TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_classification_master_due ON "op_classification_master"(due_date);

CREATE TABLE IF NOT EXISTS "op_broker_scorecard"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_broker" TEXT NOT NULL,
  "data_entryCount" NUMERIC(16,2) NOT NULL,
  "data_errorRate" NUMERIC(16,2) NOT NULL,
  "data_serviceNotes" TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_broker_scorecard_due ON "op_broker_scorecard"(due_date);
