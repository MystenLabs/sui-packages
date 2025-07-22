module 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config {
    struct CircleConfig has drop, store {
        contribution_amount: u64,
        security_deposit: u64,
        currency_type: 0x1::string::String,
        contribution_amount_local: u64,
        security_deposit_local: u64,
        contribution_amount_usd: u64,
        security_deposit_usd: u64,
        cycle_length: u64,
        cycle_day: u64,
        circle_type: u8,
        rotation_style: u8,
        max_members: u64,
        auto_swap_enabled: bool,
    }

    struct MilestoneConfig has drop, store {
        goal_type: 0x1::option::Option<u8>,
        target_amount: 0x1::option::Option<u64>,
        target_amount_local: 0x1::option::Option<u64>,
        target_date: 0x1::option::Option<u64>,
        verification_required: bool,
        goal_progress: u64,
        last_milestone_completed: u64,
    }

    struct PenaltyRules has drop, store {
        late_payment: bool,
        missed_meeting: bool,
        late_payment_fee: u64,
        missed_meeting_fee: u64,
        warning_penalty_amount: u64,
        allow_penalty_payments: bool,
    }

    public fun attach_circle_config(arg0: &mut 0x2::object::UID, arg1: CircleConfig) {
        0x2::dynamic_field::add<vector<u8>, CircleConfig>(arg0, b"circle_config", arg1);
    }

    public fun attach_milestone_config(arg0: &mut 0x2::object::UID, arg1: MilestoneConfig) {
        0x2::dynamic_field::add<vector<u8>, MilestoneConfig>(arg0, b"milestone_config", arg1);
    }

    public fun attach_penalty_rules(arg0: &mut 0x2::object::UID, arg1: PenaltyRules) {
        0x2::dynamic_field::add<vector<u8>, PenaltyRules>(arg0, b"penalties_config", arg1);
    }

    public fun create_circle_config(arg0: u64, arg1: u64, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u8, arg10: u8, arg11: u64, arg12: bool) : CircleConfig {
        CircleConfig{
            contribution_amount       : arg0,
            security_deposit          : arg1,
            currency_type             : arg2,
            contribution_amount_local : arg3,
            security_deposit_local    : arg4,
            contribution_amount_usd   : arg5,
            security_deposit_usd      : arg6,
            cycle_length              : arg7,
            cycle_day                 : arg8,
            circle_type               : arg9,
            rotation_style            : arg10,
            max_members               : arg11,
            auto_swap_enabled         : arg12,
        }
    }

    public fun create_milestone_config(arg0: 0x1::option::Option<u8>, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: bool) : MilestoneConfig {
        MilestoneConfig{
            goal_type                : arg0,
            target_amount            : arg1,
            target_amount_local      : arg2,
            target_date              : arg3,
            verification_required    : arg4,
            goal_progress            : 0,
            last_milestone_completed : 0,
        }
    }

    public fun create_penalty_rules(arg0: vector<bool>) : PenaltyRules {
        PenaltyRules{
            late_payment           : *0x1::vector::borrow<bool>(&arg0, 0),
            missed_meeting         : *0x1::vector::borrow<bool>(&arg0, 1),
            late_payment_fee       : 5,
            missed_meeting_fee     : 2,
            warning_penalty_amount : 50000000000,
            allow_penalty_payments : true,
        }
    }

    public fun get_circle_config(arg0: &0x2::object::UID) : &CircleConfig {
        0x2::dynamic_field::borrow<vector<u8>, CircleConfig>(arg0, b"circle_config")
    }

    public fun get_circle_config_mut(arg0: &mut 0x2::object::UID) : &mut CircleConfig {
        0x2::dynamic_field::borrow_mut<vector<u8>, CircleConfig>(arg0, b"circle_config")
    }

    public fun get_contribution_amount(arg0: &0x2::object::UID) : u64 {
        get_circle_config(arg0).contribution_amount
    }

    public fun get_contribution_amount_local(arg0: &0x2::object::UID) : u64 {
        get_circle_config(arg0).contribution_amount_local
    }

    public fun get_contribution_amount_usd(arg0: &0x2::object::UID) : u64 {
        get_circle_config(arg0).contribution_amount_usd
    }

    public fun get_currency_type(arg0: &0x2::object::UID) : 0x1::string::String {
        get_circle_config(arg0).currency_type
    }

    public fun get_cycle_day(arg0: &0x2::object::UID) : u64 {
        get_circle_config(arg0).cycle_day
    }

    public fun get_cycle_length(arg0: &0x2::object::UID) : u64 {
        get_circle_config(arg0).cycle_length
    }

    public fun get_goal_type(arg0: &0x2::object::UID) : 0x1::option::Option<u8> {
        get_milestone_config(arg0).goal_type
    }

    public fun get_max_members(arg0: &0x2::object::UID) : u64 {
        get_circle_config(arg0).max_members
    }

    public fun get_milestone_config(arg0: &0x2::object::UID) : &MilestoneConfig {
        0x2::dynamic_field::borrow<vector<u8>, MilestoneConfig>(arg0, b"milestone_config")
    }

    public fun get_milestone_config_mut(arg0: &mut 0x2::object::UID) : &mut MilestoneConfig {
        0x2::dynamic_field::borrow_mut<vector<u8>, MilestoneConfig>(arg0, b"milestone_config")
    }

    public fun get_penalty_rules(arg0: &0x2::object::UID) : &PenaltyRules {
        0x2::dynamic_field::borrow<vector<u8>, PenaltyRules>(arg0, b"penalties_config")
    }

    public fun get_penalty_rules_mut(arg0: &mut 0x2::object::UID) : &mut PenaltyRules {
        0x2::dynamic_field::borrow_mut<vector<u8>, PenaltyRules>(arg0, b"penalties_config")
    }

    public fun get_security_deposit(arg0: &0x2::object::UID) : u64 {
        get_circle_config(arg0).security_deposit
    }

    public fun get_security_deposit_local(arg0: &0x2::object::UID) : u64 {
        get_circle_config(arg0).security_deposit_local
    }

    public fun get_security_deposit_usd(arg0: &0x2::object::UID) : u64 {
        get_circle_config(arg0).security_deposit_usd
    }

    public fun get_target_amount(arg0: &0x2::object::UID) : 0x1::option::Option<u64> {
        get_milestone_config(arg0).target_amount
    }

    public fun get_target_amount_local(arg0: &0x2::object::UID) : 0x1::option::Option<u64> {
        get_milestone_config(arg0).target_amount_local
    }

    public fun get_warning_penalty_amount(arg0: &0x2::object::UID) : u64 {
        get_penalty_rules(arg0).warning_penalty_amount
    }

    public fun is_auto_swap_enabled(arg0: &0x2::object::UID) : bool {
        get_circle_config(arg0).auto_swap_enabled
    }

    public fun set_max_members(arg0: &mut 0x2::object::UID, arg1: u64) {
        get_circle_config_mut(arg0).max_members = arg1;
    }

    public fun toggle_auto_swap(arg0: &mut 0x2::object::UID, arg1: bool) {
        get_circle_config_mut(arg0).auto_swap_enabled = arg1;
    }

    // decompiled from Move bytecode v6
}

