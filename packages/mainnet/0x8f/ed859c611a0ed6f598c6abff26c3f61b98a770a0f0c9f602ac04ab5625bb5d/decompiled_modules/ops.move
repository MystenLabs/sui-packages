module 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::ops {
    struct PolicyConfigured has copy, drop {
        policy: 0x2::object::ID,
    }

    struct FundsTransferred has copy, drop {
        from: address,
        to: address,
        amount: u64,
    }

    struct ForcedTransfer has copy, drop {
        from: address,
        to: address,
        amount: u64,
    }

    struct TotalSupplyIncreased has copy, drop {
        amount: u64,
        timestamp_ms: u64,
        new_total_supply: u64,
    }

    struct TotalSupplyDecreased has copy, drop {
        amount: u64,
        timestamp_ms: u64,
        new_total_supply: u64,
    }

    public fun burn_from_account(arg0: &0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::compliance::Compliance, arg1: &0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::policy::Policy<0x2::balance::Balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>>, arg2: &mut 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::account::Account, arg3: &mut 0x2::coin::TreasuryCap<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::compliance::assert_supply_controller(arg0, arg5);
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::compliance::assert_not_paused(arg0);
        assert!(arg4 > 0, 0);
        let v0 = 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::account::clawback_balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>(arg2, arg4, arg5);
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::compliance::approve_clawback(&mut v0);
        0x2::coin::burn<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>(arg3, 0x2::coin::from_balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>(0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::clawback_funds::resolve<0x2::balance::Balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>>(v0, arg1), arg5));
        let v1 = TotalSupplyDecreased{
            amount           : arg4,
            timestamp_ms     : 0x2::tx_context::epoch_timestamp_ms(arg5),
            new_total_supply : 0x2::coin::total_supply<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>(arg3),
        };
        0x2::event::emit<TotalSupplyDecreased>(v1);
    }

    public fun deposit_coin_to_account(arg0: &0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::compliance::Compliance, arg1: &0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::account::Account, arg2: 0x2::coin::Coin<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>) {
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::compliance::assert_mint_allowed(arg0, 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::account::owner(arg1));
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::account::deposit_balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>(arg1, 0x2::coin::into_balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>(arg2));
    }

    public fun forced_transfer(arg0: &0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::compliance::Compliance, arg1: &0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::policy::Policy<0x2::balance::Balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>>, arg2: &mut 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::account::Account, arg3: &0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::account::Account, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::compliance::assert_freezer(arg0, arg5);
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::compliance::assert_forced_transfer_allowed(arg0, 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::account::owner(arg2), 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::account::owner(arg3));
        assert!(arg4 > 0, 0);
        let v0 = 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::account::clawback_balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>(arg2, arg4, arg5);
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::compliance::approve_clawback(&mut v0);
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::account::deposit_balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>(arg3, 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::clawback_funds::resolve<0x2::balance::Balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>>(v0, arg1));
        let v1 = ForcedTransfer{
            from   : 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::account::owner(arg2),
            to     : 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::account::owner(arg3),
            amount : arg4,
        };
        0x2::event::emit<ForcedTransfer>(v1);
    }

    public fun mint_to_account(arg0: &0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::compliance::Compliance, arg1: &0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::account::Account, arg2: &mut 0x2::coin::TreasuryCap<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::compliance::assert_supply_controller(arg0, arg4);
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::compliance::assert_mint_allowed(arg0, 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::account::owner(arg1));
        assert!(arg3 > 0, 0);
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::account::deposit_balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>(arg1, 0x2::coin::mint_balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>(arg2, arg3));
        let v0 = TotalSupplyIncreased{
            amount           : arg3,
            timestamp_ms     : 0x2::tx_context::epoch_timestamp_ms(arg4),
            new_total_supply : 0x2::coin::total_supply<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>(arg2),
        };
        0x2::event::emit<TotalSupplyIncreased>(v0);
    }

    public fun send(arg0: &0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::compliance::Compliance, arg1: &0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::policy::Policy<0x2::balance::Balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>>, arg2: &mut 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::account::Account, arg3: &0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::account::Account, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 0);
        let v0 = 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::account::new_auth(arg5);
        let v1 = 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::account::send_balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>(arg2, &v0, arg3, arg4, arg5);
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::compliance::approve_transfer(arg0, &mut v1);
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::send_funds::resolve_balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>(v1, arg1);
        let v2 = FundsTransferred{
            from   : 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::account::owner(arg2),
            to     : 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::account::owner(arg3),
            amount : arg4,
        };
        0x2::event::emit<FundsTransferred>(v2);
    }

    public fun send_to_address(arg0: &0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::compliance::Compliance, arg1: &0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::policy::Policy<0x2::balance::Balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>>, arg2: &mut 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::account::Account, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 0);
        let v0 = 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::account::new_auth(arg5);
        let v1 = 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::account::unsafe_send_balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>(arg2, &v0, arg3, arg4, arg5);
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::compliance::approve_transfer(arg0, &mut v1);
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::send_funds::resolve_balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>(v1, arg1);
        let v2 = FundsTransferred{
            from   : 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::account::owner(arg2),
            to     : arg3,
            amount : arg4,
        };
        0x2::event::emit<FundsTransferred>(v2);
    }

    public fun setup_pas(arg0: &mut 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::namespace::Namespace, arg1: &mut 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::templates::Templates, arg2: &0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::compliance::Compliance, arg3: &mut 0x2::coin::TreasuryCap<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>, arg4: &mut 0x2::tx_context::TxContext) {
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::compliance::assert_owner(arg2, arg4);
        let (v0, v1) = 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::policy::new_for_currency<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>(arg0, arg3, true);
        let v2 = v1;
        let v3 = v0;
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::policy::set_required_approval<0x2::balance::Balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>, 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::compliance::TransferApproval>(&mut v3, &v2, 0x1::string::utf8(b"send_funds"));
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::policy::set_required_approval<0x2::balance::Balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>, 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::compliance::ClawbackApproval>(&mut v3, &v2, 0x1::string::utf8(b"clawback_funds"));
        let v4 = 0x1::type_name::with_defining_ids<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>();
        let v5 = 0x1::vector::empty<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::ptb::Argument>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::ptb::Argument>(v6, 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::ptb::object_by_id(0x2::object::id<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::compliance::Compliance>(arg2)));
        0x1::vector::push_back<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::ptb::Argument>(v6, 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::ptb::ext_input<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::templates::PAS>(0x1::string::utf8(b"request")));
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::templates::set_template_command<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::compliance::TransferApproval>(arg1, 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::compliance::transfer_approval_permit(), 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::ptb::move_call(0x1::string::from_ascii(0x1::type_name::address_string(&v4)), 0x1::string::utf8(b"compliance"), 0x1::string::utf8(b"approve_transfer"), v5, 0x1::vector::empty<0x1::string::String>()));
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::policy::share<0x2::balance::Balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>>(v3);
        0x2::transfer::public_transfer<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::policy::PolicyCap<0x2::balance::Balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>>>(v2, 0x2::tx_context::sender(arg4));
        let v7 = PolicyConfigured{policy: 0x2::object::id<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::policy::Policy<0x2::balance::Balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>>>(&v3)};
        0x2::event::emit<PolicyConfigured>(v7);
    }

    // decompiled from Move bytecode v7
}

