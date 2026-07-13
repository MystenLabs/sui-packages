module 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::treasury {
    struct Treasury has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        withdraw_history: 0x2::table::Table<u64, u64>,
        user_digest_history: 0x2::table::Table<vector<u8>, u64>,
        emergency_address: address,
        balances: 0x2::bag::Bag,
    }

    struct DepositEvent has copy, drop {
        token_type: 0x1::ascii::String,
        amount: u64,
        sender: address,
    }

    struct WithdrawEvent has copy, drop {
        withdraw_id: u64,
        receiver: address,
        token_type: 0x1::ascii::String,
        amount: u64,
        fee: u64,
        actual_amount: u64,
    }

    struct WithdrawPausedEvent has copy, drop {
        token_type: 0x1::ascii::String,
        amount: u64,
        amount_usd: u64,
        hourly_limit: u64,
    }

    struct EmergencyWithdrawEvent has copy, drop {
        token_type: 0x1::ascii::String,
        amount: u64,
        to: address,
    }

    struct MigrateEvent has copy, drop {
        previous_version: u64,
        new_version: u64,
    }

    public fun migrate(arg0: &0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::SuperAdminCap, arg1: &mut Treasury, arg2: &mut 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::token_config::TokenRegistry, arg3: &mut 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::signature::SigConfig, arg4: &mut 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::AccessControl) {
        if (arg1.version < 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::version::current()) {
            arg1.version = 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::version::current();
        };
        0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::token_config::migrate(arg2);
        0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::signature::migrate(arg3);
        0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::migrate(arg4);
        let v0 = MigrateEvent{
            previous_version : arg1.version,
            new_version      : 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::version::current(),
        };
        0x2::event::emit<MigrateEvent>(v0);
    }

    fun assert_version(arg0: &Treasury) {
        assert!(arg0.version == 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::version::current(), 1014);
    }

    entry fun deposit<T0>(arg0: &0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::token_config::TokenRegistry, arg1: &mut Treasury, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::token_config::assert_token_supported<T0>(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg1.balances, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, v0, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, v0), 0x2::coin::into_balance<T0>(arg2));
        let v1 = DepositEvent{
            token_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            amount     : 0x2::coin::value<T0>(&arg2),
            sender     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    entry fun emergency_withdraw<T0>(arg0: &0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::AccessControl, arg1: &mut Treasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::assert_admin_role(arg0, 0x2::tx_context::sender(arg3));
        assert!(arg1.emergency_address != @0x0, 1005);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg1.balances, v0), 1004);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, v0);
        let v2 = if (arg2 > 0x2::balance::value<T0>(v1)) {
            0x2::balance::value<T0>(v1)
        } else {
            arg2
        };
        let v3 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, v2), arg3);
        let v4 = arg1.emergency_address;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, v4);
        let v5 = EmergencyWithdrawEvent{
            token_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            amount     : v2,
            to         : v4,
        };
        0x2::event::emit<EmergencyWithdrawEvent>(v5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id                  : 0x2::object::new(arg0),
            version             : 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::version::current(),
            paused              : false,
            withdraw_history    : 0x2::table::new<u64, u64>(arg0),
            user_digest_history : 0x2::table::new<vector<u8>, u64>(arg0),
            emergency_address   : @0x0,
            balances            : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    entry fun pause(arg0: &0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::AccessControl, arg1: &mut Treasury, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::assert_pause_role(arg0, 0x2::tx_context::sender(arg2));
        arg1.paused = true;
    }

    entry fun set_emergency_address(arg0: &0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::AccessControl, arg1: &mut Treasury, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::assert_admin_role(arg0, 0x2::tx_context::sender(arg3));
        arg1.emergency_address = arg2;
    }

    entry fun unpause(arg0: &0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::AccessControl, arg1: &mut Treasury, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::assert_unpause_role(arg0, 0x2::tx_context::sender(arg2));
        arg1.paused = false;
    }

    entry fun withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::AccessControl, arg2: &mut 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::token_config::TokenRegistry, arg3: &0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::signature::SigConfig, arg4: &mut Treasury, arg5: address, arg6: u64, arg7: address, arg8: u64, arg9: u8, arg10: u64, arg11: u8, arg12: u64, arg13: u64, arg14: u64, arg15: vector<u8>, arg16: vector<u8>, arg17: vector<u8>, arg18: &mut 0x2::tx_context::TxContext) {
        assert_version(arg4);
        0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::assert_operate_role(arg1, 0x2::tx_context::sender(arg18));
        assert!(!arg4.paused, 1001);
        assert!(!0x2::table::contains<u64, u64>(&arg4.withdraw_history, arg13), 1002);
        assert!(arg7 != @0x0, 1011);
        assert!(arg14 <= arg10, 1009);
        assert!(arg10 <= arg8, 1009);
        assert!(arg8 > 0, 1010);
        assert!(arg8 > arg14, 1010);
        let v0 = 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::token_config::get_token_info<T0>(arg2);
        let v1 = 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::token_config::token_decimals(v0);
        let v2 = 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::signature::verify_sig(arg3, arg5, arg6, arg7, *0x1::string::as_bytes(0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::token_config::token_name(v0)), arg8, v1, arg9, arg10, v1, arg11, arg12, arg13, arg15, arg16, arg17);
        assert!(arg8 % 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::util::pow10(((v1 - arg9) as u64)) == 0, 1012);
        assert!(arg10 % 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::util::pow10(((v1 - arg11) as u64)) == 0, 1013);
        assert!(!0x2::table::contains<vector<u8>, u64>(&arg4.user_digest_history, v2), 1003);
        let (v3, v4) = 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::token_config::is_hourly_limit_reached<T0>(arg2, arg8, arg0);
        if (v3) {
            arg4.paused = true;
            let v5 = WithdrawPausedEvent{
                token_type   : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
                amount       : arg8,
                amount_usd   : v4,
                hourly_limit : 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::token_config::hourly_limit_usd(arg2),
            };
            0x2::event::emit<WithdrawPausedEvent>(v5);
            return
        };
        0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::token_config::record_withdrawal(arg2, v4, arg0);
        let v6 = 0x2::tx_context::epoch(arg18);
        0x2::table::add<u64, u64>(&mut arg4.withdraw_history, arg13, v6);
        0x2::table::add<vector<u8>, u64>(&mut arg4.user_digest_history, v2, v6);
        let v7 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg4.balances, v7), 1004);
        let v8 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg4.balances, v7);
        let v9 = arg8 - arg14;
        assert!(0x2::balance::value<T0>(v8) >= v9, 1004);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v8, v9), arg18), arg7);
        let v10 = WithdrawEvent{
            withdraw_id   : arg13,
            receiver      : arg7,
            token_type    : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            amount        : arg8,
            fee           : arg14,
            actual_amount : v9,
        };
        0x2::event::emit<WithdrawEvent>(v10);
    }

    // decompiled from Move bytecode v7
}

