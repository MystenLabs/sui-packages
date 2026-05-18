module 0xfecc2a9a2f88c5f18b79f8e841b45a7be20054069efb1a92728eb37d25e617bd::ephemeral_chat {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        treasury: address,
        room_count: u64,
        version: u8,
        public_fee: u64,
        private_fee: u64,
        public_ttl_ms: u64,
        private_ttl_ms: u64,
        max_messages: u64,
    }

    struct Room has key {
        id: 0x2::object::UID,
        room_id: vector<u8>,
        owner: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        owner_pubkey_hex: 0x1::string::String,
        fee_paid: u64,
        status: u8,
        visibility: u8,
        message_count: u64,
        created_at_ms: u64,
        closed_at_ms: u64,
        expires_at_ms: u64,
        version: u8,
        room_key: vector<u8>,
        active_bounty_count: u64,
    }

    struct RoomCreated has copy, drop {
        room: 0x2::object::ID,
        room_id: vector<u8>,
        owner: address,
        fee_paid: u64,
        timestamp_ms: u64,
    }

    struct MessageAdded has copy, drop {
        room: 0x2::object::ID,
        sender: address,
        cid: 0x1::string::String,
        content_hash: vector<u8>,
        index: u64,
        timestamp_ms: u64,
    }

    struct RoomClosed has copy, drop {
        room: 0x2::object::ID,
        room_id: vector<u8>,
        owner: address,
        timestamp_ms: u64,
    }

    public fun active_bounty_count(arg0: &Room) : u64 {
        arg0.active_bounty_count
    }

    public fun add_message(arg0: &Config, arg1: &mut Room, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) <= 96, 4);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 10);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg1.status == 0, 1);
        assert!(v0 < arg1.expires_at_ms, 6);
        assert!(arg1.message_count < arg0.max_messages, 7);
        arg1.message_count = arg1.message_count + 1;
        let v1 = MessageAdded{
            room         : 0x2::object::uid_to_inner(&arg1.id),
            sender       : 0x2::tx_context::sender(arg5),
            cid          : 0x1::string::utf8(arg2),
            content_hash : arg3,
            index        : arg1.message_count,
            timestamp_ms : v0,
        };
        0x2::event::emit<MessageAdded>(v1);
    }

    public fun burn_room_key(arg0: &mut Room, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
        assert!(arg0.visibility == 0, 0);
        assert!(arg0.status == 1, 1);
        arg0.room_key = b"";
        arg0.status = 2;
    }

    public fun close_room(arg0: &mut Room, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 1);
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        assert!(arg0.active_bounty_count == 0, 12);
        arg0.status = 1;
        arg0.closed_at_ms = 0x2::clock::timestamp_ms(arg1);
        let v0 = RoomClosed{
            room         : 0x2::object::uid_to_inner(&arg0.id),
            room_id      : arg0.room_id,
            owner        : arg0.owner,
            timestamp_ms : arg0.closed_at_ms,
        };
        0x2::event::emit<RoomClosed>(v0);
    }

    public fun closed_at_ms(arg0: &Room) : u64 {
        arg0.closed_at_ms
    }

    public fun create_room(arg0: &mut Config, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: bool, arg6: vector<u8>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) == 16, 10);
        assert!(0x1::vector::length<u8>(&arg6) == 32, 10);
        assert!(0x1::vector::length<u8>(&arg2) <= 64, 2);
        assert!(0x1::vector::length<u8>(&arg3) <= 256, 3);
        assert!(0x1::vector::length<u8>(&arg4) <= 130, 5);
        let (v0, v1) = if (arg5) {
            (arg0.public_fee, arg0.public_ttl_ms)
        } else {
            (arg0.private_fee, arg0.private_ttl_ms)
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) >= v0, 11);
        let v2 = 0x2::tx_context::sender(arg9);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg7, v0, arg9), arg0.treasury);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg7) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg7, v2);
        };
        let v3 = 0x2::clock::timestamp_ms(arg8);
        let v4 = if (arg5) {
            0
        } else {
            1
        };
        let v5 = if (arg5) {
            arg6
        } else {
            b""
        };
        let v6 = Room{
            id                  : 0x2::object::new(arg9),
            room_id             : arg1,
            owner               : v2,
            name                : 0x1::string::utf8(arg2),
            description         : 0x1::string::utf8(arg3),
            owner_pubkey_hex    : 0x1::string::utf8(arg4),
            fee_paid            : v0,
            status              : 0,
            visibility          : v4,
            message_count       : 0,
            created_at_ms       : v3,
            closed_at_ms        : 0,
            expires_at_ms       : v3 + v1,
            version             : 5,
            room_key            : v5,
            active_bounty_count : 0,
        };
        arg0.room_count = arg0.room_count + 1;
        let v7 = RoomCreated{
            room         : 0x2::object::uid_to_inner(&v6.id),
            room_id      : v6.room_id,
            owner        : v2,
            fee_paid     : v0,
            timestamp_ms : v3,
        };
        0x2::event::emit<RoomCreated>(v7);
        0x2::transfer::share_object<Room>(v6);
    }

    public fun created_at_ms(arg0: &Room) : u64 {
        arg0.created_at_ms
    }

    public(friend) fun dec_active_bounties(arg0: &mut Room) {
        assert!(arg0.active_bounty_count > 0, 12);
        arg0.active_bounty_count = arg0.active_bounty_count - 1;
    }

    public fun expires_at_ms(arg0: &Room) : u64 {
        arg0.expires_at_ms
    }

    public fun fee_paid(arg0: &Room) : u64 {
        arg0.fee_paid
    }

    public(friend) fun inc_active_bounties(arg0: &mut Room) {
        arg0.active_bounty_count = arg0.active_bounty_count + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = Config{
            id             : 0x2::object::new(arg0),
            treasury       : v0,
            room_count     : 0,
            version        : 3,
            public_fee     : 0,
            private_fee    : 10000000,
            public_ttl_ms  : 259200000,
            private_ttl_ms : 604800000,
            max_messages   : 1000,
        };
        0x2::transfer::share_object<Config>(v2);
    }

    public fun is_open(arg0: &Room) : bool {
        arg0.status == 0
    }

    public fun max_messages(arg0: &Config) : u64 {
        arg0.max_messages
    }

    public fun message_count(arg0: &Room) : u64 {
        arg0.message_count
    }

    public fun owner(arg0: &Room) : address {
        arg0.owner
    }

    public fun private_fee(arg0: &Config) : u64 {
        arg0.private_fee
    }

    public fun private_ttl_ms(arg0: &Config) : u64 {
        arg0.private_ttl_ms
    }

    public fun public_fee(arg0: &Config) : u64 {
        arg0.public_fee
    }

    public fun public_ttl_ms(arg0: &Config) : u64 {
        arg0.public_ttl_ms
    }

    public fun room_count(arg0: &Config) : u64 {
        arg0.room_count
    }

    public fun room_id(arg0: &Room) : &vector<u8> {
        &arg0.room_id
    }

    public fun room_key(arg0: &Room) : &vector<u8> {
        &arg0.room_key
    }

    public fun status(arg0: &Room) : u8 {
        arg0.status
    }

    public fun treasury(arg0: &Config) : address {
        arg0.treasury
    }

    public fun update_fees(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64) {
        arg1.public_fee = arg2;
        arg1.private_fee = arg3;
    }

    public fun update_max_messages(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 > 0, 9);
        arg1.max_messages = arg2;
    }

    public fun update_treasury(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        arg1.treasury = arg2;
    }

    public fun update_ttls(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64) {
        assert!(arg2 > 0, 8);
        assert!(arg3 > 0, 8);
        arg1.public_ttl_ms = arg2;
        arg1.private_ttl_ms = arg3;
    }

    public fun visibility(arg0: &Room) : u8 {
        arg0.visibility
    }

    // decompiled from Move bytecode v7
}

