module 0x6d679072c7d5aae395bc8963d1f096bae49816245f87c15ca418b70dedc42e0b::event_paying_system {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct EventInfo has store, key {
        id: 0x2::object::UID,
        public_key: vector<u8>,
        total_count: u64,
        current_count: u64,
        deadline: u64,
        nonce_table: 0x2::table::Table<address, u64>,
    }

    struct RegisterEvent has copy, drop {
        event_id: 0x2::object::ID,
        total_count: u64,
        deadline: u64,
    }

    struct DeleteEvent has copy, drop {
        event_id: 0x2::object::ID,
        total_count: u64,
        current_count: u64,
        deadline: u64,
    }

    struct CoinEvent has copy, drop {
        event_id: 0x2::object::ID,
        event_count: u64,
        transfer_count: u64,
        operator: address,
        recipient: address,
        object_type: 0x1::ascii::String,
        object_balance: u64,
        code: u8,
        message: 0x1::string::String,
    }

    struct ObjectEvent has copy, drop {
        event_id: 0x2::object::ID,
        event_count: u64,
        transfer_count: u64,
        operator: address,
        recipient: address,
        object_type: 0x1::ascii::String,
        object_number: u64,
        object_ids: vector<0x2::object::ID>,
        code: u8,
        message: 0x1::string::String,
    }

    public fun change_deadline(arg0: &AdminCap, arg1: &mut EventInfo, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg2 > 0x2::clock::timestamp_ms(arg3), 0);
        arg1.deadline = arg2;
    }

    public fun change_public_key(arg0: &AdminCap, arg1: &mut EventInfo, arg2: vector<u8>) {
        arg1.public_key = arg2;
    }

    public fun change_total_count(arg0: &AdminCap, arg1: &mut EventInfo, arg2: u64) {
        assert!(arg2 >= arg1.current_count, 5);
        arg1.total_count = arg2;
    }

    public fun delete_event(arg0: &AdminCap, arg1: EventInfo, arg2: &0x2::clock::Clock) {
        assert!(arg1.deadline < 0x2::clock::timestamp_ms(arg2), 4);
        let EventInfo {
            id            : v0,
            public_key    : _,
            total_count   : v2,
            current_count : v3,
            deadline      : v4,
            nonce_table   : v5,
        } = arg1;
        let v6 = v0;
        0x2::table::drop<address, u64>(v5);
        let v7 = DeleteEvent{
            event_id      : 0x2::object::uid_to_inner(&v6),
            total_count   : v2,
            current_count : v3,
            deadline      : v4,
        };
        0x2::event::emit<DeleteEvent>(v7);
        0x2::object::delete(v6);
    }

    public fun get_current_count(arg0: &EventInfo) : u64 {
        arg0.current_count
    }

    public fun get_deadline(arg0: &EventInfo) : u64 {
        arg0.deadline
    }

    public fun get_public_key(arg0: &EventInfo) : vector<u8> {
        arg0.public_key
    }

    public fun get_total_count(arg0: &EventInfo) : u64 {
        arg0.total_count
    }

    public fun get_user_nonce(arg0: &EventInfo, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(&arg0.nonce_table, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun make_coin_message(arg0: address, arg1: address, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: &0x2::object::ID, arg6: u64, arg7: u64, arg8: u8, arg9: 0x1::string::String) : vector<u8> {
        let v0 = 0x2::address::to_bytes(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::type_name::TypeName>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(arg5));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg7));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u8>(&arg8));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&arg9));
        0x2::hash::blake2b256(&v0)
    }

    fun make_object_message<T0: key>(arg0: address, arg1: address, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: &vector<T0>, arg5: u64, arg6: &0x2::object::ID, arg7: u64, arg8: u64, arg9: u8, arg10: 0x1::string::String) : (vector<u8>, vector<0x2::object::ID>) {
        let v0 = 0x2::address::to_bytes(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::type_name::TypeName>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        let v1 = 0;
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        while (v1 < 0x1::vector::length<T0>(arg4)) {
            let v3 = 0x1::vector::borrow<T0>(arg4, v1);
            0x1::vector::push_back<0x2::object::ID>(&mut v2, 0x2::object::id<T0>(v3));
            0x1::vector::append<u8>(&mut v0, 0x2::object::id_bytes<T0>(v3));
            v1 = v1 + 1;
        };
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(arg6));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg7));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg8));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u8>(&arg9));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&arg10));
        (0x2::hash::blake2b256(&v0), v2)
    }

    public fun register_event(arg0: &AdminCap, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = EventInfo{
            id            : 0x2::object::new(arg4),
            public_key    : arg1,
            total_count   : arg2,
            current_count : 0,
            deadline      : arg3,
            nonce_table   : 0x2::table::new<address, u64>(arg4),
        };
        let v1 = RegisterEvent{
            event_id    : 0x2::object::uid_to_inner(&v0.id),
            total_count : arg2,
            deadline    : arg3,
        };
        0x2::event::emit<RegisterEvent>(v1);
        0x2::transfer::share_object<EventInfo>(v0);
    }

    public fun transfer_coin<T0>(arg0: &mut EventInfo, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: address, arg5: u64, arg6: u8, arg7: 0x1::string::String, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.deadline > 0x2::clock::timestamp_ms(arg9), 0);
        assert!(arg5 > 0x2::clock::timestamp_ms(arg9), 6);
        assert!(arg0.current_count + arg3 <= arg0.total_count, 1);
        assert!(0x2::coin::value<T0>(&arg1) == arg2, 3);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x1::type_name::get<0x2::coin::Coin<T0>>();
        let v2 = 0;
        if (0x2::table::contains<address, u64>(&arg0.nonce_table, v0)) {
            v2 = 0x2::table::remove<address, u64>(&mut arg0.nonce_table, v0);
        };
        assert!(verify_message(arg8, arg0.public_key, make_coin_message(v0, arg4, v1, arg2, arg5, 0x2::object::borrow_id<EventInfo>(arg0), v2, arg3, arg6, arg7)), 2);
        arg0.current_count = arg0.current_count + arg3;
        0x2::table::add<address, u64>(&mut arg0.nonce_table, v0, v2 + 1);
        let v3 = CoinEvent{
            event_id       : 0x2::object::uid_to_inner(&arg0.id),
            event_count    : arg0.current_count,
            transfer_count : arg3,
            operator       : v0,
            recipient      : arg4,
            object_type    : 0x1::type_name::into_string(v1),
            object_balance : 0x2::coin::value<T0>(&arg1),
            code           : arg6,
            message        : arg7,
        };
        0x2::event::emit<CoinEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg4);
    }

    public fun transfer_nfts<T0>(arg0: &mut EventInfo, arg1: vector<0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::nonfungible::Nft<T0>>, arg2: u64, arg3: address, arg4: u64, arg5: u8, arg6: 0x1::string::String, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.deadline > 0x2::clock::timestamp_ms(arg8), 0);
        assert!(arg4 > 0x2::clock::timestamp_ms(arg8), 6);
        assert!(arg0.current_count + arg2 <= arg0.total_count, 1);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x1::type_name::get<0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::nonfungible::Nft<T0>>();
        let v2 = 0x1::vector::length<0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::nonfungible::Nft<T0>>(&arg1);
        let v3 = 0;
        if (0x2::table::contains<address, u64>(&arg0.nonce_table, v0)) {
            v3 = 0x2::table::remove<address, u64>(&mut arg0.nonce_table, v0);
        };
        let (v4, v5) = make_object_message<0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::nonfungible::Nft<T0>>(v0, arg3, v1, v2, &arg1, arg4, 0x2::object::borrow_id<EventInfo>(arg0), v3, arg2, arg5, arg6);
        assert!(verify_message(arg7, arg0.public_key, v4), 2);
        arg0.current_count = arg0.current_count + arg2;
        0x2::table::add<address, u64>(&mut arg0.nonce_table, v0, v3 + 1);
        let v6 = ObjectEvent{
            event_id       : 0x2::object::uid_to_inner(&arg0.id),
            event_count    : arg0.current_count,
            transfer_count : arg2,
            operator       : v0,
            recipient      : arg3,
            object_type    : 0x1::type_name::into_string(v1),
            object_number  : v2,
            object_ids     : v5,
            code           : arg5,
            message        : arg6,
        };
        0x2::event::emit<ObjectEvent>(v6);
        while (!0x1::vector::is_empty<0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::nonfungible::Nft<T0>>(&arg1)) {
            0x2::transfer::public_transfer<0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::nonfungible::Nft<T0>>(0x1::vector::pop_back<0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::nonfungible::Nft<T0>>(&mut arg1), arg3);
        };
        0x1::vector::destroy_empty<0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::nonfungible::Nft<T0>>(arg1);
    }

    public fun transfer_objects<T0: store + key>(arg0: &mut EventInfo, arg1: vector<T0>, arg2: u64, arg3: address, arg4: u64, arg5: u8, arg6: 0x1::string::String, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.deadline > 0x2::clock::timestamp_ms(arg8), 0);
        assert!(arg4 > 0x2::clock::timestamp_ms(arg8), 6);
        assert!(arg0.current_count + arg2 <= arg0.total_count, 1);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x1::vector::length<T0>(&arg1);
        let v3 = 0;
        if (0x2::table::contains<address, u64>(&arg0.nonce_table, v0)) {
            v3 = 0x2::table::remove<address, u64>(&mut arg0.nonce_table, v0);
        };
        let (v4, v5) = make_object_message<T0>(v0, arg3, v1, v2, &arg1, arg4, 0x2::object::borrow_id<EventInfo>(arg0), v3, arg2, arg5, arg6);
        assert!(verify_message(arg7, arg0.public_key, v4), 2);
        arg0.current_count = arg0.current_count + arg2;
        0x2::table::add<address, u64>(&mut arg0.nonce_table, v0, v3 + 1);
        let v6 = ObjectEvent{
            event_id       : 0x2::object::uid_to_inner(&arg0.id),
            event_count    : arg0.current_count,
            transfer_count : arg2,
            operator       : v0,
            recipient      : arg3,
            object_type    : 0x1::type_name::into_string(v1),
            object_number  : v2,
            object_ids     : v5,
            code           : arg5,
            message        : arg6,
        };
        0x2::event::emit<ObjectEvent>(v6);
        while (!0x1::vector::is_empty<T0>(&arg1)) {
            0x2::transfer::public_transfer<T0>(0x1::vector::pop_back<T0>(&mut arg1), arg3);
        };
        0x1::vector::destroy_empty<T0>(arg1);
    }

    public fun transfer_sbts<T0>(arg0: &mut EventInfo, arg1: vector<0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::soulbound::Sbt<T0>>, arg2: u64, arg3: address, arg4: u64, arg5: u8, arg6: 0x1::string::String, arg7: vector<u8>, arg8: &mut 0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::soulbound::OperatorCap<T0>, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.deadline > 0x2::clock::timestamp_ms(arg10), 0);
        assert!(arg4 > 0x2::clock::timestamp_ms(arg10), 6);
        assert!(arg0.current_count + arg2 <= arg0.total_count, 1);
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x1::type_name::get<0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::soulbound::Sbt<T0>>();
        let v2 = 0x1::vector::length<0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::soulbound::Sbt<T0>>(&arg1);
        let v3 = 0;
        if (0x2::table::contains<address, u64>(&arg0.nonce_table, v0)) {
            v3 = 0x2::table::remove<address, u64>(&mut arg0.nonce_table, v0);
        };
        let (v4, v5) = make_object_message<0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::soulbound::Sbt<T0>>(v0, arg3, v1, v2, &arg1, arg4, 0x2::object::borrow_id<EventInfo>(arg0), v3, arg2, arg5, arg6);
        assert!(verify_message(arg7, arg0.public_key, v4), 2);
        arg0.current_count = arg0.current_count + arg2;
        0x2::table::add<address, u64>(&mut arg0.nonce_table, v0, v3 + 1);
        let v6 = ObjectEvent{
            event_id       : 0x2::object::uid_to_inner(&arg0.id),
            event_count    : arg0.current_count,
            transfer_count : arg2,
            operator       : v0,
            recipient      : arg3,
            object_type    : 0x1::type_name::into_string(v1),
            object_number  : v2,
            object_ids     : v5,
            code           : arg5,
            message        : arg6,
        };
        0x2::event::emit<ObjectEvent>(v6);
        let v7 = 0x1::vector::singleton<address>(arg3);
        while (0x1::vector::length<address>(&v7) < v2) {
            0x1::vector::push_back<address>(&mut v7, arg3);
        };
        0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::soulbound::batch_transfer<T0>(arg8, arg1, v7, arg4, arg9, arg10, arg11);
    }

    fun verify_message(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : bool {
        0x2::ed25519::ed25519_verify(&arg0, &arg1, &arg2)
    }

    // decompiled from Move bytecode v6
}

