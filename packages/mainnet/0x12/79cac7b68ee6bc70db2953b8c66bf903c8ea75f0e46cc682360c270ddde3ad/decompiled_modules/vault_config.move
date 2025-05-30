module 0x27590d1d4eb13c545258a8a767ac94bf88455c0319ef944dee236cd5e00870c1::vault_config {
    struct RoleGranted has copy, drop {
        addr: address,
        role: u64,
    }

    struct RoleRevoke has copy, drop {
        addr: address,
        role: u64,
    }

    struct VaultConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        admin_table: 0x2::table::Table<address, bool>,
        operator_table: 0x2::table::Table<address, bool>,
        trusted_bot_table: 0x2::table::Table<address, bool>,
        trade_tokens_max_amount: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        rebalance_to: address,
    }

    struct ExtensionEv has copy, drop {
        value: u64,
    }

    struct VaultTokenHolder has store, key {
        id: 0x2::object::UID,
        vault_bag: 0x2::bag::Bag,
    }

    struct VaultCreated has copy, drop {
        creator: address,
        token: 0x1::type_name::TypeName,
    }

    public fun add_bag_with_name(arg0: &mut VaultConfig, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::dynamic_field::add<0x1::ascii::String, 0x2::bag::Bag>(&mut arg0.id, arg1, 0x2::bag::new(arg2));
    }

    public fun add_extension_in_config<T0>(arg0: &mut VaultConfig, arg1: u64) {
        0x2::dynamic_field::add<0x1::type_name::TypeName, u64>(&mut arg0.id, 0x1::type_name::get<T0>(), arg1);
    }

    public(friend) fun borrow_withdraw_cap(arg0: &VaultTokenHolder) : &0xc03ce5701b9a79bafc890a7d5e127b719627d29afd2c5508efa33f1c16977438::cloud_wallet_config::QuickWithdrawCap {
        0x2::dynamic_field::borrow<0x1::ascii::String, 0xc03ce5701b9a79bafc890a7d5e127b719627d29afd2c5508efa33f1c16977438::cloud_wallet_config::QuickWithdrawCap>(&arg0.id, 0x1::ascii::string(b"quick_withdraw_cap"))
    }

    public(friend) fun check_rebalance_to(arg0: &VaultConfig, arg1: address) {
        assert!(arg0.rebalance_to == arg1, 10006);
    }

    public(friend) fun check_trade_token<T0>(arg0: &VaultConfig, arg1: u64) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.trade_tokens_max_amount, v0), 10004);
        let v1 = *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.trade_tokens_max_amount, v0);
        assert!(arg1 <= v1 && v1 > 0, 10005);
    }

    public fun coin_a_is_whitelist<T0, T1>(arg0: &VaultConfig) : bool {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.trade_tokens_max_amount, v0)) {
            if (*0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.trade_tokens_max_amount, v0) > 0) {
                return true
            };
        };
        let v1 = 0x1::type_name::get<T1>();
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.trade_tokens_max_amount, v1)) {
            assert!(*0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.trade_tokens_max_amount, v1) > 0, 10004);
        };
        false
    }

    public(friend) fun create_vault<T0>(arg0: &mut VaultTokenHolder, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vault_bag, v0), 10008);
        let v1 = VaultCreated{
            creator : 0x2::tx_context::sender(arg1),
            token   : v0,
        };
        0x2::event::emit<VaultCreated>(v1);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault_bag, v0, 0x2::balance::zero<T0>());
    }

    public(friend) fun credit_coin<T0>(arg0: &mut VaultTokenHolder, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vault_bag, v0)) {
            create_vault<T0>(arg0, arg2);
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault_bag, v0), 0x2::coin::into_balance<T0>(0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1)));
    }

    public(friend) fun deposit_token_from_vault<T0>(arg0: &mut VaultTokenHolder, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        when_vault_created(arg0, v0);
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault_bag, v0), 0x2::coin::into_balance<T0>(arg1));
    }

    public(friend) fun emergency_withdraw<T0>(arg0: &mut VaultTokenHolder, arg1: u64) : 0x2::balance::Balance<T0> {
        withdraw<T0>(arg0, arg1)
    }

    public fun emit_bag<T0>(arg0: &VaultConfig, arg1: 0x1::ascii::String) {
        let v0 = ExtensionEv{value: *0x2::bag::borrow<0x1::type_name::TypeName, u64>(0x2::dynamic_field::borrow<0x1::ascii::String, 0x2::bag::Bag>(&arg0.id, arg1), 0x1::type_name::get<T0>())};
        0x2::event::emit<ExtensionEv>(v0);
    }

    public fun emit_extension_ev<T0>(arg0: &VaultConfig) {
        let v0 = ExtensionEv{value: *0x2::dynamic_field::borrow<0x1::type_name::TypeName, u64>(&arg0.id, 0x1::type_name::get<T0>())};
        0x2::event::emit<ExtensionEv>(v0);
    }

    public fun get_role_status(arg0: &VaultConfig, arg1: u64, arg2: address) : bool {
        let v0 = false;
        if (arg1 == 1) {
            if (!0x2::table::contains<address, bool>(&arg0.admin_table, arg2)) {
                return false
            };
            v0 = *0x2::table::borrow<address, bool>(&arg0.admin_table, arg2);
        } else if (arg1 == 2) {
            if (!0x2::table::contains<address, bool>(&arg0.operator_table, arg2)) {
                return false
            };
            v0 = *0x2::table::borrow<address, bool>(&arg0.operator_table, arg2);
        } else if (arg1 == 3) {
            if (!0x2::table::contains<address, bool>(&arg0.trusted_bot_table, arg2)) {
                return false
            };
            v0 = *0x2::table::borrow<address, bool>(&arg0.trusted_bot_table, arg2);
        };
        v0
    }

    public(friend) fun get_token_to_vault<T0>(arg0: &mut VaultTokenHolder, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        when_vault_created(arg0, v0);
        0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault_bag, v0), arg1)
    }

    public fun grant_admin(arg0: &mut VaultConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        0x2::table::add<address, bool>(&mut arg0.admin_table, arg1, true);
        let v0 = RoleGranted{
            addr : arg1,
            role : 1,
        };
        0x2::event::emit<RoleGranted>(v0);
    }

    public fun grant_operator(arg0: &mut VaultConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        0x2::table::add<address, bool>(&mut arg0.operator_table, arg1, true);
        let v0 = RoleGranted{
            addr : arg1,
            role : 2,
        };
        0x2::event::emit<RoleGranted>(v0);
    }

    public fun grant_trusted_bot(arg0: &mut VaultConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        0x2::table::add<address, bool>(&mut arg0.trusted_bot_table, arg1, true);
        let v0 = RoleGranted{
            addr : arg1,
            role : 3,
        };
        0x2::event::emit<RoleGranted>(v0);
    }

    public fun grant_trusted_bots(arg0: &mut VaultConfig, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            0x2::table::add<address, bool>(&mut arg0.trusted_bot_table, v1, true);
            let v2 = RoleGranted{
                addr : v1,
                role : 3,
            };
            0x2::event::emit<RoleGranted>(v2);
            v0 = v0 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultConfig{
            id                      : 0x2::object::new(arg0),
            version                 : 0,
            paused                  : false,
            admin_table             : 0x2::table::new<address, bool>(arg0),
            operator_table          : 0x2::table::new<address, bool>(arg0),
            trusted_bot_table       : 0x2::table::new<address, bool>(arg0),
            trade_tokens_max_amount : 0x2::table::new<0x1::type_name::TypeName, u64>(arg0),
            rebalance_to            : @0x0,
        };
        let v1 = VaultTokenHolder{
            id        : 0x2::object::new(arg0),
            vault_bag : 0x2::bag::new(arg0),
        };
        0x2::table::add<address, bool>(&mut v0.admin_table, 0x2::tx_context::sender(arg0), true);
        0x2::transfer::public_share_object<VaultConfig>(v0);
        0x2::transfer::public_share_object<VaultTokenHolder>(v1);
    }

    public(friend) fun only_admin(arg0: &VaultConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, bool>(&arg0.admin_table, 0x2::tx_context::sender(arg1)) && *0x2::table::borrow<address, bool>(&arg0.admin_table, 0x2::tx_context::sender(arg1)), 10001);
    }

    public(friend) fun only_allow_version(arg0: &VaultConfig) {
        assert!(arg0.version <= 0, 10007);
    }

    public(friend) fun only_operator(arg0: &VaultConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, bool>(&arg0.operator_table, 0x2::tx_context::sender(arg1)) && *0x2::table::borrow<address, bool>(&arg0.operator_table, 0x2::tx_context::sender(arg1)), 10001);
    }

    public(friend) fun only_trusted_bot(arg0: &VaultConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, bool>(&arg0.trusted_bot_table, 0x2::tx_context::sender(arg1)) && *0x2::table::borrow<address, bool>(&arg0.trusted_bot_table, 0x2::tx_context::sender(arg1)), 10001);
    }

    public fun pause(arg0: &mut VaultConfig, arg1: &mut 0x2::tx_context::TxContext) {
        only_operator(arg0, arg1);
        arg0.paused = true;
    }

    public fun paused(arg0: &VaultConfig) : bool {
        arg0.paused
    }

    public(friend) fun rebalance_out<T0>(arg0: &mut VaultTokenHolder, arg1: u64) : 0x2::balance::Balance<T0> {
        withdraw<T0>(arg0, arg1)
    }

    public fun remove_withdraw_cap(arg0: &VaultConfig, arg1: &mut VaultTokenHolder, arg2: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        if (0x2::dynamic_field::exists_<0x1::ascii::String>(&arg1.id, 0x1::ascii::string(b"quick_withdraw_cap"))) {
            0xc03ce5701b9a79bafc890a7d5e127b719627d29afd2c5508efa33f1c16977438::cloud_wallet_config::delete_quick_withdraw_cap(0x2::dynamic_field::remove<0x1::ascii::String, 0xc03ce5701b9a79bafc890a7d5e127b719627d29afd2c5508efa33f1c16977438::cloud_wallet_config::QuickWithdrawCap>(&mut arg1.id, 0x1::ascii::string(b"quick_withdraw_cap")));
        };
    }

    public fun revoke(arg0: &mut VaultConfig, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg3);
        let v0 = if (arg1 == 1) {
            true
        } else if (arg1 == 2) {
            true
        } else {
            arg1 == 3
        };
        assert!(v0, 10010);
        if (arg1 == 1) {
            assert!(0x2::table::contains<address, bool>(&arg0.admin_table, arg2), 10011);
            0x2::table::remove<address, bool>(&mut arg0.admin_table, arg2);
        } else if (arg1 == 2) {
            assert!(0x2::table::contains<address, bool>(&arg0.operator_table, arg2), 10011);
            0x2::table::remove<address, bool>(&mut arg0.operator_table, arg2);
        } else {
            assert!(0x2::table::contains<address, bool>(&arg0.trusted_bot_table, arg2), 10011);
            0x2::table::remove<address, bool>(&mut arg0.trusted_bot_table, arg2);
        };
        let v1 = RoleRevoke{
            addr : arg2,
            role : arg1,
        };
        0x2::event::emit<RoleRevoke>(v1);
    }

    public fun set_bag<T0>(arg0: &mut VaultConfig, arg1: 0x1::ascii::String, arg2: u64) {
        0x2::bag::add<0x1::type_name::TypeName, u64>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::bag::Bag>(&mut arg0.id, arg1), 0x1::type_name::get<T0>(), arg2);
    }

    public fun set_cloud_wallet_withdraw_cap(arg0: &VaultConfig, arg1: &mut VaultTokenHolder, arg2: 0x2::transfer::Receiving<0xc03ce5701b9a79bafc890a7d5e127b719627d29afd2c5508efa33f1c16977438::cloud_wallet_config::QuickWithdrawCap>, arg3: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg3);
        if (0x2::dynamic_field::exists_<0x1::ascii::String>(&arg1.id, 0x1::ascii::string(b"quick_withdraw_cap"))) {
            0xc03ce5701b9a79bafc890a7d5e127b719627d29afd2c5508efa33f1c16977438::cloud_wallet_config::delete_quick_withdraw_cap(0x2::dynamic_field::remove<0x1::ascii::String, 0xc03ce5701b9a79bafc890a7d5e127b719627d29afd2c5508efa33f1c16977438::cloud_wallet_config::QuickWithdrawCap>(&mut arg1.id, 0x1::ascii::string(b"quick_withdraw_cap")));
        };
        0x2::dynamic_field::add<0x1::ascii::String, 0xc03ce5701b9a79bafc890a7d5e127b719627d29afd2c5508efa33f1c16977438::cloud_wallet_config::QuickWithdrawCap>(&mut arg1.id, 0x1::ascii::string(b"quick_withdraw_cap"), 0x2::transfer::public_receive<0xc03ce5701b9a79bafc890a7d5e127b719627d29afd2c5508efa33f1c16977438::cloud_wallet_config::QuickWithdrawCap>(&mut arg1.id, arg2));
    }

    public fun set_conf_version(arg0: &mut VaultConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        arg0.version = arg1;
    }

    public fun set_rebalance_to(arg0: &mut VaultConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        arg0.rebalance_to = arg1;
    }

    public fun set_trade_token<T0>(arg0: &mut VaultConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.trade_tokens_max_amount, v0)) {
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.trade_tokens_max_amount, v0, arg1);
            return
        };
        *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.trade_tokens_max_amount, v0) = arg1;
    }

    public fun unpause(arg0: &mut VaultConfig, arg1: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg1);
        arg0.paused = false;
    }

    public fun vault_balance_value<T0>(arg0: &VaultTokenHolder) : u64 {
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.vault_bag, 0x1::type_name::get<T0>()))
    }

    public fun vault_version(arg0: &VaultConfig) : u64 {
        arg0.version
    }

    public(friend) fun when_not_expired(arg0: &0x2::clock::Clock, arg1: u64) {
        assert!(arg1 >= 0x2::clock::timestamp_ms(arg0), 10003);
    }

    public(friend) fun when_not_paused(arg0: &VaultConfig) {
        assert!(!arg0.paused, 10002);
    }

    public(friend) fun when_vault_created(arg0: &VaultTokenHolder, arg1: 0x1::type_name::TypeName) {
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vault_bag, arg1), 10009);
    }

    fun withdraw<T0>(arg0: &mut VaultTokenHolder, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        when_vault_created(arg0, v0);
        0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault_bag, v0), arg1)
    }

    // decompiled from Move bytecode v6
}

