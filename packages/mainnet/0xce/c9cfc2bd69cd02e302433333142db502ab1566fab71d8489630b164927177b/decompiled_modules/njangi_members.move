module 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members {
    struct Member has drop, store {
        joined_at: u64,
        last_contribution: u64,
        total_contributed: u64,
        received_payout: bool,
        payout_position: 0x1::option::Option<u64>,
        deposit_balance: u64,
        missed_payments: u64,
        missed_meetings: u64,
        status: u8,
        warning_count: u8,
        reputation_score: u8,
        last_warning_time: u64,
        suspension_end_time: 0x1::option::Option<u64>,
        total_meetings_attended: u64,
        total_meetings_required: u64,
        consecutive_on_time_payments: u64,
        exit_requested: bool,
        exit_request_time: 0x1::option::Option<u64>,
        unpaid_penalties: u64,
        warnings_with_penalties: vector<u64>,
        activated_at: 0x1::option::Option<u64>,
        deposit_paid: bool,
    }

    struct MemberJoined has copy, drop {
        circle_id: 0x2::object::ID,
        member: address,
        position: 0x1::option::Option<u64>,
    }

    struct MemberApproved has copy, drop {
        circle_id: 0x2::object::ID,
        member: address,
        approved_by: address,
    }

    struct MemberActivated has copy, drop {
        circle_id: 0x2::object::ID,
        member: address,
        deposit_amount: u64,
    }

    struct WarningIssued has copy, drop {
        circle_id: 0x2::object::ID,
        member: address,
        warning_count: u8,
        penalty_amount: u64,
        reason: 0x1::string::String,
    }

    struct PenaltyPaid has copy, drop {
        circle_id: 0x2::object::ID,
        member: address,
        amount: u64,
        warnings_cleared: u8,
    }

    public fun member_status_active() : u8 {
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::member_status_active()
    }

    public fun member_status_pending() : u8 {
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::member_status_pending()
    }

    public fun member_status_suspended() : u8 {
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::member_status_suspended()
    }

    public fun add_to_deposit_balance(arg0: &mut Member, arg1: u64) {
        arg0.deposit_balance = arg0.deposit_balance + arg1;
    }

    public fun create_member(arg0: u64, arg1: 0x1::option::Option<u64>, arg2: u64, arg3: u8) : Member {
        Member{
            joined_at                    : arg0,
            last_contribution            : 0,
            total_contributed            : 0,
            received_payout              : false,
            payout_position              : arg1,
            deposit_balance              : arg2,
            missed_payments              : 0,
            missed_meetings              : 0,
            status                       : arg3,
            warning_count                : 0,
            reputation_score             : 0,
            last_warning_time            : 0,
            suspension_end_time          : 0x1::option::none<u64>(),
            total_meetings_attended      : 0,
            total_meetings_required      : 0,
            consecutive_on_time_payments : 0,
            exit_requested               : false,
            exit_request_time            : 0x1::option::none<u64>(),
            unpaid_penalties             : 0,
            warnings_with_penalties      : 0x1::vector::empty<u64>(),
            activated_at                 : 0x1::option::none<u64>(),
            deposit_paid                 : false,
        }
    }

    public fun get_activated_at(arg0: &Member) : 0x1::option::Option<u64> {
        arg0.activated_at
    }

    public fun get_contribution_history(arg0: &Member) : (u64, u64, u64, u64) {
        (0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::from_decimals(arg0.total_contributed), arg0.consecutive_on_time_payments, arg0.missed_payments, arg0.total_meetings_required)
    }

    public fun get_deposit_balance(arg0: &Member) : u64 {
        arg0.deposit_balance
    }

    public fun get_members_by_status_from_list(arg0: vector<address>, arg1: u8, arg2: &0x2::table::Table<address, Member>) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0)) {
            let v2 = *0x1::vector::borrow<address>(&arg0, v1);
            if (0x2::table::contains<address, Member>(arg2, v2)) {
                if (0x2::table::borrow<address, Member>(arg2, v2).status == arg1) {
                    0x1::vector::push_back<address>(&mut v0, v2);
                };
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_payout_position(arg0: &Member) : 0x1::option::Option<u64> {
        arg0.payout_position
    }

    public fun get_reputation_score(arg0: &Member) : u8 {
        arg0.reputation_score
    }

    public fun get_status(arg0: &Member) : u8 {
        arg0.status
    }

    public fun get_suspension_end_time(arg0: &Member) : 0x1::option::Option<u64> {
        arg0.suspension_end_time
    }

    public fun get_total_contributed(arg0: &Member) : u64 {
        arg0.total_contributed
    }

    public fun get_total_meetings_required(arg0: &Member) : u64 {
        arg0.total_meetings_required
    }

    public fun get_unpaid_penalties(arg0: &Member) : u64 {
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::from_decimals(arg0.unpaid_penalties)
    }

    public fun get_warning_count(arg0: &Member) : u8 {
        arg0.warning_count
    }

    public fun has_missed_payment(arg0: &Member, arg1: u64, arg2: u64) : bool {
        arg0.last_contribution == 0 && arg0.joined_at < arg1 || arg0.last_contribution < arg1
    }

    public fun has_paid_deposit(arg0: &Member) : bool {
        arg0.deposit_paid
    }

    public fun has_received_payout(arg0: &Member) : bool {
        arg0.received_payout
    }

    public fun is_eligible_for_payout(arg0: &Member, arg1: u64, arg2: u64, arg3: u64) : bool {
        if (arg0.status == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::member_status_active()) {
            if (!arg0.received_payout) {
                if (arg0.total_contributed >= arg1) {
                    if (0x1::option::is_none<u64>(&arg0.suspension_end_time)) {
                        arg3 >= arg2
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun issue_warning(arg0: &mut Member, arg1: &0x2::clock::Clock) {
        arg0.warning_count = arg0.warning_count + 1;
        arg0.last_warning_time = 0x2::clock::timestamp_ms(arg1);
    }

    public fun issue_warning_with_penalty(arg0: &mut Member, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) {
        arg0.warning_count = arg0.warning_count + 1;
        arg0.last_warning_time = 0x2::clock::timestamp_ms(arg3);
        if (arg2) {
            arg0.unpaid_penalties = arg0.unpaid_penalties + arg1;
            0x1::vector::push_back<u64>(&mut arg0.warnings_with_penalties, 0x2::clock::timestamp_ms(arg3));
        };
    }

    public fun member_status_inactive() : u8 {
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::member_status_exited()
    }

    public fun process_member_exit(arg0: &mut Member, arg1: u64) : bool {
        if (!arg0.exit_requested) {
            return false
        };
        if (arg0.total_contributed < arg1 * arg0.total_meetings_required) {
            return false
        };
        arg0.status = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::member_status_exited();
        true
    }

    public fun reactivate_member(arg0: &mut Member, arg1: &0x2::clock::Clock) : bool {
        if (0x1::option::is_none<u64>(&arg0.suspension_end_time)) {
            return false
        };
        if (0x2::clock::timestamp_ms(arg1) < *0x1::option::borrow<u64>(&arg0.suspension_end_time)) {
            return false
        };
        arg0.status = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::member_status_active();
        arg0.warning_count = 0;
        arg0.suspension_end_time = 0x1::option::none<u64>();
        true
    }

    public fun record_contribution(arg0: &mut Member, arg1: u64, arg2: u64) {
        arg0.last_contribution = arg2;
        arg0.total_contributed = arg0.total_contributed + arg1;
    }

    public fun request_exit(arg0: &mut Member, arg1: &0x2::clock::Clock) : bool {
        if (arg0.status != 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::member_status_active()) {
            return false
        };
        if (arg0.exit_requested) {
            return false
        };
        arg0.exit_requested = true;
        arg0.exit_request_time = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg1));
        true
    }

    public(friend) fun reset_contribution_status(arg0: &mut Member) {
        arg0.last_contribution = 0;
    }

    public fun set_activated_at(arg0: &mut Member, arg1: u64) {
        arg0.activated_at = 0x1::option::some<u64>(arg1);
    }

    public fun set_deposit_balance(arg0: &mut Member, arg1: u64) {
        arg0.deposit_balance = arg1;
    }

    public fun set_deposit_paid(arg0: &mut Member, arg1: bool) {
        arg0.deposit_paid = arg1;
    }

    public fun set_payout_position(arg0: &mut Member, arg1: 0x1::option::Option<u64>) {
        arg0.payout_position = arg1;
    }

    public fun set_received_payout(arg0: &mut Member, arg1: bool) {
        arg0.received_payout = arg1;
    }

    public fun set_status(arg0: &mut Member, arg1: u8) {
        arg0.status = arg1;
    }

    public fun subtract_from_deposit_balance(arg0: &mut Member, arg1: u64) {
        assert!(arg0.deposit_balance >= arg1, 12);
        arg0.deposit_balance = arg0.deposit_balance - arg1;
    }

    public fun suspend_member(arg0: &mut Member, arg1: &0x2::clock::Clock) {
        arg0.status = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::member_status_suspended();
        arg0.suspension_end_time = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg1) + 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::ms_per_month());
    }

    public fun update_member_reputation(arg0: &mut Member, arg1: bool, arg2: bool) {
        if (arg1) {
            arg0.total_meetings_attended = arg0.total_meetings_attended + 1;
        };
        arg0.total_meetings_required = arg0.total_meetings_required + 1;
        if (arg2) {
            arg0.consecutive_on_time_payments = arg0.consecutive_on_time_payments + 1;
        } else {
            arg0.consecutive_on_time_payments = 0;
        };
        let v0 = if (arg0.total_meetings_required == 0) {
            100
        } else {
            arg0.total_meetings_attended * 100 / arg0.total_meetings_required
        };
        let v1 = if (arg0.consecutive_on_time_payments >= 12) {
            100
        } else {
            arg0.consecutive_on_time_payments * 100 / 12
        };
        arg0.reputation_score = (((v0 + v1) / 2) as u8);
    }

    // decompiled from Move bytecode v6
}

