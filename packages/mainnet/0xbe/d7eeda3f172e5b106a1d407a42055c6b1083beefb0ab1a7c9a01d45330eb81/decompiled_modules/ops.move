module 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::ops {
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

    struct TransferTemplateUpdated has copy, drop {
        package_address: address,
    }

    fun assert_upgraded_package_address(arg0: address) {
        let v0 = 0x1::type_name::with_defining_ids<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>();
        assert!(0x2::address::to_string(arg0) != 0x1::string::from_ascii(0x1::type_name::address_string(&v0)), 13835340273288216577);
    }

    public fun burn_from_account(arg0: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::Compliance, arg1: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::policy::Policy<0x2::balance::Balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>>, arg2: &mut 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::Account, arg3: &mut 0x2::coin::TreasuryCap<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::assert_version(arg0);
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::assert_supply_controller(arg0, arg5);
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::assert_not_paused(arg0);
        assert!(arg4 > 0, 0);
        let v0 = 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::clawback_balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg2, arg4, arg5);
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::approve_clawback(&mut v0);
        0x2::coin::burn<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg3, 0x2::coin::from_balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::clawback_funds::resolve<0x2::balance::Balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>>(v0, arg1), arg5));
        let v1 = TotalSupplyDecreased{
            amount           : arg4,
            timestamp_ms     : 0x2::tx_context::epoch_timestamp_ms(arg5),
            new_total_supply : 0x2::coin::total_supply<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg3),
        };
        0x2::event::emit<TotalSupplyDecreased>(v1);
    }

    public fun deposit_coin_to_account(arg0: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::Compliance, arg1: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::Account, arg2: 0x2::coin::Coin<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>, arg3: &0x2::tx_context::TxContext) {
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::assert_version(arg0);
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::assert_transfer_allowed(arg0, 0x2::tx_context::sender(arg3), 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::owner(arg1));
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::deposit_balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg1, 0x2::coin::into_balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg2));
    }

    public fun forced_transfer(arg0: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::Compliance, arg1: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::policy::Policy<0x2::balance::Balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>>, arg2: &mut 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::Account, arg3: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::Account, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::assert_version(arg0);
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::assert_freezer(arg0, arg5);
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::assert_forced_transfer_allowed(arg0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::owner(arg2), 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::owner(arg3));
        assert!(arg4 > 0, 0);
        let v0 = 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::clawback_balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg2, arg4, arg5);
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::approve_clawback(&mut v0);
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::deposit_balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg3, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::clawback_funds::resolve<0x2::balance::Balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>>(v0, arg1));
        let v1 = ForcedTransfer{
            from   : 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::owner(arg2),
            to     : 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::owner(arg3),
            amount : arg4,
        };
        0x2::event::emit<ForcedTransfer>(v1);
    }

    public fun migrate_compliance(arg0: &mut 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::Compliance, arg1: &mut 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::templates::Templates, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::migrate(arg0, arg3);
        update_transfer_template(arg1, arg0, arg2, arg3);
    }

    public fun mint_to_account(arg0: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::Compliance, arg1: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::Account, arg2: &mut 0x2::coin::TreasuryCap<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::assert_version(arg0);
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::assert_supply_controller(arg0, arg4);
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::assert_mint_allowed(arg0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::owner(arg1));
        assert!(arg3 > 0, 0);
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::deposit_balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg1, 0x2::coin::mint_balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg2, arg3));
        let v0 = TotalSupplyIncreased{
            amount           : arg3,
            timestamp_ms     : 0x2::tx_context::epoch_timestamp_ms(arg4),
            new_total_supply : 0x2::coin::total_supply<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg2),
        };
        0x2::event::emit<TotalSupplyIncreased>(v0);
    }

    public fun send(arg0: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::Compliance, arg1: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::policy::Policy<0x2::balance::Balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>>, arg2: &mut 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::Account, arg3: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::Account, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::assert_version(arg0);
        assert!(arg4 > 0, 0);
        let v0 = 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::new_auth(arg5);
        let v1 = 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::send_balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg2, &v0, arg3, arg4, arg5);
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::approve_transfer(arg0, &mut v1);
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::send_funds::resolve_balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(v1, arg1);
        let v2 = FundsTransferred{
            from   : 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::owner(arg2),
            to     : 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::owner(arg3),
            amount : arg4,
        };
        0x2::event::emit<FundsTransferred>(v2);
    }

    public fun send_to_address(arg0: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::Compliance, arg1: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::policy::Policy<0x2::balance::Balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>>, arg2: &mut 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::Account, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::assert_version(arg0);
        assert!(arg4 > 0, 0);
        let v0 = 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::new_auth(arg5);
        let v1 = 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::unsafe_send_balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg2, &v0, arg3, arg4, arg5);
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::approve_transfer(arg0, &mut v1);
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::send_funds::resolve_balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(v1, arg1);
        let v2 = FundsTransferred{
            from   : 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::owner(arg2),
            to     : arg3,
            amount : arg4,
        };
        0x2::event::emit<FundsTransferred>(v2);
    }

    public fun setup_pas(arg0: &mut 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::namespace::Namespace, arg1: &mut 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::templates::Templates, arg2: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::Compliance, arg3: &mut 0x2::coin::TreasuryCap<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>, arg4: &mut 0x2::tx_context::TxContext) {
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::assert_version(arg2);
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::assert_owner(arg2, arg4);
        let (v0, v1) = 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::policy::new_for_currency<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg0, arg3, true);
        let v2 = v1;
        let v3 = v0;
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::policy::set_required_approval<0x2::balance::Balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::TransferApproval>(&mut v3, &v2, 0x1::string::utf8(b"send_funds"));
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::policy::set_required_approval<0x2::balance::Balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::ClawbackApproval>(&mut v3, &v2, 0x1::string::utf8(b"clawback_funds"));
        let v4 = 0x1::type_name::with_defining_ids<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>();
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::templates::set_template_command<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::TransferApproval>(arg1, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::transfer_approval_permit(), transfer_template_command(arg2, 0x1::string::from_ascii(0x1::type_name::address_string(&v4))));
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::policy::share<0x2::balance::Balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>>(v3);
        0x2::transfer::public_transfer<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::policy::PolicyCap<0x2::balance::Balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>>>(v2, 0x2::tx_context::sender(arg4));
        let v5 = PolicyConfigured{policy: 0x2::object::id<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::policy::Policy<0x2::balance::Balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>>>(&v3)};
        0x2::event::emit<PolicyConfigured>(v5);
    }

    fun transfer_template_command(arg0: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::Compliance, arg1: 0x1::string::String) : 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::ptb::Command {
        let v0 = 0x1::vector::empty<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::ptb::Argument>();
        let v1 = &mut v0;
        0x1::vector::push_back<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::ptb::Argument>(v1, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::ptb::object_by_id(0x2::object::id<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::Compliance>(arg0)));
        0x1::vector::push_back<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::ptb::Argument>(v1, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::ptb::ext_input<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::templates::PAS>(0x1::string::utf8(b"request")));
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::ptb::move_call(arg1, 0x1::string::utf8(b"compliance"), 0x1::string::utf8(b"approve_transfer"), v0, 0x1::vector::empty<0x1::string::String>())
    }

    public fun update_transfer_template(arg0: &mut 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::templates::Templates, arg1: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::Compliance, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::assert_version(arg1);
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::assert_owner(arg1, arg3);
        assert_upgraded_package_address(arg2);
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::templates::set_template_command<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::TransferApproval>(arg0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::transfer_approval_permit(), transfer_template_command(arg1, 0x2::address::to_string(arg2)));
        let v0 = TransferTemplateUpdated{package_address: arg2};
        0x2::event::emit<TransferTemplateUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

