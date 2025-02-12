module 0xf48cf9a6322db554f98a056e0a1737cb178bdc1770d4d629dd7382fd3747a8f5::gift {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GiftConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        executor: address,
        signers: vector<vector<u8>>,
        threshold: u64,
        red_packets: 0x2::table::Table<u64, 0x2::object::ID>,
    }

    struct RedPacket<phantom T0> has store, key {
        id: 0x2::object::UID,
        rid: u64,
        creator: address,
        balance: 0x2::balance::Balance<T0>,
        total_supply: u64,
        total_number: u64,
        reserve_number: u64,
        deadline: u64,
        packet_type: u64,
        packet_status: u64,
        claimed: 0x2::table::Table<address, u64>,
    }

    struct RedPacketCreated has copy, drop {
        sender: address,
        packet_id: 0x2::object::ID,
        rid: u64,
        token: vector<u8>,
        total_amount: u64,
        reserve_amount: u64,
        total_number: u64,
        reserve_number: u64,
        deadline: u64,
        packet_type: u64,
    }

    struct RedPacketClaimed has copy, drop {
        sender: address,
        packet_id: 0x2::object::ID,
        rid: u64,
        uid: u64,
        token: vector<u8>,
        receiver: address,
        amount: u64,
        total_amount: u64,
        reserve_amount: u64,
        total_number: u64,
        reserve_number: u64,
        deadline: u64,
        packet_type: u64,
    }

    struct RedPacketRefunded has copy, drop {
        sender: address,
        packet_id: 0x2::object::ID,
        rid: u64,
        token: vector<u8>,
        receiver: address,
        amount: u64,
    }

    public entry fun claim_red_packet<T0>(arg0: &GiftConfig, arg1: &mut RedPacket<T0>, arg2: u64, arg3: vector<u64>, arg4: vector<address>, arg5: vector<u64>, arg6: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg0);
        version_verify(arg0);
        assert!(arg0.executor == 0x2::tx_context::sender(arg6), 12);
        assert!(arg2 == arg1.rid, 10);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg4)) {
            let v1 = 0x1::vector::borrow<u64>(&arg3, v0);
            let v2 = 0x1::vector::borrow<u64>(&arg5, v0);
            let v3 = 0x1::vector::borrow<address>(&arg4, v0);
            assert!(!0x2::table::contains<address, u64>(&arg1.claimed, *v3), 11);
            0x2::table::add<address, u64>(&mut arg1.claimed, *v3, *v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, *v2), arg6), *v3);
            arg1.reserve_number = arg1.reserve_number - 1;
            if (arg1.reserve_number == 0) {
                arg1.packet_status = 1;
            };
            let v4 = RedPacketClaimed{
                sender         : 0x2::tx_context::sender(arg6),
                packet_id      : 0x2::object::id<RedPacket<T0>>(arg1),
                rid            : arg2,
                uid            : *v1,
                token          : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())),
                receiver       : *v3,
                amount         : *v2,
                total_amount   : arg1.total_supply,
                reserve_amount : 0x2::balance::value<T0>(&arg1.balance),
                total_number   : arg1.total_number,
                reserve_number : arg1.reserve_number,
                deadline       : arg1.deadline,
                packet_type    : arg1.packet_type,
            };
            0x2::event::emit<RedPacketClaimed>(v4);
            v0 = v0 + 1;
        };
    }

    public entry fun create_red_packet<T0>(arg0: &0x2::clock::Clock, arg1: &mut GiftConfig, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: vector<vector<u8>>, arg11: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg1);
        version_verify(arg1);
        assert!(arg6 >= 1, 6);
        assert!(arg5 > arg6, 5);
        assert!(arg8 > 0x2::clock::timestamp_ms(arg0) / 1000, 7);
        assert!(arg9 == 1 || arg9 == 2, 8);
        let v0 = keccak_create_message<T0>(arg4, arg5, arg6, arg7, arg8);
        let v1 = 0;
        let v2 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg1.signers)) {
            let v3 = 0x1::vector::borrow<vector<u8>>(&arg1.signers, v1);
            let v4 = 0;
            while (v4 < 0x1::vector::length<vector<u8>>(&arg10)) {
                if (0x2::ed25519::ed25519_verify(0x1::vector::borrow<vector<u8>>(&arg10, v4), v3, &v0)) {
                    v2 = v2 + 1;
                    break
                };
                v4 = v4 + 1;
            };
            v1 = v1 + 1;
        };
        assert!(arg1.threshold <= v2, 9);
        let v5 = refund<0x2::sui::SUI>(arg2, arg6 * arg7, arg11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v5, arg1.executor);
        let v6 = refund<T0>(arg3, arg5, arg11);
        let v7 = RedPacket<T0>{
            id             : 0x2::object::new(arg11),
            rid            : arg4,
            creator        : 0x2::tx_context::sender(arg11),
            balance        : 0x2::coin::into_balance<T0>(v6),
            total_supply   : arg5,
            total_number   : arg6,
            reserve_number : arg6,
            deadline       : arg8,
            packet_type    : arg9,
            packet_status  : 0,
            claimed        : 0x2::table::new<address, u64>(arg11),
        };
        let v8 = 0x2::object::id<RedPacket<T0>>(&v7);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg1.red_packets, arg4, v8);
        0x2::transfer::share_object<RedPacket<T0>>(v7);
        let v9 = RedPacketCreated{
            sender         : 0x2::tx_context::sender(arg11),
            packet_id      : v8,
            rid            : arg4,
            token          : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            total_amount   : arg5,
            reserve_amount : arg5,
            total_number   : arg6,
            reserve_number : arg6,
            deadline       : arg8,
            packet_type    : arg9,
        };
        0x2::event::emit<RedPacketCreated>(v9);
    }

    public fun executor(arg0: &GiftConfig) : address {
        arg0.executor
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GiftConfig{
            id          : 0x2::object::new(arg0),
            version     : 0,
            paused      : false,
            executor    : 0x2::tx_context::sender(arg0),
            signers     : 0x1::vector::empty<vector<u8>>(),
            threshold   : 0,
            red_packets : 0x2::table::new<u64, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<GiftConfig>(v1);
    }

    public fun keccak_create_message<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256((arg0 as u256))));
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256((arg1 as u256))));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256((arg2 as u256))));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256((arg3 as u256))));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256((arg4 as u256))));
        0x2::hash::keccak256(&v0)
    }

    public fun keccak_refund_message(arg0: u64, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256((arg0 as u256))));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256((arg1 as u256))));
        0x2::hash::keccak256(&v0)
    }

    public entry fun migration(arg0: &AdminCap, arg1: &mut GiftConfig) {
        assert!(arg1.version < 0, 0);
        arg1.version = 0;
    }

    public entry fun pause(arg0: &AdminCap, arg1: &mut GiftConfig) {
        when_not_paused(arg1);
        arg1.paused = true;
    }

    public fun paused(arg0: &GiftConfig) : bool {
        arg0.paused
    }

    public fun red_packet_id(arg0: &GiftConfig, arg1: u64) : 0x2::object::ID {
        *0x2::table::borrow<u64, 0x2::object::ID>(&arg0.red_packets, arg1)
    }

    public fun refund<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 >= arg1, 5);
        if (v0 > arg1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
            return 0x2::coin::split<T0>(&mut arg0, arg1, arg2)
        };
        arg0
    }

    public entry fun refund_red_packet<T0>(arg0: &0x2::clock::Clock, arg1: &GiftConfig, arg2: &mut RedPacket<T0>, arg3: u64, arg4: u64, arg5: vector<vector<u8>>, arg6: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg1);
        version_verify(arg1);
        assert!(0x2::balance::value<T0>(&arg2.balance) >= arg4, 5);
        assert!(0x2::clock::timestamp_ms(arg0) / 1000 > arg2.deadline, 7);
        let v0 = keccak_refund_message(arg3, arg4);
        let v1 = 0;
        let v2 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg1.signers)) {
            let v3 = 0x1::vector::borrow<vector<u8>>(&arg1.signers, v1);
            let v4 = 0;
            while (v4 < 0x1::vector::length<vector<u8>>(&arg5)) {
                if (0x2::ed25519::ed25519_verify(0x1::vector::borrow<vector<u8>>(&arg5, v4), v3, &v0)) {
                    v2 = v2 + 1;
                    break
                };
                v4 = v4 + 1;
            };
            v1 = v1 + 1;
        };
        assert!(arg1.threshold <= v2, 9);
        arg2.packet_status = 2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg2.balance, arg4, arg6), arg2.creator);
        let v5 = RedPacketRefunded{
            sender    : 0x2::tx_context::sender(arg6),
            packet_id : 0x2::object::id<RedPacket<T0>>(arg2),
            rid       : arg2.rid,
            token     : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            receiver  : arg2.creator,
            amount    : arg4,
        };
        0x2::event::emit<RedPacketRefunded>(v5);
    }

    public entry fun set_executor(arg0: &AdminCap, arg1: &mut GiftConfig, arg2: address) {
        arg1.executor = arg2;
    }

    public entry fun set_signer(arg0: &AdminCap, arg1: &mut GiftConfig, arg2: vector<vector<u8>>, arg3: u64) {
        assert!(arg3 <= 0x1::vector::length<vector<u8>>(&arg2), 3);
        arg1.signers = 0x1::vector::empty<vector<u8>>();
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg2)) {
            let v1 = 0x1::vector::borrow<vector<u8>>(&arg2, v0);
            assert!(!0x1::vector::contains<vector<u8>>(&arg1.signers, v1), 4);
            0x1::vector::push_back<vector<u8>>(&mut arg1.signers, *v1);
            v0 = v0 + 1;
        };
        arg1.threshold = arg3;
    }

    public fun signer_length(arg0: &GiftConfig) : u64 {
        0x1::vector::length<vector<u8>>(&arg0.signers)
    }

    public fun threshold(arg0: &GiftConfig) : u64 {
        arg0.threshold
    }

    public entry fun unpause(arg0: &AdminCap, arg1: &mut GiftConfig) {
        when_paused(arg1);
        arg1.paused = false;
    }

    fun version_verify(arg0: &GiftConfig) {
        assert!(arg0.version == 0, 0);
    }

    fun when_not_paused(arg0: &GiftConfig) {
        assert!(!arg0.paused, 1);
    }

    fun when_paused(arg0: &GiftConfig) {
        assert!(arg0.paused, 2);
    }

    // decompiled from Move bytecode v6
}

