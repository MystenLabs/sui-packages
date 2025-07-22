module 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_payments {
    struct ContributionMade has copy, drop {
        circle_id: 0x2::object::ID,
        member: address,
        amount: u64,
        cycle: u64,
    }

    struct PayoutProcessed has copy, drop {
        circle_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        cycle: u64,
        payout_type: u8,
    }

    struct PayoutDebugInfo has copy, drop {
        wallet_balance: u64,
        contribution_amount: u64,
        member_count: u64,
        payout_amount: u64,
        payout_reason: 0x1::string::String,
    }

    struct AuctionStarted has copy, drop {
        circle_id: 0x2::object::ID,
        position: u64,
        minimum_bid: u64,
        end_time: u64,
    }

    struct BidPlaced has copy, drop {
        circle_id: 0x2::object::ID,
        bidder: address,
        amount: u64,
        position: u64,
    }

    struct AuctionCompleted has copy, drop {
        circle_id: 0x2::object::ID,
        winner: address,
        position: u64,
        winning_bid: u64,
    }

    struct MilestoneCompleted has copy, drop {
        circle_id: 0x2::object::ID,
        milestone_number: u64,
        verified_by: address,
        amount_achieved: u64,
    }

    struct MilestoneVerificationSubmitted has copy, drop {
        circle_id: 0x2::object::ID,
        milestone_number: u64,
        submitted_by: address,
        proof_type: u8,
        timestamp: u64,
    }

    struct SecurityDepositReturned has copy, drop {
        circle_id: 0x2::object::ID,
        wallet_id: 0x2::object::ID,
        member: address,
        amount: u64,
        coin_type: 0x1::string::String,
        timestamp: u64,
    }

    struct PayoutWindow has drop, store {
        start_time: u64,
        end_time: u64,
        recipient: address,
        amount: u64,
    }

    public fun add_monetary_milestone(arg0: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::Circle, arg1: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_milestones::MilestoneData, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: vector<u64>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg8) == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_admin(arg0), 7);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::is_circle_active(arg0), 54);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::has_goal_type(arg0), 28);
        assert!(arg2 > 0, 32);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_milestones::add_monetary_milestone(arg1, arg2, arg3, arg4, arg5, arg6, 0x2::clock::timestamp_ms(arg7));
    }

    public fun add_time_milestone(arg0: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::Circle, arg1: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_milestones::MilestoneData, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_admin(arg0), 7);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::is_circle_active(arg0), 54);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::has_goal_type(arg0), 28);
        assert!(arg2 > 0, 32);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_milestones::add_time_milestone(arg1, arg2, arg3, arg4, 0x2::clock::timestamp_ms(arg5));
    }

    public fun submit_milestone_verification(arg0: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::Circle, arg1: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_milestones::MilestoneData, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::is_circle_active(arg0), 54);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::tx_context::sender(arg5);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_milestones::submit_milestone_verification(arg1, arg2, arg3, v0, v1);
        let v2 = MilestoneVerificationSubmitted{
            circle_id        : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_id(arg0),
            milestone_number : arg2,
            submitted_by     : v1,
            proof_type       : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_milestones::get_milestone_verification_type(arg1, arg2, 0),
            timestamp        : v0,
        };
        0x2::event::emit<MilestoneVerificationSubmitted>(v2);
    }

    public fun verify_milestone(arg0: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::Circle, arg1: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_milestones::MilestoneData, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_admin(arg0), 7);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::is_circle_active(arg0), 54);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_milestones::verify_milestone(arg1, arg0, arg2, 0x2::clock::timestamp_ms(arg3), v0);
        let v1 = MilestoneCompleted{
            circle_id        : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_id(arg0),
            milestone_number : arg2,
            verified_by      : v0,
            amount_achieved  : 0,
        };
        0x2::event::emit<MilestoneCompleted>(v1);
    }

    public entry fun admin_force_payout(arg0: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::Circle, arg1: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::CustodyWallet, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_admin(arg0), 7);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::is_circle_active(arg0), 54);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::is_member(arg0, arg2), 8);
        assert!(!0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::has_received_payout(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_member(arg0, arg2)), 23);
        let v0 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_contribution_amount(arg0);
        let v1 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_member_count(arg0);
        let v2 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::to_decimals(v0) * v1;
        let v3 = v2;
        let v4 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::get_raw_balance(arg1);
        assert!(v4 > 0, 25);
        if (v4 < v2) {
            v3 = v4;
        };
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::set_received_payout(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_member_mut(arg0, arg2), true);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::withdraw(arg1, v3, arg4), arg2);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::reset_contributions_this_cycle(arg0);
        let v5 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_rotation_order(arg0);
        let v6 = 0;
        let v7 = false;
        let v8 = 0;
        while (v8 < 0x1::vector::length<address>(&v5)) {
            if (*0x1::vector::borrow<address>(&v5, v8) == arg2) {
                v6 = v8;
                v7 = true;
                break
            };
            v8 = v8 + 1;
        };
        if (v7) {
            0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::set_current_position(arg0, v6);
            0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::advance_rotation_position_and_cycle(arg0, arg2, arg3);
        };
        let v9 = PayoutProcessed{
            circle_id   : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_id(arg0),
            recipient   : arg2,
            amount      : v0 * v1,
            cycle       : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_current_cycle(arg0),
            payout_type : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_goal_type(arg0),
        };
        0x2::event::emit<PayoutProcessed>(v9);
    }

    public entry fun admin_payout_security_deposit_stablecoin<T0>(arg0: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::Circle, arg1: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::CustodyWallet, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_admin(arg0), 7);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::is_paused_after_cycle(arg0), 58);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::is_member(arg0, arg2), 8);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::get_circle_id(arg1) == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_id(arg0), 46);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::is_wallet_active(arg1), 43);
        let v0 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_member(arg0, arg2);
        let v1 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::get_deposit_balance(v0);
        assert!(v1 > 0, 59);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::has_paid_deposit(v0), 60);
        let v2 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_member_mut(arg0, arg2);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::set_deposit_paid(v2, false);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::set_deposit_balance(v2, 0);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::get_stablecoin_balance<T0>(arg1) >= v1, 25);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::withdraw_stablecoin<T0>(arg1, v1, arg2, arg3, arg4), arg2);
        let v3 = SecurityDepositReturned{
            circle_id : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_id(arg0),
            wallet_id : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::get_circle_id(arg1),
            member    : arg2,
            amount    : v1,
            coin_type : 0x1::string::utf8(b"stablecoin"),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<SecurityDepositReturned>(v3);
    }

    public entry fun admin_payout_security_deposit_sui(arg0: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::Circle, arg1: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::CustodyWallet, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_admin(arg0), 7);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::is_paused_after_cycle(arg0), 58);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::is_member(arg0, arg2), 8);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::get_circle_id(arg1) == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_id(arg0), 46);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::is_wallet_active(arg1), 43);
        let v0 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_member(arg0, arg2);
        let v1 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::get_deposit_balance(v0);
        assert!(v1 > 0, 59);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::has_paid_deposit(v0), 60);
        let v2 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_member_mut(arg0, arg2);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::set_deposit_paid(v2, false);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::set_deposit_balance(v2, 0);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::get_total_wallet_balance(arg1) >= v1, 25);
        let v3 = if (0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::has_stablecoin_balance<0x2::sui::SUI>(arg1)) {
            if (0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::get_stablecoin_balance<0x2::sui::SUI>(arg1) >= v1) {
                0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::withdraw_from_dynamic_fields(arg1, v1, arg3)
            } else {
                0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::withdraw(arg1, v1, arg3)
            }
        } else {
            0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::withdraw(arg1, v1, arg3)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, arg2);
        let v4 = SecurityDepositReturned{
            circle_id : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_id(arg0),
            wallet_id : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::get_circle_id(arg1),
            member    : arg2,
            amount    : v1,
            coin_type : 0x1::string::utf8(b"sui"),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<SecurityDepositReturned>(v4);
    }

    public entry fun admin_trigger_payout(arg0: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::Circle, arg1: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::CustodyWallet, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_admin(arg0), 7);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::is_circle_active(arg0), 54);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::has_all_members_contributed(arg0), 56);
        trigger_automatic_payout(arg0, arg1, arg2, arg3);
    }

    public entry fun admin_trigger_usdc_payout<T0>(arg0: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::Circle, arg1: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::CustodyWallet, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_admin(arg0), 7);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::is_circle_active(arg0), 54);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::has_all_members_contributed(arg0), 56);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::has_stablecoin_balance<T0>(arg1), 37);
        let v0 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_next_payout_recipient(arg0);
        assert!(0x1::option::is_some<address>(&v0), 29);
        let v1 = *0x1::option::borrow<address>(&v0);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::is_member(arg0, v1), 8);
        assert!(!0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::has_received_payout(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_member(arg0, v1)), 23);
        let v2 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_contribution_amount_usd(arg0);
        let v3 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_member_count(arg0);
        let v4 = 10000;
        let v5 = v2 * v4 * v3;
        let v6 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::get_stablecoin_balance<T0>(arg1);
        let v7 = b"Current next_payout_time BEFORE update:";
        0x1::debug::print<vector<u8>>(&v7);
        let v8 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_next_payout_time(arg0);
        0x1::debug::print<u64>(&v8);
        let v9 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_security_deposit_usd(arg0) * v4 * v3;
        let v10 = if (v6 > v9) {
            v6 - v9
        } else {
            0
        };
        assert!(v10 > 0, 25);
        let v11 = if (v5 <= v10) {
            v5
        } else {
            v10
        };
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::set_received_payout(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_member_mut(arg0, v1), true);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::withdraw_stablecoin<T0>(arg1, v11, v1, arg2, arg3), v1);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::reset_contributions_this_cycle(arg0);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::advance_rotation_position_and_cycle(arg0, v1, arg2);
        let v12 = b"Current next_payout_time AFTER update:";
        0x1::debug::print<vector<u8>>(&v12);
        let v13 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_next_payout_time(arg0);
        0x1::debug::print<u64>(&v13);
        let v14 = PayoutProcessed{
            circle_id   : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_id(arg0),
            recipient   : v1,
            amount      : v2,
            cycle       : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_current_cycle(arg0),
            payout_type : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_goal_type(arg0),
        };
        0x2::event::emit<PayoutProcessed>(v14);
    }

    public fun complete_auction(arg0: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::Circle, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_admin(arg0), 7);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::is_circle_active(arg0), 54);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::has_active_auction(arg0), 27);
        let (v0, v1, v2, v3) = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_auction_info(arg0);
        let v4 = v2;
        assert!(0x2::clock::timestamp_ms(arg1) > v3, 27);
        if (0x1::option::is_some<address>(&v4)) {
            let v5 = *0x1::option::borrow<address>(&v4);
            0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::set_rotation_position(arg0, v5, v0, arg2);
            let v6 = AuctionCompleted{
                circle_id   : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_id(arg0),
                winner      : v5,
                position    : v0,
                winning_bid : v1,
            };
            0x2::event::emit<AuctionCompleted>(v6);
        };
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::end_auction(arg0);
    }

    public fun contribute(arg0: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::Circle, arg1: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::CustodyWallet, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::is_member(arg0, v0), 8);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::is_circle_active(arg0), 54);
        let v1 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_contribution_amount(arg0);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v2 >= v1, 1);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::get_circle_id(arg1) == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_id(arg0), 46);
        let v3 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_member(arg0, v0);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::get_status(v3) == 0, 14);
        let v4 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::get_suspension_end_time(v3);
        assert!(0x1::option::is_none<u64>(&v4), 13);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::deposit(arg1, arg2, arg4);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::record_contribution(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_member_mut(arg0, v0), v1, 0x2::clock::timestamp_ms(arg3));
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::add_to_contributions_this_cycle(arg0, v2);
        let v5 = ContributionMade{
            circle_id : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_id(arg0),
            member    : v0,
            amount    : v2,
            cycle     : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_current_cycle(arg0),
        };
        0x2::event::emit<ContributionMade>(v5);
    }

    public fun place_bid(arg0: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::Circle, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::is_circle_active(arg0), 54);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::has_active_auction(arg0), 27);
        let v0 = 0x2::tx_context::sender(arg3);
        let (v1, v2, v3, v4) = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_auction_info(arg0);
        let v5 = v3;
        assert!(0x2::clock::timestamp_ms(arg2) <= v4, 27);
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v6 > v2, 26);
        if (0x1::option::is_some<address>(&v5)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::split_from_contributions(arg0, v2), arg3), *0x1::option::borrow<address>(&v5));
        };
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::update_auction_bid(arg0, v6, v0);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::add_to_contributions(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v7 = BidPlaced{
            circle_id : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_id(arg0),
            bidder    : v0,
            amount    : v6,
            position  : v1,
        };
        0x2::event::emit<BidPlaced>(v7);
    }

    public fun process_custody_payout(arg0: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::Circle, arg1: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::CustodyWallet, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(0x2::tx_context::sender(arg4) == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_admin(arg0), 7);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::is_circle_active(arg0), 54);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::get_circle_id(arg1) == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_id(arg0), 46);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::is_wallet_active(arg1), 43);
        if (0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::is_wallet_locked(arg1)) {
            assert!(v0 >= 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::get_lock_time(arg1), 44);
        };
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::is_member(arg0, arg2), 8);
        let v1 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_member(arg0, arg2);
        assert!(v0 >= 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_next_payout_time(arg0), 24);
        assert!(!0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::has_received_payout(v1), 23);
        let v2 = if (0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::has_goal_type(arg0)) {
            let (v3, _, _) = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_treasury_balances(arg0);
            0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::get_total_contributed(v1) * v3 / 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_contribution_amount(arg0) * 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_member_count(arg0)
        } else {
            0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_contribution_amount(arg0) * 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_member_count(arg0)
        };
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::get_balance(arg1) >= v2, 12);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::check_withdrawal_limit(arg1, v2), 45);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::set_received_payout(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_member_mut(arg0, arg2), true);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::withdraw(arg1, v2, arg4), arg2);
        let v6 = PayoutProcessed{
            circle_id   : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_id(arg0),
            recipient   : arg2,
            amount      : v2,
            cycle       : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_current_cycle(arg0),
            payout_type : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_goal_type(arg0),
        };
        0x2::event::emit<PayoutProcessed>(v6);
    }

    public fun process_scheduled_payout(arg0: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::Circle, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_admin(arg0), 7);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::is_member(arg0, arg1), 8);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::is_circle_active(arg0), 54);
        assert!(0x2::clock::timestamp_ms(arg2) >= 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_next_payout_time(arg0), 24);
        let v0 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_member(arg0, arg1);
        assert!(!0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::has_received_payout(v0), 23);
        let (v1, _, _) = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_treasury_balances(arg0);
        let v4 = if (0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::has_goal_type(arg0)) {
            0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::get_total_contributed(v0) * v1 / 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_contribution_amount(arg0) * 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_member_count(arg0)
        } else {
            0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_contribution_amount(arg0) * 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_member_count(arg0)
        };
        assert!(v1 >= v4, 25);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::set_received_payout(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_member_mut(arg0, arg1), true);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::split_from_contributions(arg0, v4), arg3), arg1);
        let v5 = PayoutProcessed{
            circle_id   : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_id(arg0),
            recipient   : arg1,
            amount      : v4,
            cycle       : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_current_cycle(arg0),
            payout_type : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_goal_type(arg0),
        };
        0x2::event::emit<PayoutProcessed>(v5);
    }

    public fun process_security_deposit_return(arg0: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::Circle, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_admin(arg0), 7);
        assert!(!0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::is_circle_active(arg0), 54);
        let v0 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_member(arg0, arg1);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::get_total_contributed(v0) >= 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_contribution_amount(arg0) * 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::get_total_meetings_required(v0), 18);
        let v1 = if (0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::get_warning_count(v0) == 0 && 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::get_reputation_score(v0) >= 80) {
            0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::get_deposit_balance(v0)
        } else {
            0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::get_deposit_balance(v0) * (0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::get_reputation_score(v0) as u64) / 100
        };
        assert!(v1 > 0 && v1 <= 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::get_deposit_balance(v0), 22);
        let (_, v3, _) = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_treasury_balances(arg0);
        assert!(v3 >= v1, 25);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::subtract_from_deposit_balance(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_member_mut(arg0, arg1), v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::split_from_deposits(arg0, v1), arg2), arg1);
    }

    public fun start_position_auction(arg0: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::Circle, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_admin(arg0), 7);
        assert!(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::is_circle_active(arg0), 54);
        assert!(!0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::has_active_auction(arg0), 27);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::start_auction(arg0, arg1, arg2, arg3, arg4, 0x2::clock::timestamp_ms(arg5));
        let v0 = AuctionStarted{
            circle_id   : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_id(arg0),
            position    : arg1,
            minimum_bid : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::to_decimals(arg2),
            end_time    : 0x2::clock::timestamp_ms(arg5) + arg3 * 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::ms_per_day(),
        };
        0x2::event::emit<AuctionStarted>(v0);
    }

    fun trigger_automatic_payout(arg0: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::Circle, arg1: &mut 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::CustodyWallet, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_next_payout_recipient(arg0);
        if (0x1::option::is_none<address>(&v0)) {
            return
        };
        let v1 = *0x1::option::borrow<address>(&v0);
        if (!0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::is_member(arg0, v1)) {
            return
        };
        if (0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::has_received_payout(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_member(arg0, v1))) {
            return
        };
        let v2 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_member_count(arg0);
        let v3 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_contribution_amount_raw(arg0);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_contribution_amount_local(arg0);
        let v4 = if (v2 > 0) {
            v2 - 1
        } else {
            0
        };
        let v5 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::get_raw_balance(arg1);
        if (0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::has_any_stablecoin_balance(arg1) && v5 < v3 * v4) {
            if (true) {
                abort 100
            };
        };
        assert!(v3 > 0, 59);
        assert!(v2 > 0, 62);
        assert!(v3 * v2 > 0, 22);
        assert!(v5 > 0, 25);
        let v6 = PayoutDebugInfo{
            wallet_balance      : v5,
            contribution_amount : v3,
            member_count        : v2,
            payout_amount       : v5,
            payout_reason       : 0x1::string::utf8(b"Using SUI contributions"),
        };
        0x2::event::emit<PayoutDebugInfo>(v6);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_members::set_received_payout(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_member_mut(arg0, v1), true);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody::withdraw(arg1, v5, arg3), v1);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::reset_contributions_this_cycle(arg0);
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::advance_rotation_position_and_cycle(arg0, v1, arg2);
        let v7 = PayoutProcessed{
            circle_id   : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_id(arg0),
            recipient   : v1,
            amount      : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_contribution_amount(arg0) * v2,
            cycle       : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_current_cycle(arg0),
            payout_type : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_circles::get_goal_type(arg0),
        };
        0x2::event::emit<PayoutProcessed>(v7);
    }

    // decompiled from Move bytecode v6
}

