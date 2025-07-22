module 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles {
    struct Circle has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        admin: address,
        current_members: u64,
        members: 0x2::table::Table<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member>,
        contributions: 0x2::balance::Balance<0x2::sui::SUI>,
        deposits: 0x2::balance::Balance<0x2::sui::SUI>,
        penalties: 0x2::balance::Balance<0x2::sui::SUI>,
        current_cycle: u64,
        next_payout_time: u64,
        created_at: u64,
        rotation_order: vector<address>,
        rotation_history: vector<address>,
        current_position: u64,
        active_auction: 0x1::option::Option<Auction>,
        is_active: bool,
        contributions_this_cycle: u64,
        paused_after_cycle: bool,
    }

    struct Auction has drop, store {
        position: u64,
        minimum_bid: u64,
        highest_bid: u64,
        highest_bidder: 0x1::option::Option<address>,
        start_time: u64,
        end_time: u64,
        discount_rate: u64,
    }

    struct CircleCreated has copy, drop {
        circle_id: 0x2::object::ID,
        admin: address,
        name: 0x1::string::String,
        contribution_amount: u64,
        currency_type: 0x1::string::String,
        contribution_amount_local: u64,
        security_deposit_local: u64,
        max_members: u64,
        cycle_length: u64,
    }

    struct CircleActivated has copy, drop {
        circle_id: 0x2::object::ID,
        activated_by: address,
    }

    struct CircleDeleted has copy, drop {
        circle_id: 0x2::object::ID,
        admin: address,
        name: 0x1::string::String,
    }

    struct TreasuryUpdated has copy, drop {
        circle_id: 0x2::object::ID,
        contributions_balance: u64,
        deposits_balance: u64,
        penalties_balance: u64,
        cycle: u64,
    }

    struct AutoSwapToggled has copy, drop {
        circle_id: 0x2::object::ID,
        enabled: bool,
        toggled_by: address,
    }

    struct MemberJoined has copy, drop {
        circle_id: 0x2::object::ID,
        member: address,
        position: 0x1::option::Option<u64>,
    }

    struct MemberActivated has copy, drop {
        circle_id: 0x2::object::ID,
        member: address,
        deposit_amount: u64,
    }

    struct StablecoinContributionMade has copy, drop {
        circle_id: 0x2::object::ID,
        member: address,
        amount: u64,
        cycle: u64,
        coin_type: 0x1::string::String,
    }

    struct CircleMaxMembersUpdated has copy, drop {
        circle_id: 0x2::object::ID,
        admin: address,
        old_max_members: u64,
        new_max_members: u64,
    }

    struct CyclePaused has copy, drop {
        circle_id: 0x2::object::ID,
        admin: address,
        cycle_completed: u64,
    }

    struct CycleResumed has copy, drop {
        circle_id: 0x2::object::ID,
        admin: address,
        new_cycle: u64,
    }

    struct MemberDepositsReset has copy, drop {
        circle_id: 0x2::object::ID,
        admin: address,
        cycle: u64,
        timestamp: u64,
    }

    struct AutomationStatus has copy, drop {
        is_overdue: bool,
        time_until_payout: u64,
        is_ready_for_payout: bool,
        all_members_contributed: bool,
        warning_level: u8,
    }

    struct AutomationTriggered has copy, drop {
        circle_id: 0x2::object::ID,
        automation_type: 0x1::string::String,
        triggered_at: u64,
        success: bool,
        details: 0x1::string::String,
    }

    struct PayoutOverdue has copy, drop {
        circle_id: 0x2::object::ID,
        overdue_duration_ms: u64,
        next_payout_time: u64,
        current_time: u64,
        all_contributed: bool,
    }

    struct AutomationFailed has copy, drop {
        circle_id: 0x2::object::ID,
        automation_type: 0x1::string::String,
        error_code: u64,
        error_message: 0x1::string::String,
        failed_at: u64,
        retry_count: u64,
    }

    struct PayoutWarning has copy, drop {
        circle_id: 0x2::object::ID,
        warning_level: u8,
        time_remaining_ms: u64,
        next_payout_time: u64,
        current_time: u64,
    }

    public fun get_contribution_amount(arg0: &Circle) : u64 {
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::from_decimals(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_contribution_amount(&arg0.id))
    }

    public fun get_contribution_amount_local(arg0: &Circle) : u64 {
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_contribution_amount_local(&arg0.id)
    }

    public fun get_contribution_amount_usd(arg0: &Circle) : u64 {
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_contribution_amount_usd(&arg0.id)
    }

    public fun get_currency_type(arg0: &Circle) : 0x1::string::String {
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_currency_type(&arg0.id)
    }

    public fun get_goal_type(arg0: &Circle) : u8 {
        let v0 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_goal_type(&arg0.id);
        if (0x1::option::is_some<u8>(&v0)) {
            *0x1::option::borrow<u8>(&v0)
        } else {
            0
        }
    }

    public fun get_security_deposit(arg0: &Circle) : u64 {
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::from_decimals(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_security_deposit(&arg0.id))
    }

    public fun get_security_deposit_local(arg0: &Circle) : u64 {
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_security_deposit_local(&arg0.id)
    }

    public fun get_security_deposit_usd(arg0: &Circle) : u64 {
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_security_deposit_usd(&arg0.id)
    }

    public fun get_target_amount(arg0: &Circle) : 0x1::option::Option<u64> {
        let v0 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_target_amount(&arg0.id);
        if (0x1::option::is_some<u64>(&v0)) {
            0x1::option::some<u64>(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::from_decimals(*0x1::option::borrow<u64>(&v0)))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun get_target_amount_local(arg0: &Circle) : 0x1::option::Option<u64> {
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_target_amount_local(&arg0.id)
    }

    public fun get_warning_penalty_amount(arg0: &Circle) : u64 {
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::from_decimals(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_warning_penalty_amount(&arg0.id))
    }

    public fun is_auto_swap_enabled(arg0: &Circle) : bool {
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::is_auto_swap_enabled(&arg0.id)
    }

    public fun toggle_auto_swap(arg0: &mut Circle, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin, 7);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::toggle_auto_swap(&mut arg0.id, arg1);
        let v1 = AutoSwapToggled{
            circle_id  : 0x2::object::uid_to_inner(&arg0.id),
            enabled    : arg1,
            toggled_by : v0,
        };
        0x2::event::emit<AutoSwapToggled>(v1);
    }

    public entry fun activate_circle(arg0: &mut Circle, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.admin, 7);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_max_members(&arg0.id);
        assert!(arg0.current_members >= 3, 22);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_security_deposit(&arg0.id);
        if (0x2::table::contains<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member>(&arg0.members, arg0.admin)) {
            assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::has_paid_deposit(0x2::table::borrow<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member>(&arg0.members, arg0.admin)), 21);
        };
        let v1 = &arg0.rotation_order;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(v1)) {
            let v3 = *0x1::vector::borrow<address>(v1, v2);
            if (v3 != arg0.admin && v3 != @0x0) {
                assert!(0x2::table::contains<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member>(&arg0.members, v3), 8);
                assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::has_paid_deposit(0x2::table::borrow<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member>(&arg0.members, v3)), 21);
            };
            v2 = v2 + 1;
        };
        arg0.is_active = true;
        arg0.next_payout_time = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::calculate_next_payout_time(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_cycle_length(&arg0.id), 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_cycle_day(&arg0.id), 0x2::tx_context::epoch_timestamp_ms(arg1));
        arg0.current_cycle = 1;
        let v4 = CircleActivated{
            circle_id    : 0x2::object::uid_to_inner(&arg0.id),
            activated_by : v0,
        };
        0x2::event::emit<CircleActivated>(v4);
    }

    public(friend) fun add_member(arg0: &mut Circle, arg1: address, arg2: 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member) {
        0x2::table::add<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member>(&mut arg0.members, arg1, arg2);
        arg0.current_members = arg0.current_members + 1;
    }

    public(friend) fun add_to_contributions(arg0: &mut Circle, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.contributions, arg1);
    }

    public(friend) fun add_to_contributions_this_cycle(arg0: &mut Circle, arg1: u64) {
        arg0.contributions_this_cycle = arg0.contributions_this_cycle + arg1;
    }

    public(friend) fun add_to_deposits(arg0: &mut Circle, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.deposits, arg1);
    }

    public(friend) fun add_to_penalties(arg0: &mut Circle, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.penalties, arg1);
    }

    public entry fun admin_approve_member(arg0: &mut Circle, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 7);
        assert!(!is_member(arg0, arg1), 5);
        assert!(arg0.current_members < 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_max_members(&arg0.id), 29);
        add_member(arg0, arg1, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::create_member(0x2::clock::timestamp_ms(arg2), 0x1::option::none<u64>(), 0, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::member_status_active()));
        let v0 = MemberJoined{
            circle_id : 0x2::object::uid_to_inner(&arg0.id),
            member    : arg1,
            position  : 0x1::option::none<u64>(),
        };
        0x2::event::emit<MemberJoined>(v0);
    }

    public entry fun admin_approve_members(arg0: &mut Circle, arg1: vector<address>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 7);
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(arg0.current_members + v0 <= 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_max_members(&arg0.id), 29);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<address>(&arg1, v1);
            if (!is_member(arg0, v2)) {
                add_member(arg0, v2, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::create_member(0x2::clock::timestamp_ms(arg2), 0x1::option::none<u64>(), 0, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::member_status_active()));
                let v3 = MemberJoined{
                    circle_id : 0x2::object::uid_to_inner(&arg0.id),
                    member    : v2,
                    position  : 0x1::option::none<u64>(),
                };
                0x2::event::emit<MemberJoined>(v3);
            };
            v1 = v1 + 1;
        };
    }

    public entry fun admin_set_max_members(arg0: &mut Circle, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin, 7);
        assert!(!arg0.is_active, 55);
        assert!(arg1 >= 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::get_min_members(), 56);
        assert!(arg1 >= arg0.current_members, 56);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::set_max_members(&mut arg0.id, arg1);
        let v1 = CircleMaxMembersUpdated{
            circle_id       : 0x2::object::uid_to_inner(&arg0.id),
            admin           : v0,
            old_max_members : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_max_members(&arg0.id),
            new_max_members : arg1,
        };
        0x2::event::emit<CircleMaxMembersUpdated>(v1);
    }

    public(friend) fun advance_rotation_position_and_cycle(arg0: &mut Circle, arg1: address, arg2: &0x2::clock::Clock) {
        0x1::vector::push_back<address>(&mut arg0.rotation_history, arg1);
        let v0 = 0x1::vector::length<address>(&arg0.rotation_order);
        let v1 = b"Advancing cycle...";
        0x1::debug::print<vector<u8>>(&v1);
        0x1::debug::print<u64>(&arg0.current_position);
        0x1::debug::print<u64>(&v0);
        0x1::debug::print<u64>(&arg0.current_cycle);
        reset_all_members_contribution_status(arg0);
        let v2 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_cycle_length(&arg0.id);
        let v3 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_cycle_day(&arg0.id);
        if (arg0.current_position + 1 >= v0) {
            arg0.paused_after_cycle = true;
            arg0.next_payout_time = 0x2::clock::timestamp_ms(arg2);
            let v4 = b"Cycle completed and paused. Admin needs to resume.";
            0x1::debug::print<vector<u8>>(&v4);
            let v5 = CyclePaused{
                circle_id       : 0x2::object::uid_to_inner(&arg0.id),
                admin           : arg0.admin,
                cycle_completed : arg0.current_cycle,
            };
            0x2::event::emit<CyclePaused>(v5);
        } else {
            arg0.current_position = arg0.current_position + 1;
            if (arg0.current_position == 0) {
                arg0.next_payout_time = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::calculate_next_payout_time(v2, v3, 0x2::clock::timestamp_ms(arg2));
            } else {
                let v6 = if (v2 == 0) {
                    0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::ms_per_day() * 7 / v0
                } else if (v2 == 3) {
                    0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::ms_per_day() * 14 / v0
                } else if (v2 == 1) {
                    0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::ms_per_day() * 30 / v0
                } else {
                    0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::ms_per_day() * 90 / v0
                };
                arg0.next_payout_time = arg0.next_payout_time + v6;
                if (v2 == 0 || v2 == 3) {
                    let v7 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::get_weekday(0x2::clock::timestamp_ms(arg2));
                    let v8 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::get_weekday(arg0.next_payout_time);
                    if (v8 != v3) {
                        let v9 = b"Weekday drift detected, recalculating to maintain cycle day";
                        0x1::debug::print<vector<u8>>(&v9);
                        0x1::debug::print<u64>(&v7);
                        0x1::debug::print<u64>(&v8);
                        0x1::debug::print<u64>(&v3);
                        let v10 = if (v3 >= v8) {
                            v3 - v8
                        } else {
                            7 - v8 - v3
                        };
                        let v11 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::get_day_ms(arg0.next_payout_time);
                        arg0.next_payout_time = arg0.next_payout_time - v11 + v10 * 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::ms_per_day() + v11;
                    };
                };
            };
            let v12 = b"Advanced position within cycle. New payout time set to:";
            0x1::debug::print<vector<u8>>(&v12);
            0x1::debug::print<u64>(&arg0.next_payout_time);
        };
        let v13 = b"New position:";
        0x1::debug::print<vector<u8>>(&v13);
        0x1::debug::print<u64>(&arg0.current_position);
        let v14 = b"New cycle:";
        0x1::debug::print<vector<u8>>(&v14);
        0x1::debug::print<u64>(&arg0.current_cycle);
    }

    public fun can_delete_circle(arg0: &Circle, arg1: &0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::CustodyWallet, arg2: address) : bool {
        if (arg0.admin != arg2) {
            return false
        };
        if (arg0.current_members > 1) {
            return false
        };
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.contributions) > 0) {
            return false
        };
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.deposits) > 0) {
            return false
        };
        if (0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::get_circle_id(arg1) != 0x2::object::uid_to_inner(&arg0.id)) {
            return false
        };
        if (0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::get_wallet_balance(arg1) > 0) {
            return false
        };
        if (0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::has_any_stablecoin_balance(arg1)) {
            return false
        };
        true
    }

    public entry fun contribute_stablecoin<T0>(arg0: &mut Circle, arg1: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::CustodyWallet, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(is_member(arg0, v0), 8);
        assert!(is_circle_active(arg0), 54);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::get_circle_id(arg1) == get_id(arg0), 46);
        let v1 = get_member(arg0, v0);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::get_status(v1) == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::member_status_active(), 14);
        let v2 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::get_suspension_end_time(v1);
        assert!(0x1::option::is_none<u64>(&v2), 13);
        let v3 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_contribution_amount_usd(&arg0.id) * 10000;
        assert!(0x2::coin::value<T0>(&arg2) >= v3, 1);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::deposit_contribution_coin<T0>(arg1, arg2, v0, arg3, arg4);
        let v4 = get_member_mut(arg0, v0);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::record_contribution(v4, v3, 0x2::clock::timestamp_ms(arg3));
        let v5 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::to_decimals(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_contribution_amount(&arg0.id));
        add_to_contributions_this_cycle(arg0, v5);
        let v6 = StablecoinContributionMade{
            circle_id : get_id(arg0),
            member    : v0,
            amount    : v3,
            cycle     : get_current_cycle(arg0),
            coin_type : 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))),
        };
        0x2::event::emit<StablecoinContributionMade>(v6);
    }

    public fun create_circle(arg0: vector<u8>, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u8, arg11: u64, arg12: u8, arg13: vector<bool>, arg14: 0x1::option::Option<u8>, arg15: 0x1::option::Option<u64>, arg16: 0x1::option::Option<u64>, arg17: 0x1::option::Option<u64>, arg18: bool, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x1::option::is_some<u64>(&arg15)) {
            0x1::option::some<u64>(*0x1::option::borrow<u64>(&arg15))
        } else {
            0x1::option::none<u64>()
        };
        assert!(arg11 >= 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::get_min_members() && arg11 <= 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::get_max_members(), 0);
        assert!(arg1 > 0, 1);
        assert!(arg5 >= 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::min_security_deposit(arg1), 2);
        assert!(arg8 <= 3, 3);
        let v1 = if (arg8 == 0 && arg9 < 7) {
            true
        } else if (arg8 == 3 && arg9 < 7) {
            true
        } else if (arg8 == 1 || arg8 == 2) {
            if (arg9 > 0) {
                arg9 <= 28
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 4);
        let v2 = 0x2::tx_context::sender(arg20);
        let v3 = 0x2::clock::timestamp_ms(arg19);
        let v4 = Circle{
            id                       : 0x2::object::new(arg20),
            name                     : 0x1::string::utf8(arg0),
            admin                    : v2,
            current_members          : 0,
            members                  : 0x2::table::new<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member>(arg20),
            contributions            : 0x2::balance::zero<0x2::sui::SUI>(),
            deposits                 : 0x2::balance::zero<0x2::sui::SUI>(),
            penalties                : 0x2::balance::zero<0x2::sui::SUI>(),
            current_cycle            : 0,
            next_payout_time         : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::calculate_next_payout_time(arg8, arg9, 0x2::clock::timestamp_ms(arg19)),
            created_at               : v3,
            rotation_order           : 0x1::vector::empty<address>(),
            rotation_history         : 0x1::vector::empty<address>(),
            current_position         : 0,
            active_auction           : 0x1::option::none<Auction>(),
            is_active                : false,
            contributions_this_cycle : 0,
            paused_after_cycle       : false,
        };
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::attach_circle_config(&mut v4.id, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::create_circle_config(arg1, arg5, 0x1::string::utf8(arg2), arg3, arg6, arg4, arg7, arg8, arg9, arg10, arg12, arg11, false));
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::attach_milestone_config(&mut v4.id, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::create_milestone_config(arg14, v0, arg16, arg17, arg18));
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::attach_penalty_rules(&mut v4.id, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::create_penalty_rules(arg13));
        let v5 = 0x2::object::uid_to_inner(&v4.id);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::create_custody_wallet(v5, v3, arg20);
        0x2::dynamic_field::add<0x1::string::String, 0x2::object::ID>(&mut v4.id, 0x1::string::utf8(b"wallet_id"), v5);
        let v6 = &mut v4;
        add_member(v6, v2, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::create_member(v3, 0x1::option::some<u64>(0), 0, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::member_status_active()));
        0x1::vector::push_back<address>(&mut v4.rotation_order, v2);
        let v7 = CircleCreated{
            circle_id                 : 0x2::object::uid_to_inner(&v4.id),
            admin                     : v2,
            name                      : 0x1::string::utf8(arg0),
            contribution_amount       : arg1,
            currency_type             : 0x1::string::utf8(arg2),
            contribution_amount_local : arg3,
            security_deposit_local    : arg6,
            max_members               : arg11,
            cycle_length              : arg8,
        };
        0x2::event::emit<CircleCreated>(v7);
        let v8 = MemberJoined{
            circle_id : 0x2::object::uid_to_inner(&v4.id),
            member    : v2,
            position  : 0x1::option::some<u64>(0),
        };
        0x2::event::emit<MemberJoined>(v8);
        0x2::transfer::share_object<Circle>(v4);
    }

    public fun cycle_length_in_milliseconds(arg0: &Circle) : u64 {
        let v0 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_cycle_length(&arg0.id);
        if (v0 == 0) {
            604800000
        } else if (v0 == 1) {
            2592000000
        } else if (v0 == 2) {
            2592000000 * 3
        } else if (v0 == 3) {
            604800000 * 2
        } else {
            2592000000
        }
    }

    public entry fun delete_circle(arg0: Circle, arg1: &0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::CustodyWallet, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 7);
        assert!(arg0.current_members <= 1, 5);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.contributions) == 0, 5);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.deposits) == 0, 5);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::get_circle_id(arg1) == 0x2::object::uid_to_inner(&arg0.id), 46);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::get_wallet_balance(arg1) == 0, 6);
        assert!(!0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::has_any_stablecoin_balance(arg1), 6);
        let v0 = 0x1::string::utf8(b"wallet_id");
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<0x1::string::String, 0x2::object::ID>(&mut arg0.id, v0);
        };
        if (arg0.current_members == 1 && 0x2::table::contains<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member>(&arg0.members, arg0.admin)) {
            if (0x2::balance::value<0x2::sui::SUI>(&arg0.deposits) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.deposits), arg2), arg0.admin);
            };
        };
        let v1 = CircleDeleted{
            circle_id : 0x2::object::uid_to_inner(&arg0.id),
            admin     : arg0.admin,
            name      : arg0.name,
        };
        0x2::event::emit<CircleDeleted>(v1);
        let Circle {
            id                       : v2,
            name                     : _,
            admin                    : _,
            current_members          : _,
            members                  : v6,
            contributions            : v7,
            deposits                 : v8,
            penalties                : v9,
            current_cycle            : _,
            next_payout_time         : _,
            created_at               : _,
            rotation_order           : _,
            rotation_history         : _,
            current_position         : _,
            active_auction           : _,
            is_active                : _,
            contributions_this_cycle : _,
            paused_after_cycle       : _,
        } = arg0;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v7);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v8);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v9);
        0x2::table::drop<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member>(v6);
        0x2::object::delete(v2);
    }

    public entry fun deposit_stablecoin_with_price_validation<T0>(arg0: &mut Circle, arg1: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::CustodyWallet, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(arg0.is_active, 54);
        assert!(0x2::table::contains<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member>(&arg0.members, v0), 8);
        if (arg3 == 0) {
            arg3 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_security_deposit(&arg0.id);
        };
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::internal_store_security_deposit<T0>(arg1, arg2, v0, arg3, arg4, arg5, arg6);
        update_member_status_after_deposit(arg0, v0, arg3, arg6);
    }

    public fun emit_automation_failed(arg0: &Circle, arg1: vector<u8>, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock) {
        let v0 = AutomationFailed{
            circle_id       : 0x2::object::uid_to_inner(&arg0.id),
            automation_type : 0x1::string::utf8(arg1),
            error_code      : arg2,
            error_message   : 0x1::string::utf8(arg3),
            failed_at       : 0x2::clock::timestamp_ms(arg5),
            retry_count     : arg4,
        };
        0x2::event::emit<AutomationFailed>(v0);
    }

    public fun emit_automation_triggered(arg0: &Circle, arg1: vector<u8>, arg2: bool, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        let v0 = AutomationTriggered{
            circle_id       : 0x2::object::uid_to_inner(&arg0.id),
            automation_type : 0x1::string::utf8(arg1),
            triggered_at    : 0x2::clock::timestamp_ms(arg4),
            success         : arg2,
            details         : 0x1::string::utf8(arg3),
        };
        0x2::event::emit<AutomationTriggered>(v0);
    }

    public fun emit_payout_overdue(arg0: &Circle, arg1: &0x2::clock::Clock) {
        let v0 = PayoutOverdue{
            circle_id           : 0x2::object::uid_to_inner(&arg0.id),
            overdue_duration_ms : get_overdue_duration(arg0, arg1),
            next_payout_time    : arg0.next_payout_time,
            current_time        : 0x2::clock::timestamp_ms(arg1),
            all_contributed     : has_all_members_contributed(arg0),
        };
        0x2::event::emit<PayoutOverdue>(v0);
    }

    public fun emit_payout_warning(arg0: &Circle, arg1: u8, arg2: &0x2::clock::Clock) {
        let v0 = PayoutWarning{
            circle_id         : 0x2::object::uid_to_inner(&arg0.id),
            warning_level     : arg1,
            time_remaining_ms : get_time_until_payout(arg0, arg2),
            next_payout_time  : arg0.next_payout_time,
            current_time      : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PayoutWarning>(v0);
    }

    public fun end_auction(arg0: &mut Circle) {
        arg0.active_auction = 0x1::option::none<Auction>();
    }

    public fun get_admin(arg0: &Circle) : address {
        arg0.admin
    }

    public fun get_auction_info(arg0: &Circle) : (u64, u64, 0x1::option::Option<address>, u64) {
        assert!(0x1::option::is_some<Auction>(&arg0.active_auction), 27);
        let v0 = 0x1::option::borrow<Auction>(&arg0.active_auction);
        (v0.position, v0.highest_bid, v0.highest_bidder, v0.end_time)
    }

    public fun get_automation_status(arg0: &Circle, arg1: &0x2::clock::Clock) : AutomationStatus {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = arg0.next_payout_time;
        let v2 = v0 > v1;
        let v3 = if (v2) {
            0
        } else {
            v1 - v0
        };
        let v4 = if (v2) {
            4
        } else if (v3 <= 3600000) {
            3
        } else if (v3 <= 21600000) {
            2
        } else if (v3 <= 86400000) {
            1
        } else {
            0
        };
        AutomationStatus{
            is_overdue              : v2,
            time_until_payout       : v3,
            is_ready_for_payout     : is_circle_ready_for_automated_payout(arg0, arg1),
            all_members_contributed : has_all_members_contributed(arg0),
            warning_level           : v4,
        }
    }

    public fun get_circle_members(arg0: &Circle) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        if (0x2::table::contains<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member>(&arg0.members, arg0.admin)) {
            0x1::vector::push_back<address>(&mut v0, arg0.admin);
        };
        let v1 = arg0.rotation_order;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v1)) {
            let v3 = *0x1::vector::borrow<address>(&v1, v2);
            if (v3 != @0x0 && !0x1::vector::contains<address>(&v0, &v3)) {
                0x1::vector::push_back<address>(&mut v0, v3);
            };
            v2 = v2 + 1;
        };
        let v4 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::get_sample_addresses();
        v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v4)) {
            let v5 = *0x1::vector::borrow<address>(&v4, v2);
            if (0x2::table::contains<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member>(&arg0.members, v5) && !0x1::vector::contains<address>(&v0, &v5)) {
                0x1::vector::push_back<address>(&mut v0, v5);
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun get_contribution_amount_raw(arg0: &Circle) : u64 {
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_contribution_amount(&arg0.id)
    }

    public fun get_contributions_this_cycle(arg0: &Circle) : u64 {
        arg0.contributions_this_cycle
    }

    public fun get_current_cycle(arg0: &Circle) : u64 {
        arg0.current_cycle
    }

    public fun get_current_position(arg0: &Circle) : u64 {
        arg0.current_position
    }

    public fun get_id(arg0: &Circle) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_member(arg0: &Circle, arg1: address) : &0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member {
        0x2::table::borrow<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member>(&arg0.members, arg1)
    }

    public fun get_member_count(arg0: &Circle) : u64 {
        arg0.current_members
    }

    public(friend) fun get_member_mut(arg0: &mut Circle, arg1: address) : &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member {
        0x2::table::borrow_mut<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member>(&mut arg0.members, arg1)
    }

    public(friend) fun get_members_table(arg0: &Circle) : &0x2::table::Table<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member> {
        &arg0.members
    }

    public(friend) fun get_members_table_mut(arg0: &mut Circle) : &mut 0x2::table::Table<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member> {
        &mut arg0.members
    }

    public fun get_name(arg0: &Circle) : 0x1::string::String {
        arg0.name
    }

    public fun get_next_payout_info(arg0: &Circle) : (u64, u64, u64) {
        let v0 = arg0.next_payout_time;
        let v1 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::get_weekday(v0);
        let v2 = if (0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_cycle_length(&arg0.id) == 0) {
            v1
        } else if (0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_cycle_length(&arg0.id) == 1) {
            0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::get_day_of_month(v0)
        } else {
            0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::get_day_of_quarter(v0)
        };
        (v0, v1, v2)
    }

    public fun get_next_payout_recipient(arg0: &Circle) : 0x1::option::Option<address> {
        let v0 = &arg0.rotation_order;
        let v1 = 0x1::vector::length<address>(v0);
        if (v1 == 0 || arg0.current_position >= v1) {
            return 0x1::option::none<address>()
        };
        let v2 = *0x1::vector::borrow<address>(v0, arg0.current_position);
        if (v2 == @0x0) {
            return 0x1::option::none<address>()
        };
        0x1::option::some<address>(v2)
    }

    public fun get_next_payout_time(arg0: &Circle) : u64 {
        arg0.next_payout_time
    }

    public fun get_overdue_duration(arg0: &Circle, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = arg0.next_payout_time;
        if (v0 <= v1) {
            0
        } else {
            v0 - v1
        }
    }

    public fun get_rotation_order(arg0: &Circle) : vector<address> {
        arg0.rotation_order
    }

    public fun get_security_deposit_amount(arg0: &Circle) : u64 {
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_security_deposit(&arg0.id)
    }

    public fun get_time_until_payout(arg0: &Circle, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = arg0.next_payout_time;
        if (v0 >= v1) {
            0
        } else {
            v1 - v0
        }
    }

    public fun get_treasury_balances(arg0: &Circle) : (u64, u64, u64) {
        (0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::from_decimals(0x2::balance::value<0x2::sui::SUI>(&arg0.contributions)), 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::from_decimals(0x2::balance::value<0x2::sui::SUI>(&arg0.deposits)), 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::from_decimals(0x2::balance::value<0x2::sui::SUI>(&arg0.penalties)))
    }

    public fun get_wallet_id(arg0: &Circle) : 0x1::option::Option<0x2::object::ID> {
        let v0 = 0x1::string::utf8(b"wallet_id");
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            0x1::option::some<0x2::object::ID>(*0x2::dynamic_field::borrow<0x1::string::String, 0x2::object::ID>(&arg0.id, v0))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun get_warning_level(arg0: &Circle, arg1: &0x2::clock::Clock) : u8 {
        let v0 = get_time_until_payout(arg0, arg1);
        if (v0 == 0) {
            4
        } else if (v0 <= 3600000) {
            3
        } else if (v0 <= 21600000) {
            2
        } else if (v0 <= 86400000) {
            1
        } else {
            0
        }
    }

    public fun has_active_auction(arg0: &Circle) : bool {
        0x1::option::is_some<Auction>(&arg0.active_auction)
    }

    public fun has_all_members_contributed(arg0: &Circle) : bool {
        let v0 = 0;
        let v1 = &arg0.rotation_order;
        let v2 = 0x1::vector::length<address>(v1);
        let v3 = 0;
        let v4 = if (arg0.current_position < v2) {
            *0x1::vector::borrow<address>(v1, arg0.current_position)
        } else {
            @0x0
        };
        let v5 = false;
        while (v3 < v2) {
            let v6 = *0x1::vector::borrow<address>(v1, v3);
            if (v6 != @0x0 && 0x2::table::contains<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member>(&arg0.members, v6)) {
                if (0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::get_status(0x2::table::borrow<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member>(&arg0.members, v6)) == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::member_status_active()) {
                    v0 = v0 + 1;
                    if (v6 == v4) {
                        v5 = true;
                    };
                };
            };
            v3 = v3 + 1;
        };
        if (v0 == 0) {
            return true
        };
        let v7 = if (v5) {
            v0 - 1
        } else {
            v0
        };
        arg0.contributions_this_cycle >= 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_contribution_amount(&arg0.id) * v7
    }

    public fun has_goal_type(arg0: &Circle) : bool {
        let v0 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_goal_type(&arg0.id);
        0x1::option::is_some<u8>(&v0)
    }

    public fun has_valid_rotation(arg0: &Circle) : bool {
        let v0 = 0x1::vector::length<address>(&arg0.rotation_order);
        v0 > 0 && arg0.current_position < v0
    }

    public fun is_circle_active(arg0: &Circle) : bool {
        arg0.is_active
    }

    public fun is_circle_ready_for_automated_payout(arg0: &Circle, arg1: &0x2::clock::Clock) : bool {
        if (!arg0.is_active) {
            return false
        };
        if (arg0.paused_after_cycle) {
            return false
        };
        if (!is_payout_overdue(arg0, arg1)) {
            return false
        };
        if (!has_all_members_contributed(arg0)) {
            return false
        };
        true
    }

    public fun is_member(arg0: &Circle, arg1: address) : bool {
        0x2::table::contains<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member>(&arg0.members, arg1)
    }

    public fun is_paused_after_cycle(arg0: &Circle) : bool {
        arg0.paused_after_cycle
    }

    public fun is_payout_overdue(arg0: &Circle, arg1: &0x2::clock::Clock) : bool {
        if (!arg0.is_active) {
            return false
        };
        if (arg0.paused_after_cycle) {
            return false
        };
        0x2::clock::timestamp_ms(arg1) > arg0.next_payout_time
    }

    public fun manage_treasury_balances(arg0: &mut Circle, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 7);
        assert!(arg0.is_active, 54);
        let v0 = TreasuryUpdated{
            circle_id             : 0x2::object::uid_to_inner(&arg0.id),
            contributions_balance : 0x2::balance::value<0x2::sui::SUI>(&arg0.contributions),
            deposits_balance      : 0x2::balance::value<0x2::sui::SUI>(&arg0.deposits),
            penalties_balance     : 0x2::balance::value<0x2::sui::SUI>(&arg0.penalties),
            cycle                 : arg0.current_cycle,
        };
        0x2::event::emit<TreasuryUpdated>(v0);
    }

    public entry fun member_deposit_security_deposit<T0>(arg0: &mut Circle, arg1: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::CustodyWallet, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<T0>(&arg2);
        let v2 = arg0.admin;
        let v3 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_security_deposit(&arg0.id);
        let v4 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_security_deposit_usd(&arg0.id);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::get_circle_id(arg1) == get_id(arg0), 46);
        assert!(is_member(arg0, v0), 8);
        let v5 = get_member_mut(arg0, v0);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::get_status(v5) == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::member_status_active() || v0 == v2, 14);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::get_deposit_balance(v5) == 0, 21);
        if (0x1::type_name::get<T0>() == 0x1::type_name::get<0x2::sui::SUI>()) {
            assert!(v1 == v3, 2);
        } else {
            assert!(v1 == v4 * 10000, 2);
        };
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::set_deposit_balance(v5, v1);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::set_deposit_paid(v5, true);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::internal_store_security_deposit_without_validation<T0>(arg1, arg2, v0, arg3, arg4);
    }

    public fun process_member_deposit(arg0: &mut Circle, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : bool {
        assert!(is_member(arg0, arg2), 8);
        let v0 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_security_deposit(&arg0.id);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_security_deposit_usd(&arg0.id);
        let v1 = get_member_mut(arg0, arg2);
        assert!(arg1 >= v0, 2);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::set_deposit_balance(v1, arg1);
        let v2 = MemberActivated{
            circle_id      : 0x2::object::uid_to_inner(&arg0.id),
            member         : arg2,
            deposit_amount : arg1,
        };
        0x2::event::emit<MemberActivated>(v2);
        true
    }

    public fun process_member_exit(arg0: &mut Circle, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : bool {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 7);
        assert!(is_member(arg0, arg1), 8);
        0x2::table::contains<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member>(&arg0.members, arg1) && 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::process_member_exit(0x2::table::borrow_mut<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member>(&mut arg0.members, arg1), 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_contribution_amount(&arg0.id))
    }

    public fun reorder_rotation_positions(arg0: &mut Circle, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 7);
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 <= 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_max_members(&arg0.id), 29);
        let v1 = 0;
        while (v1 < v0) {
            assert!(0x2::table::contains<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member>(&arg0.members, *0x1::vector::borrow<address>(&arg1, v1)), 8);
            v1 = v1 + 1;
        };
        arg0.rotation_order = arg1;
        let v2 = 0;
        while (v2 < v0) {
            0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::set_payout_position(0x2::table::borrow_mut<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member>(&mut arg0.members, *0x1::vector::borrow<address>(&arg0.rotation_order, v2)), 0x1::option::some<u64>(v2));
            v2 = v2 + 1;
        };
    }

    public entry fun reorder_rotation_positions_entry(arg0: &mut Circle, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        reorder_rotation_positions(arg0, arg1, arg2);
    }

    public(friend) fun reset_all_members_contribution_status(arg0: &mut Circle) {
        arg0.contributions_this_cycle = 0;
        let v0 = b"Reset contributions counter to 0";
        0x1::debug::print<vector<u8>>(&v0);
        let v1 = &arg0.rotation_order;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(v1)) {
            let v3 = *0x1::vector::borrow<address>(v1, v2);
            if (v3 != @0x0 && 0x2::table::contains<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member>(&arg0.members, v3)) {
                if (v2 != arg0.current_position) {
                    0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::reset_contribution_status(0x2::table::borrow_mut<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member>(&mut arg0.members, v3));
                    let v4 = b"Reset contribution status for member:";
                    0x1::debug::print<vector<u8>>(&v4);
                    0x1::debug::print<address>(&v3);
                };
            };
            v2 = v2 + 1;
        };
    }

    public(friend) fun reset_all_members_deposit_status(arg0: &mut Circle, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = &arg0.rotation_order;
        let v1 = 0x1::vector::length<address>(v0);
        let v2 = 0;
        0x1::debug::print<u64>(&v1);
        let v3 = b"Resetting deposit status for all members";
        0x1::debug::print<vector<u8>>(&v3);
        while (v2 < v1) {
            let v4 = *0x1::vector::borrow<address>(v0, v2);
            if (v4 != @0x0 && 0x2::table::contains<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member>(&arg0.members, v4)) {
                0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::set_deposit_paid(0x2::table::borrow_mut<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member>(&mut arg0.members, v4), false);
                0x1::debug::print<address>(&v4);
                let v5 = b"Set deposit status to false";
                0x1::debug::print<vector<u8>>(&v5);
            };
            v2 = v2 + 1;
        };
        let v6 = MemberDepositsReset{
            circle_id : 0x2::object::uid_to_inner(&arg0.id),
            admin     : arg0.admin,
            cycle     : arg0.current_cycle,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<MemberDepositsReset>(v6);
    }

    public(friend) fun reset_all_members_payout_status(arg0: &mut Circle) {
        let v0 = &arg0.rotation_order;
        let v1 = 0x1::vector::length<address>(v0);
        let v2 = 0;
        0x1::debug::print<u64>(&v1);
        let v3 = b"Resetting payout status for all members";
        0x1::debug::print<vector<u8>>(&v3);
        while (v2 < v1) {
            let v4 = *0x1::vector::borrow<address>(v0, v2);
            if (v4 != @0x0 && 0x2::table::contains<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member>(&arg0.members, v4)) {
                0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::set_received_payout(0x2::table::borrow_mut<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member>(&mut arg0.members, v4), false);
                0x1::debug::print<address>(&v4);
                let v5 = b"Set payout status to false";
                0x1::debug::print<vector<u8>>(&v5);
            };
            v2 = v2 + 1;
        };
    }

    public(friend) fun reset_contributions_this_cycle(arg0: &mut Circle) {
        arg0.contributions_this_cycle = 0;
    }

    public entry fun resume_cycle(arg0: &mut Circle, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 7);
        assert!(arg0.is_active, 54);
        assert!(arg0.paused_after_cycle, 57);
        arg0.current_position = 0;
        arg0.current_cycle = arg0.current_cycle + 1;
        reset_all_members_payout_status(arg0);
        reset_all_members_deposit_status(arg0, arg2);
        arg0.next_payout_time = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::calculate_next_payout_time(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_cycle_length(&arg0.id), 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_cycle_day(&arg0.id), 0x2::clock::timestamp_ms(arg1));
        arg0.paused_after_cycle = false;
        let v0 = CycleResumed{
            circle_id : 0x2::object::uid_to_inner(&arg0.id),
            admin     : arg0.admin,
            new_cycle : arg0.current_cycle,
        };
        0x2::event::emit<CycleResumed>(v0);
        let v1 = b"Cycle resumed. Starting new cycle:";
        0x1::debug::print<vector<u8>>(&v1);
        0x1::debug::print<u64>(&arg0.current_cycle);
    }

    public(friend) fun set_current_position(arg0: &mut Circle, arg1: u64) {
        assert!(arg1 < 0x1::vector::length<address>(&arg0.rotation_order), 29);
        arg0.current_position = arg1;
    }

    public fun set_rotation_position(arg0: &mut Circle, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 7);
        assert!(arg2 < 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_max_members(&arg0.id), 29);
        assert!(0x2::table::contains<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member>(&arg0.members, arg1), 8);
        if (arg2 >= 0x1::vector::length<address>(&arg0.rotation_order)) {
            while (0x1::vector::length<address>(&arg0.rotation_order) < arg2) {
                0x1::vector::push_back<address>(&mut arg0.rotation_order, @0x0);
            };
            0x1::vector::push_back<address>(&mut arg0.rotation_order, arg1);
        } else {
            let v0 = @0x0;
            assert!(0x1::vector::borrow<address>(&arg0.rotation_order, arg2) == &v0 || 0x1::vector::borrow<address>(&arg0.rotation_order, arg2) == &arg1, 30);
            *0x1::vector::borrow_mut<address>(&mut arg0.rotation_order, arg2) = arg1;
        };
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::set_payout_position(0x2::table::borrow_mut<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member>(&mut arg0.members, arg1), 0x1::option::some<u64>(arg2));
    }

    public fun should_send_warning(arg0: &Circle, arg1: &0x2::clock::Clock, arg2: u64) : bool {
        if (!arg0.is_active || arg0.paused_after_cycle) {
            return false
        };
        let v0 = get_time_until_payout(arg0, arg1);
        v0 > 0 && v0 <= arg2 * 3600000
    }

    public(friend) fun split_from_contributions(arg0: &mut Circle, arg1: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.contributions, arg1)
    }

    public(friend) fun split_from_deposits(arg0: &mut Circle, arg1: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.deposits, arg1)
    }

    public fun start_auction(arg0: &mut Circle, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = Auction{
            position       : arg1,
            minimum_bid    : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::to_decimals(arg2),
            highest_bid    : 0,
            highest_bidder : 0x1::option::none<address>(),
            start_time     : arg5,
            end_time       : arg5 + arg3 * 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::ms_per_day(),
            discount_rate  : arg4,
        };
        arg0.active_auction = 0x1::option::some<Auction>(v0);
    }

    public fun update_auction_bid(arg0: &mut Circle, arg1: u64, arg2: address) {
        assert!(0x1::option::is_some<Auction>(&arg0.active_auction), 27);
        let v0 = 0x1::option::borrow_mut<Auction>(&mut arg0.active_auction);
        v0.highest_bid = arg1;
        v0.highest_bidder = 0x1::option::some<address>(arg2);
    }

    public fun update_cycle(arg0: &mut Circle, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 7);
        assert!(arg0.is_active, 54);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.next_payout_time) {
            arg0.current_cycle = arg0.current_cycle + 1;
            arg0.next_payout_time = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::calculate_next_payout_time(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_cycle_length(&arg0.id), 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_cycle_day(&arg0.id), v0);
        };
    }

    fun update_member_status_after_deposit(arg0: &mut Circle, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<address, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::Member>(&mut arg0.members, arg1);
        if (0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circle_config::get_security_deposit(&arg0.id) <= arg2) {
            if (0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::get_status(v0) == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::member_status_pending()) {
                0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::set_status(v0, 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::member_status_active());
                0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::set_activated_at(v0, 0x2::tx_context::epoch_timestamp_ms(arg3));
                0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::set_deposit_balance(v0, arg2);
                let v1 = MemberActivated{
                    circle_id      : 0x2::object::uid_to_inner(&arg0.id),
                    member         : arg1,
                    deposit_amount : arg2,
                };
                0x2::event::emit<MemberActivated>(v1);
            };
        };
    }

    public entry fun update_wallet_id(arg0: &mut Circle, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 7);
        let v0 = 0x1::string::utf8(b"wallet_id");
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::object::ID>(&mut arg0.id, v0) = arg1;
        } else {
            0x2::dynamic_field::add<0x1::string::String, 0x2::object::ID>(&mut arg0.id, v0, arg1);
        };
    }

    // decompiled from Move bytecode v6
}

