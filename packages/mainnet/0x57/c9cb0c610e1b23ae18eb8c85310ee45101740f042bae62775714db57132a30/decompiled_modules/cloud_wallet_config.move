module 0x57c9cb0c610e1b23ae18eb8c85310ee45101740f042bae62775714db57132a30::cloud_wallet_config {
    struct CloudWalletTokenHolder has store, key {
        id: 0x2::object::UID,
        vault_bag: 0x2::bag::Bag,
    }

    struct RoleGranted has copy, drop {
        addr: address,
        role: u64,
    }

    struct RoleRevoke has copy, drop {
        addr: address,
        role: u64,
    }

    struct CloudWalletConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        signers_v1: vector<vector<u8>>,
        signers_v2: vector<vector<u8>>,
        admin_table: 0x2::table::Table<address, bool>,
        operator_table: 0x2::table::Table<address, bool>,
        trusted_bot_table: 0x2::table::Table<address, bool>,
        used_withdraw_ids: 0x2::table::Table<u256, bool>,
        used_quick_withdraw_ids: 0x2::table::Table<u256, bool>,
        used_mm_withdraw_ids: 0x2::table::Table<u256, bool>,
        emergency_withdraw_to: address,
        withdraw_cap_id: 0x2::object::ID,
    }

    struct CloudWalletVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        withdraw_whitelist: 0x2::table::Table<address, bool>,
    }

    struct CloudWalletVaultCreated has copy, drop {
        creator: address,
        token: 0x1::type_name::TypeName,
        vault: 0x2::object::ID,
    }

    struct QuickWithdrawCap has store, key {
        id: 0x2::object::UID,
    }

    struct SignerAdded has copy, drop {
        signer_pubkey: vector<u8>,
        version: u8,
    }

    struct SignerRemove has copy, drop {
        signer_pubkey: vector<u8>,
        version: u8,
    }

    public fun add_signer(arg0: &mut CloudWalletConfig, arg1: vector<u8>, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        only_admin(arg0, arg3);
        only_allow_version(arg0);
        assert!(arg2 == 1 || arg2 == 2, 20005);
        if (arg2 == 1) {
            assert!(!0x1::vector::contains<vector<u8>>(&arg0.signers_v1, &arg1), 20004);
            0x1::vector::push_back<vector<u8>>(&mut arg0.signers_v1, arg1);
            let v0 = SignerAdded{
                signer_pubkey : arg1,
                version       : 1,
            };
            0x2::event::emit<SignerAdded>(v0);
        } else {
            assert!(!0x1::vector::contains<vector<u8>>(&arg0.signers_v2, &arg1), 20004);
            0x1::vector::push_back<vector<u8>>(&mut arg0.signers_v2, arg1);
            let v1 = SignerAdded{
                signer_pubkey : arg1,
                version       : 2,
            };
            0x2::event::emit<SignerAdded>(v1);
        };
    }

    public(friend) fun check_mm_withdraw_id_used(arg0: &CloudWalletConfig, arg1: u256) {
        assert!(!0x2::table::contains<u256, bool>(&arg0.used_mm_withdraw_ids, arg1), 20009);
    }

    public(friend) fun check_quick_withdraw_id_used(arg0: &CloudWalletConfig, arg1: u256) {
        assert!(!0x2::table::contains<u256, bool>(&arg0.used_quick_withdraw_ids, arg1), 20009);
    }

    public(friend) fun check_signer(arg0: vector<u8>, arg1: &CloudWalletConfig, arg2: u8) {
        if (arg2 == 1) {
            assert!(0x1::vector::contains<vector<u8>>(&arg1.signers_v1, &arg0), 20006);
        } else if (arg2 == 2) {
            assert!(0x1::vector::contains<vector<u8>>(&arg1.signers_v2, &arg0), 20006);
        };
    }

    public(friend) fun check_withdraw_id_used(arg0: &CloudWalletConfig, arg1: u256) {
        assert!(!0x2::table::contains<u256, bool>(&arg0.used_withdraw_ids, arg1), 20009);
    }

    public(friend) fun check_withdraw_whitelist<T0>(arg0: &CloudWalletTokenHolder, arg1: address) {
        let v0 = 0x1::type_name::get<T0>();
        when_vault_created(arg0, v0);
        let v1 = 0x2::bag::borrow<0x1::type_name::TypeName, CloudWalletVault<T0>>(&arg0.vault_bag, v0);
        assert!(0x2::table::contains<address, bool>(&v1.withdraw_whitelist, arg1) && *0x2::table::borrow<address, bool>(&v1.withdraw_whitelist, arg1), 20007);
    }

    public(friend) fun create_vault_if_not_exist<T0>(arg0: &mut CloudWalletTokenHolder, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vault_bag, v0)) {
            let v1 = CloudWalletVault<T0>{
                id                 : 0x2::object::new(arg1),
                balance            : 0x2::balance::zero<T0>(),
                withdraw_whitelist : 0x2::table::new<address, bool>(arg1),
            };
            let v2 = CloudWalletVaultCreated{
                creator : 0x2::tx_context::sender(arg1),
                token   : 0x1::type_name::get<T0>(),
                vault   : 0x2::object::id<CloudWalletVault<T0>>(&v1),
            };
            0x2::event::emit<CloudWalletVaultCreated>(v2);
            0x2::bag::add<0x1::type_name::TypeName, CloudWalletVault<T0>>(&mut arg0.vault_bag, v0, v1);
        };
    }

    public(friend) fun credit_coin<T0>(arg0: &mut CloudWalletTokenHolder, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: &mut 0x2::tx_context::TxContext) {
        create_vault_if_not_exist<T0>(arg0, arg2);
        0x2::balance::join<T0>(&mut 0x2::bag::borrow_mut<0x1::type_name::TypeName, CloudWalletVault<T0>>(&mut arg0.vault_bag, 0x1::type_name::get<T0>()).balance, 0x2::coin::into_balance<T0>(0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1)));
    }

    public fun delete_quick_withdraw_cap(arg0: &mut CloudWalletConfig, arg1: QuickWithdrawCap) {
        only_allow_version(arg0);
        let QuickWithdrawCap { id: v0 } = arg1;
        0x2::dynamic_field::remove_if_exists<0x1::ascii::String, address>(&mut arg0.id, 0x1::ascii::string(b"vault_token_holder"));
        0x2::object::delete(v0);
    }

    public(friend) fun deposit<T0>(arg0: &mut CloudWalletTokenHolder, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        create_vault_if_not_exist<T0>(arg0, arg2);
        0x2::balance::join<T0>(&mut 0x2::bag::borrow_mut<0x1::type_name::TypeName, CloudWalletVault<T0>>(&mut arg0.vault_bag, 0x1::type_name::get<T0>()).balance, arg1);
    }

    public fun emergency_pause(arg0: &mut CloudWalletConfig, arg1: &0x2::tx_context::TxContext) {
        only_operator(arg0, arg1);
        arg0.version = 18446744073709551613;
    }

    public fun grant_admin(arg0: &mut CloudWalletConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        only_allow_version(arg0);
        0x2::table::add<address, bool>(&mut arg0.admin_table, arg1, true);
        let v0 = RoleGranted{
            addr : arg1,
            role : 1,
        };
        0x2::event::emit<RoleGranted>(v0);
    }

    public fun grant_operator(arg0: &mut CloudWalletConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        only_allow_version(arg0);
        0x2::table::add<address, bool>(&mut arg0.operator_table, arg1, true);
        let v0 = RoleGranted{
            addr : arg1,
            role : 2,
        };
        0x2::event::emit<RoleGranted>(v0);
    }

    public fun grant_trusted_bot(arg0: &mut CloudWalletConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        only_allow_version(arg0);
        0x2::table::add<address, bool>(&mut arg0.trusted_bot_table, arg1, true);
        let v0 = RoleGranted{
            addr : arg1,
            role : 3,
        };
        0x2::event::emit<RoleGranted>(v0);
    }

    public fun grant_trusted_bots(arg0: &mut CloudWalletConfig, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        only_allow_version(arg0);
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
        let v0 = CloudWalletConfig{
            id                      : 0x2::object::new(arg0),
            version                 : 0,
            paused                  : false,
            signers_v1              : 0x1::vector::empty<vector<u8>>(),
            signers_v2              : 0x1::vector::empty<vector<u8>>(),
            admin_table             : 0x2::table::new<address, bool>(arg0),
            operator_table          : 0x2::table::new<address, bool>(arg0),
            trusted_bot_table       : 0x2::table::new<address, bool>(arg0),
            used_withdraw_ids       : 0x2::table::new<u256, bool>(arg0),
            used_quick_withdraw_ids : 0x2::table::new<u256, bool>(arg0),
            used_mm_withdraw_ids    : 0x2::table::new<u256, bool>(arg0),
            emergency_withdraw_to   : @0x0,
            withdraw_cap_id         : 0x2::object::id_from_address(@0x0),
        };
        let v1 = CloudWalletTokenHolder{
            id        : 0x2::object::new(arg0),
            vault_bag : 0x2::bag::new(arg0),
        };
        0x2::table::add<address, bool>(&mut v0.admin_table, 0x2::tx_context::sender(arg0), true);
        0x2::transfer::public_share_object<CloudWalletTokenHolder>(v1);
        0x2::transfer::public_share_object<CloudWalletConfig>(v0);
    }

    public(friend) fun mark_mm_withdraw_id_used(arg0: &mut CloudWalletConfig, arg1: u256) {
        0x2::table::add<u256, bool>(&mut arg0.used_mm_withdraw_ids, arg1, true);
    }

    public(friend) fun mark_quick_withdraw_id_used(arg0: &mut CloudWalletConfig, arg1: u256) {
        0x2::table::add<u256, bool>(&mut arg0.used_quick_withdraw_ids, arg1, true);
    }

    public(friend) fun mark_withdraw_id_used(arg0: &mut CloudWalletConfig, arg1: u256) {
        0x2::table::add<u256, bool>(&mut arg0.used_withdraw_ids, arg1, true);
    }

    public(friend) fun only_admin(arg0: &CloudWalletConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, bool>(&arg0.admin_table, 0x2::tx_context::sender(arg1)) && *0x2::table::borrow<address, bool>(&arg0.admin_table, 0x2::tx_context::sender(arg1)), 20012);
    }

    public(friend) fun only_allow_version(arg0: &CloudWalletConfig) {
        assert!(arg0.version <= 0, 20001);
    }

    public(friend) fun only_latest_withdraw_cap(arg0: &CloudWalletConfig, arg1: &QuickWithdrawCap) {
        assert!(arg0.withdraw_cap_id == 0x2::object::id<QuickWithdrawCap>(arg1), 20016);
    }

    public(friend) fun only_operator(arg0: &CloudWalletConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, bool>(&arg0.operator_table, 0x2::tx_context::sender(arg1)) && *0x2::table::borrow<address, bool>(&arg0.operator_table, 0x2::tx_context::sender(arg1)), 20012);
    }

    public(friend) fun only_trusted_bot(arg0: &CloudWalletConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, bool>(&arg0.trusted_bot_table, 0x2::tx_context::sender(arg1)) && *0x2::table::borrow<address, bool>(&arg0.trusted_bot_table, 0x2::tx_context::sender(arg1)), 20012);
    }

    public fun pause(arg0: &mut CloudWalletConfig, arg1: &0x2::tx_context::TxContext) {
        only_operator(arg0, arg1);
        only_allow_version(arg0);
        arg0.paused = true;
    }

    public fun remove_signer(arg0: &mut CloudWalletConfig, arg1: vector<u8>, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        only_admin(arg0, arg3);
        only_allow_version(arg0);
        assert!(arg2 == 1 || arg2 == 2, 20005);
        if (arg2 == 1) {
            let (v0, v1) = 0x1::vector::index_of<vector<u8>>(&arg0.signers_v1, &arg1);
            assert!(v0, 20006);
            0x1::vector::remove<vector<u8>>(&mut arg0.signers_v1, v1);
            let v2 = SignerRemove{
                signer_pubkey : arg1,
                version       : 1,
            };
            0x2::event::emit<SignerRemove>(v2);
        } else {
            let (v3, v4) = 0x1::vector::index_of<vector<u8>>(&arg0.signers_v2, &arg1);
            assert!(v3, 20006);
            0x1::vector::remove<vector<u8>>(&mut arg0.signers_v2, v4);
            let v5 = SignerRemove{
                signer_pubkey : arg1,
                version       : 2,
            };
            0x2::event::emit<SignerRemove>(v5);
        };
    }

    public fun revoke(arg0: &mut CloudWalletConfig, arg1: u64, arg2: address, arg3: &0x2::tx_context::TxContext) {
        only_admin(arg0, arg3);
        only_allow_version(arg0);
        let v0 = if (arg1 == 1) {
            true
        } else if (arg1 == 2) {
            true
        } else {
            arg1 == 3
        };
        assert!(v0, 20013);
        if (arg1 == 1) {
            assert!(0x2::table::contains<address, bool>(&arg0.admin_table, arg2), 20014);
            0x2::table::remove<address, bool>(&mut arg0.admin_table, arg2);
        } else if (arg1 == 2) {
            assert!(0x2::table::contains<address, bool>(&arg0.operator_table, arg2), 20014);
            0x2::table::remove<address, bool>(&mut arg0.operator_table, arg2);
        } else if (arg1 == 3) {
            assert!(0x2::table::contains<address, bool>(&arg0.trusted_bot_table, arg2), 20014);
            0x2::table::remove<address, bool>(&mut arg0.trusted_bot_table, arg2);
        };
        let v1 = RoleRevoke{
            addr : arg2,
            role : arg1,
        };
        0x2::event::emit<RoleRevoke>(v1);
    }

    public fun set_conf_version(arg0: &mut CloudWalletConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        only_allow_version(arg0);
        assert!(arg1 <= 0, 20017);
        arg0.version = arg1;
    }

    public fun set_emergency_withdraw_to(arg0: &mut CloudWalletConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        only_allow_version(arg0);
        arg0.emergency_withdraw_to = arg1;
    }

    public fun set_quick_withdrawer(arg0: &mut CloudWalletConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        only_allow_version(arg0);
        only_admin(arg0, arg2);
        let v0 = QuickWithdrawCap{id: 0x2::object::new(arg2)};
        arg0.withdraw_cap_id = 0x2::object::id<QuickWithdrawCap>(&v0);
        0x2::transfer::public_transfer<QuickWithdrawCap>(v0, arg1);
        0x2::dynamic_field::remove_if_exists<0x1::ascii::String, address>(&mut arg0.id, 0x1::ascii::string(b"vault_token_holder"));
        0x2::dynamic_field::add<0x1::ascii::String, address>(&mut arg0.id, 0x1::ascii::string(b"vault_token_holder"), arg1);
    }

    public fun unpause(arg0: &mut CloudWalletConfig, arg1: &0x2::tx_context::TxContext) {
        only_admin(arg0, arg1);
        only_allow_version(arg0);
        arg0.paused = false;
    }

    public(friend) fun vault_token_holder_address(arg0: &CloudWalletConfig) : address {
        *0x2::dynamic_field::borrow<0x1::ascii::String, address>(&arg0.id, 0x1::ascii::string(b"vault_token_holder"))
    }

    public(friend) fun when_emergency_withdraw_to_match(arg0: &CloudWalletConfig, arg1: address) {
        assert!(arg0.emergency_withdraw_to == arg1, 20008);
    }

    public(friend) fun when_emergency_withdraw_to_not_null(arg0: &CloudWalletConfig) {
        assert!(arg0.emergency_withdraw_to != @0x0, 20010);
    }

    public(friend) fun when_not_expired(arg0: &0x2::clock::Clock, arg1: u64) {
        assert!(arg1 >= 0x2::clock::timestamp_ms(arg0), 20003);
    }

    public(friend) fun when_not_paused(arg0: &CloudWalletConfig) {
        assert!(!arg0.paused, 20002);
    }

    public(friend) fun when_vault_created(arg0: &CloudWalletTokenHolder, arg1: 0x1::type_name::TypeName) {
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vault_bag, arg1), 20011);
    }

    public(friend) fun withdraw<T0>(arg0: &mut CloudWalletTokenHolder, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        when_vault_created(arg0, v0);
        0x2::balance::split<T0>(&mut 0x2::bag::borrow_mut<0x1::type_name::TypeName, CloudWalletVault<T0>>(&mut arg0.vault_bag, v0).balance, arg1)
    }

    // decompiled from Move bytecode v6
}

