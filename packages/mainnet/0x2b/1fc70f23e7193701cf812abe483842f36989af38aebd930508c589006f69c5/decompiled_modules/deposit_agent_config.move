module 0x2b1fc70f23e7193701cf812abe483842f36989af38aebd930508c589006f69c5::deposit_agent_config {
    struct DepositAgentConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        signer: vector<u8>,
        collect_to_addr: address,
        paused: bool,
        admin_table: 0x2::table::Table<address, bool>,
        operator_table: 0x2::table::Table<address, bool>,
        trusted_bot_table: 0x2::table::Table<address, bool>,
        token_holder_table: 0x2::table::Table<u256, DepositAgentTokenHolder>,
    }

    struct DepositAgentTokenHolder has store, key {
        id: 0x2::object::UID,
    }

    struct RoleGranted has copy, drop {
        addr: address,
        role: u64,
    }

    struct RoleRevoke has copy, drop {
        addr: address,
        role: u64,
    }

    struct SetSigner has copy, drop {
        addr: vector<u8>,
    }

    struct CreateAddressEvent has copy, drop {
        account_id: u256,
        token_holder_addr: address,
    }

    public(friend) fun borrow_signer(arg0: &DepositAgentConfig) : vector<u8> {
        arg0.signer
    }

    public(friend) fun check_signer(arg0: &DepositAgentConfig, arg1: vector<u8>) {
        assert!(arg0.signer != 0x2::address::to_bytes(@0x0), 40009);
        assert!(arg0.signer == arg1, 40010);
    }

    public fun create_address(arg0: &mut DepositAgentConfig, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        only_operator(arg0, arg2);
        only_allow_version(arg0);
        assert!(!0x2::table::contains<u256, DepositAgentTokenHolder>(&arg0.token_holder_table, arg1), 40008);
        let v0 = DepositAgentTokenHolder{id: 0x2::object::new(arg2)};
        let v1 = 0x2::object::id<DepositAgentTokenHolder>(&v0);
        let v2 = CreateAddressEvent{
            account_id        : arg1,
            token_holder_addr : 0x2::object::id_to_address(&v1),
        };
        0x2::event::emit<CreateAddressEvent>(v2);
        0x2::table::add<u256, DepositAgentTokenHolder>(&mut arg0.token_holder_table, arg1, v0);
    }

    public fun emergency_pause(arg0: &mut DepositAgentConfig, arg1: &0x2::tx_context::TxContext) {
        only_operator(arg0, arg1);
        arg0.version = 18446744073709551613;
    }

    public fun get_address(arg0: &DepositAgentConfig, arg1: u256) : address {
        assert!(0x2::table::contains<u256, DepositAgentTokenHolder>(&arg0.token_holder_table, arg1), 40007);
        let v0 = 0x2::object::id<DepositAgentTokenHolder>(0x2::table::borrow<u256, DepositAgentTokenHolder>(&arg0.token_holder_table, arg1));
        0x2::object::id_to_address(&v0)
    }

    public fun grant_admin(arg0: &mut DepositAgentConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        only_allow_version(arg0);
        0x2::table::add<address, bool>(&mut arg0.admin_table, arg1, true);
        let v0 = RoleGranted{
            addr : arg1,
            role : 1,
        };
        0x2::event::emit<RoleGranted>(v0);
    }

    public fun grant_operator(arg0: &mut DepositAgentConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        only_allow_version(arg0);
        0x2::table::add<address, bool>(&mut arg0.operator_table, arg1, true);
        let v0 = RoleGranted{
            addr : arg1,
            role : 2,
        };
        0x2::event::emit<RoleGranted>(v0);
    }

    public fun grant_trusted_bot(arg0: &mut DepositAgentConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        only_allow_version(arg0);
        0x2::table::add<address, bool>(&mut arg0.trusted_bot_table, arg1, true);
        let v0 = RoleGranted{
            addr : arg1,
            role : 3,
        };
        0x2::event::emit<RoleGranted>(v0);
    }

    public fun grant_trusted_bots(arg0: &mut DepositAgentConfig, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
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
        let v0 = DepositAgentConfig{
            id                 : 0x2::object::new(arg0),
            version            : 0,
            signer             : 0x1::vector::empty<u8>(),
            collect_to_addr    : @0x0,
            paused             : false,
            admin_table        : 0x2::table::new<address, bool>(arg0),
            operator_table     : 0x2::table::new<address, bool>(arg0),
            trusted_bot_table  : 0x2::table::new<address, bool>(arg0),
            token_holder_table : 0x2::table::new<u256, DepositAgentTokenHolder>(arg0),
        };
        0x2::table::add<address, bool>(&mut v0.admin_table, 0x2::tx_context::sender(arg0), true);
        0x2::transfer::public_share_object<DepositAgentConfig>(v0);
    }

    public(friend) fun only_admin(arg0: &DepositAgentConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, bool>(&arg0.admin_table, 0x2::tx_context::sender(arg1)) && *0x2::table::borrow<address, bool>(&arg0.admin_table, 0x2::tx_context::sender(arg1)), 40001);
    }

    public(friend) fun only_allow_version(arg0: &DepositAgentConfig) {
        assert!(arg0.version <= 0, 40002);
    }

    public(friend) fun only_operator(arg0: &DepositAgentConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, bool>(&arg0.operator_table, 0x2::tx_context::sender(arg1)) && *0x2::table::borrow<address, bool>(&arg0.operator_table, 0x2::tx_context::sender(arg1)), 40001);
    }

    public(friend) fun only_trusted_bot(arg0: &DepositAgentConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, bool>(&arg0.trusted_bot_table, 0x2::tx_context::sender(arg1)) && *0x2::table::borrow<address, bool>(&arg0.trusted_bot_table, 0x2::tx_context::sender(arg1)), 40001);
    }

    public fun pause(arg0: &mut DepositAgentConfig, arg1: &mut 0x2::tx_context::TxContext) {
        only_operator(arg0, arg1);
        only_allow_version(arg0);
        arg0.paused = true;
    }

    public fun revoke(arg0: &mut DepositAgentConfig, arg1: u64, arg2: address, arg3: &0x2::tx_context::TxContext) {
        only_admin(arg0, arg3);
        only_allow_version(arg0);
        let v0 = if (arg1 == 1) {
            true
        } else if (arg1 == 2) {
            true
        } else {
            arg1 == 3
        };
        assert!(v0, 40004);
        if (arg1 == 1) {
            assert!(0x2::table::contains<address, bool>(&arg0.admin_table, arg2), 40005);
            0x2::table::remove<address, bool>(&mut arg0.admin_table, arg2);
        } else if (arg1 == 2) {
            assert!(0x2::table::contains<address, bool>(&arg0.operator_table, arg2), 40005);
            0x2::table::remove<address, bool>(&mut arg0.operator_table, arg2);
        } else if (arg1 == 3) {
            assert!(0x2::table::contains<address, bool>(&arg0.trusted_bot_table, arg2), 40005);
            0x2::table::remove<address, bool>(&mut arg0.trusted_bot_table, arg2);
        };
        let v1 = RoleRevoke{
            addr : arg2,
            role : arg1,
        };
        0x2::event::emit<RoleRevoke>(v1);
    }

    public fun set_conf_version(arg0: &mut DepositAgentConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        only_allow_version(arg0);
        assert!(arg1 <= 0, 40006);
        arg0.version = arg1;
    }

    public fun set_signer(arg0: &mut DepositAgentConfig, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        only_allow_version(arg0);
        let v0 = SetSigner{addr: arg1};
        0x2::event::emit<SetSigner>(v0);
        arg0.signer = arg1;
    }

    public(friend) fun token_holder_receive<T0>(arg0: &mut DepositAgentConfig, arg1: &0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet_config::CloudWalletConfig, arg2: &mut 0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet_config::CloudWalletTokenHolder, arg3: u256, arg4: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u256, DepositAgentTokenHolder>(&arg0.token_holder_table, arg3), 40007);
        0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet::mm_credit<T0>(arg1, arg2, 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut 0x2::table::borrow_mut<u256, DepositAgentTokenHolder>(&mut arg0.token_holder_table, arg3).id, arg4), arg5);
    }

    public fun unpause(arg0: &mut DepositAgentConfig, arg1: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg1);
        only_allow_version(arg0);
        arg0.paused = false;
    }

    public(friend) fun when_not_expired(arg0: &0x2::clock::Clock, arg1: u64) {
        assert!(arg1 >= 0x2::clock::timestamp_ms(arg0), 40011);
    }

    public(friend) fun when_not_paused(arg0: &DepositAgentConfig) {
        assert!(!arg0.paused, 40003);
    }

    public(friend) fun when_to_address_match(arg0: &0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet_config::CloudWalletTokenHolder, arg1: address) {
        assert!(arg1 == 0x2::object::id_address<0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet_config::CloudWalletTokenHolder>(arg0), 40012);
    }

    // decompiled from Move bytecode v6
}

