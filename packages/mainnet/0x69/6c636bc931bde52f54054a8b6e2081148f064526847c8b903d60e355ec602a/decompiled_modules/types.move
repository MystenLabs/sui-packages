module 0x696c636bc931bde52f54054a8b6e2081148f064526847c8b903d60e355ec602a::types {
    struct SkillsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct TasksKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ClaimsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct BadgesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CertificationsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct HistoryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ChainKey has copy, drop, store {
        dummy_field: bool,
    }

    struct VerificationResult has copy, drop {
        success: bool,
        method: vector<u8>,
        timestamp: u64,
    }

    struct PaymentSplit has copy, drop, store {
        recipient: address,
        amount: u64,
    }

    struct PriorityMultipliers has copy, drop, store {
        standard: u64,
        priority: u64,
        urgent: u64,
    }

    struct Version has copy, drop, store {
        major: u8,
        minor: u8,
        patch: u8,
    }

    public fun custom_multipliers(arg0: u64, arg1: u64, arg2: u64) : PriorityMultipliers {
        PriorityMultipliers{
            standard : arg0,
            priority : arg1,
            urgent   : arg2,
        }
    }

    public fun default_multipliers() : PriorityMultipliers {
        PriorityMultipliers{
            standard : 10000,
            priority : 15000,
            urgent   : 25000,
        }
    }

    public fun get_multiplier(arg0: &PriorityMultipliers, arg1: u8) : u64 {
        if (arg1 == 0) {
            arg0.standard
        } else if (arg1 == 1) {
            arg0.priority
        } else {
            arg0.urgent
        }
    }

    public fun is_newer(arg0: &Version, arg1: &Version) : bool {
        arg0.major != arg1.major && arg0.major > arg1.major || arg0.minor != arg1.minor && arg0.minor > arg1.minor || arg0.patch > arg1.patch
    }

    public fun is_success(arg0: &VerificationResult) : bool {
        arg0.success
    }

    public fun major(arg0: &Version) : u8 {
        arg0.major
    }

    public fun method(arg0: &VerificationResult) : vector<u8> {
        arg0.method
    }

    public fun minor(arg0: &Version) : u8 {
        arg0.minor
    }

    public fun patch(arg0: &Version) : u8 {
        arg0.patch
    }

    public fun payment_split(arg0: address, arg1: u64) : PaymentSplit {
        PaymentSplit{
            recipient : arg0,
            amount    : arg1,
        }
    }

    public fun priority(arg0: &PriorityMultipliers) : u64 {
        arg0.priority
    }

    public fun split_amount(arg0: &PaymentSplit) : u64 {
        arg0.amount
    }

    public fun split_recipient(arg0: &PaymentSplit) : address {
        arg0.recipient
    }

    public fun standard(arg0: &PriorityMultipliers) : u64 {
        arg0.standard
    }

    public fun timestamp(arg0: &VerificationResult) : u64 {
        arg0.timestamp
    }

    public fun urgent(arg0: &PriorityMultipliers) : u64 {
        arg0.urgent
    }

    public fun verification_failure(arg0: vector<u8>, arg1: u64) : VerificationResult {
        VerificationResult{
            success   : false,
            method    : arg0,
            timestamp : arg1,
        }
    }

    public fun verification_success(arg0: vector<u8>, arg1: u64) : VerificationResult {
        VerificationResult{
            success   : true,
            method    : arg0,
            timestamp : arg1,
        }
    }

    public fun version(arg0: u8, arg1: u8, arg2: u8) : Version {
        Version{
            major : arg0,
            minor : arg1,
            patch : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

