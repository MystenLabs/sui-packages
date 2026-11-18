module 0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::red_packet {
    struct RedPacketAdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        role_version: u64,
    }

    struct FundingKey has copy, drop, store {
        owner: address,
        packet_no: 0x1::string::String,
    }

    struct RedPacketPool<phantom T0> has key {
        id: 0x2::object::UID,
        schema_version: u64,
        ast_receiver: address,
        admin: address,
        admin_version: u64,
        paused: bool,
        config_version: u64,
        funded_packets: 0x2::table::Table<FundingKey, bool>,
        total_packets: u64,
        total_ast: u128,
    }

    struct RedPacketPoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        ast_receiver: address,
        admin: address,
        timestamp_ms: u64,
    }

    struct RedPacketPauseUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        paused: bool,
        config_version: u64,
        timestamp_ms: u64,
    }

    struct RedPacketAdminUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        admin: address,
        admin_version: u64,
        timestamp_ms: u64,
    }

    struct RedPacketFunded has copy, drop {
        pool_id: 0x2::object::ID,
        packet_no: 0x1::string::String,
        owner: address,
        ast_receiver: address,
        amount_ast: u64,
        total_count: u32,
        expires_at_ms: u64,
        funded_at_ms: u64,
        config_version: u64,
    }

    fun assert_admin<T0>(arg0: &RedPacketPool<T0>, arg1: &RedPacketAdminCap<T0>) {
        let v0 = if (arg0.schema_version == 1) {
            if (arg1.pool_id == 0x2::object::id<RedPacketPool<T0>>(arg0)) {
                arg1.role_version == arg0.admin_version
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
    }

    public entry fun fund<T0>(arg0: &mut RedPacketPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: u32, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.schema_version == 1 && !arg0.paused, 3);
        assert!(arg0.config_version == arg5, 4);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        assert!(v0 <= arg6 && v0 < arg4, 5);
        let v1 = 0x2::coin::value<T0>(&arg1);
        let v2 = if (v1 > 0) {
            if (arg3 > 0) {
                v1 >= (arg3 as u64)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 6);
        let v3 = 0x1::string::bytes(&arg2);
        assert!(0x1::vector::length<u8>(v3) == 32, 7);
        let v4 = 0;
        while (v4 < 32) {
            let v5 = *0x1::vector::borrow<u8>(v3, v4);
            assert!(v5 >= 48 && v5 <= 57 || v5 >= 97 && v5 <= 102, 7);
            v4 = v4 + 1;
        };
        let v6 = FundingKey{
            owner     : 0x2::tx_context::sender(arg8),
            packet_no : arg2,
        };
        assert!(!0x2::table::contains<FundingKey, bool>(&arg0.funded_packets, v6), 8);
        0x2::table::add<FundingKey, bool>(&mut arg0.funded_packets, v6, true);
        arg0.total_packets = arg0.total_packets + 1;
        arg0.total_ast = arg0.total_ast + (v1 as u128);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.ast_receiver);
        let v7 = RedPacketFunded{
            pool_id        : 0x2::object::id<RedPacketPool<T0>>(arg0),
            packet_no      : arg2,
            owner          : 0x2::tx_context::sender(arg8),
            ast_receiver   : arg0.ast_receiver,
            amount_ast     : v1,
            total_count    : arg3,
            expires_at_ms  : arg4,
            funded_at_ms   : v0,
            config_version : arg0.config_version,
        };
        0x2::event::emit<RedPacketFunded>(v7);
    }

    public fun get_info<T0>(arg0: &RedPacketPool<T0>) : (address, bool, u64, u64, u128) {
        (arg0.ast_receiver, arg0.paused, arg0.config_version, arg0.total_packets, arg0.total_ast)
    }

    public fun owner_create_pool<T0>(arg0: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::governance::ProtocolOwnerCap, arg1: address, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::governance::assert_owner(arg0);
        assert!(arg1 != @0x0 && arg2 != @0x0, 1);
        let v0 = RedPacketPool<T0>{
            id             : 0x2::object::new(arg4),
            schema_version : 1,
            ast_receiver   : arg1,
            admin          : arg2,
            admin_version  : 1,
            paused         : true,
            config_version : 1,
            funded_packets : 0x2::table::new<FundingKey, bool>(arg4),
            total_packets  : 0,
            total_ast      : 0,
        };
        let v1 = 0x2::object::id<RedPacketPool<T0>>(&v0);
        let v2 = RedPacketAdminCap<T0>{
            id           : 0x2::object::new(arg4),
            pool_id      : v1,
            role_version : 1,
        };
        let v3 = RedPacketPoolCreated{
            pool_id      : v1,
            ast_receiver : arg1,
            admin        : arg2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RedPacketPoolCreated>(v3);
        0x2::transfer::share_object<RedPacketPool<T0>>(v0);
        0x2::transfer::transfer<RedPacketAdminCap<T0>>(v2, arg2);
    }

    public fun owner_replace_admin<T0>(arg0: &mut RedPacketPool<T0>, arg1: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::governance::ProtocolOwnerCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::governance::assert_owner(arg1);
        assert!(arg2 != @0x0, 1);
        arg0.admin = arg2;
        arg0.admin_version = arg0.admin_version + 1;
        let v0 = RedPacketAdminCap<T0>{
            id           : 0x2::object::new(arg4),
            pool_id      : 0x2::object::id<RedPacketPool<T0>>(arg0),
            role_version : arg0.admin_version,
        };
        let v1 = RedPacketAdminUpdated{
            pool_id       : 0x2::object::id<RedPacketPool<T0>>(arg0),
            admin         : arg2,
            admin_version : arg0.admin_version,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RedPacketAdminUpdated>(v1);
        0x2::transfer::transfer<RedPacketAdminCap<T0>>(v0, arg2);
    }

    public fun owner_set_paused<T0>(arg0: &mut RedPacketPool<T0>, arg1: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::governance::ProtocolOwnerCap, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) {
        0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::governance::assert_owner(arg1);
        set_paused_internal<T0>(arg0, arg2, arg3, arg4);
    }

    public fun set_paused<T0>(arg0: &mut RedPacketPool<T0>, arg1: &RedPacketAdminCap<T0>, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) {
        assert_admin<T0>(arg0, arg1);
        set_paused_internal<T0>(arg0, arg2, arg3, arg4);
    }

    fun set_paused_internal<T0>(arg0: &mut RedPacketPool<T0>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) {
        assert!(arg0.config_version == arg1, 4);
        arg0.paused = arg2;
        arg0.config_version = arg0.config_version + 1;
        let v0 = RedPacketPauseUpdated{
            pool_id        : 0x2::object::id<RedPacketPool<T0>>(arg0),
            paused         : arg2,
            config_version : arg0.config_version,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RedPacketPauseUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

