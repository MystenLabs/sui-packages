module 0x6d679072c7d5aae395bc8963d1f096bae49816245f87c15ca418b70dedc42e0b::paying_system {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PayingInfo has store, key {
        id: 0x2::object::UID,
        public_key: vector<u8>,
        nonce_table: 0x2::table::Table<address, u64>,
    }

    struct CoinEvent has copy, drop {
        operator: address,
        recipient: address,
        object_type: 0x1::ascii::String,
        object_balance: u64,
        code: u8,
        message: 0x1::string::String,
    }

    struct ObjectEvent has copy, drop {
        operator: address,
        recipient: address,
        object_type: 0x1::ascii::String,
        object_number: u64,
        object_ids: vector<0x2::object::ID>,
        code: u8,
        message: 0x1::string::String,
    }

    public fun get_public_key(arg0: &PayingInfo) : vector<u8> {
        arg0.public_key
    }

    public fun get_user_nonce(arg0: &PayingInfo, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(&arg0.nonce_table, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = PayingInfo{
            id          : 0x2::object::new(arg0),
            public_key  : 0x1::vector::empty<u8>(),
            nonce_table : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::public_share_object<PayingInfo>(v1);
    }

    fun make_coin_message(arg0: address, arg1: address, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: 0x1::string::String) : vector<u8> {
        let v0 = 0x2::address::to_bytes(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::type_name::TypeName>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u8>(&arg6));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&arg7));
        0x2::hash::blake2b256(&v0)
    }

    fun make_object_message<T0: key>(arg0: address, arg1: address, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: &vector<T0>, arg5: u64, arg6: u64, arg7: u8, arg8: 0x1::string::String) : (vector<u8>, vector<0x2::object::ID>) {
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
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u8>(&arg7));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&arg8));
        (0x2::hash::blake2b256(&v0), v2)
    }

    public fun remove_verifying_public_key(arg0: &AdminCap, arg1: &mut PayingInfo) {
        arg1.public_key = 0x1::vector::empty<u8>();
    }

    public fun set_verifying_public_key(arg0: &AdminCap, arg1: &mut PayingInfo, arg2: vector<u8>) {
        arg1.public_key = arg2;
    }

    public fun transfer_coin<T0>(arg0: &mut PayingInfo, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: u64, arg5: u8, arg6: 0x1::string::String, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0x2::clock::timestamp_ms(arg8), 2);
        assert!(0x2::coin::value<T0>(&arg1) == arg2, 1);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x1::type_name::get<0x2::coin::Coin<T0>>();
        let v2 = 0;
        if (0x2::table::contains<address, u64>(&arg0.nonce_table, v0)) {
            v2 = 0x2::table::remove<address, u64>(&mut arg0.nonce_table, v0);
        };
        assert!(verify_message(arg7, arg0.public_key, make_coin_message(v0, arg3, v1, arg2, v2, arg4, arg5, arg6)), 0);
        if (v2 == 18446744073709551615) {
            v2 = 0;
        } else {
            v2 = v2 + 1;
        };
        0x2::table::add<address, u64>(&mut arg0.nonce_table, v0, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg3);
        let v3 = CoinEvent{
            operator       : v0,
            recipient      : arg3,
            object_type    : 0x1::type_name::into_string(v1),
            object_balance : arg2,
            code           : arg5,
            message        : arg6,
        };
        0x2::event::emit<CoinEvent>(v3);
    }

    public fun transfer_nfts<T0>(arg0: &mut PayingInfo, arg1: vector<0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::nonfungible::Nft<T0>>, arg2: address, arg3: u64, arg4: u8, arg5: 0x1::string::String, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0x2::clock::timestamp_ms(arg7), 2);
        let v0 = 0x1::type_name::get<0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::nonfungible::Nft<T0>>();
        let v1 = 0x1::vector::length<0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::nonfungible::Nft<T0>>(&arg1);
        let v2 = 0x2::tx_context::sender(arg8);
        let v3 = 0;
        if (0x2::table::contains<address, u64>(&arg0.nonce_table, v2)) {
            v3 = 0x2::table::remove<address, u64>(&mut arg0.nonce_table, v2);
        };
        let (v4, v5) = make_object_message<0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::nonfungible::Nft<T0>>(v2, arg2, v0, v1, &arg1, v3, arg3, arg4, arg5);
        assert!(verify_message(arg6, arg0.public_key, v4), 0);
        if (v3 == 18446744073709551615) {
            v3 = 0;
        } else {
            v3 = v3 + 1;
        };
        0x2::table::add<address, u64>(&mut arg0.nonce_table, v2, v3);
        while (!0x1::vector::is_empty<0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::nonfungible::Nft<T0>>(&arg1)) {
            0x2::transfer::public_transfer<0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::nonfungible::Nft<T0>>(0x1::vector::pop_back<0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::nonfungible::Nft<T0>>(&mut arg1), arg2);
        };
        0x1::vector::destroy_empty<0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::nonfungible::Nft<T0>>(arg1);
        let v6 = ObjectEvent{
            operator      : v2,
            recipient     : arg2,
            object_type   : 0x1::type_name::into_string(v0),
            object_number : v1,
            object_ids    : v5,
            code          : arg4,
            message       : arg5,
        };
        0x2::event::emit<ObjectEvent>(v6);
    }

    public fun transfer_objects<T0: store + key>(arg0: &mut PayingInfo, arg1: vector<T0>, arg2: address, arg3: u64, arg4: u8, arg5: 0x1::string::String, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0x2::clock::timestamp_ms(arg7), 2);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::vector::length<T0>(&arg1);
        let v2 = 0x2::tx_context::sender(arg8);
        let v3 = 0;
        if (0x2::table::contains<address, u64>(&arg0.nonce_table, v2)) {
            v3 = 0x2::table::remove<address, u64>(&mut arg0.nonce_table, v2);
        };
        let (v4, v5) = make_object_message<T0>(v2, arg2, v0, v1, &arg1, v3, arg3, arg4, arg5);
        assert!(verify_message(arg6, arg0.public_key, v4), 0);
        if (v3 == 18446744073709551615) {
            v3 = 0;
        } else {
            v3 = v3 + 1;
        };
        0x2::table::add<address, u64>(&mut arg0.nonce_table, v2, v3);
        while (!0x1::vector::is_empty<T0>(&arg1)) {
            0x2::transfer::public_transfer<T0>(0x1::vector::pop_back<T0>(&mut arg1), arg2);
        };
        0x1::vector::destroy_empty<T0>(arg1);
        let v6 = ObjectEvent{
            operator      : v2,
            recipient     : arg2,
            object_type   : 0x1::type_name::into_string(v0),
            object_number : v1,
            object_ids    : v5,
            code          : arg4,
            message       : arg5,
        };
        0x2::event::emit<ObjectEvent>(v6);
    }

    public fun transfer_sbts<T0>(arg0: &mut PayingInfo, arg1: vector<0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::soulbound::Sbt<T0>>, arg2: address, arg3: u64, arg4: u8, arg5: 0x1::string::String, arg6: vector<u8>, arg7: &mut 0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::soulbound::OperatorCap<T0>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0x2::clock::timestamp_ms(arg9), 2);
        let v0 = 0x1::type_name::get<0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::soulbound::Sbt<T0>>();
        let v1 = 0x1::vector::length<0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::soulbound::Sbt<T0>>(&arg1);
        let v2 = 0x2::tx_context::sender(arg10);
        let v3 = 0;
        if (0x2::table::contains<address, u64>(&arg0.nonce_table, v2)) {
            v3 = 0x2::table::remove<address, u64>(&mut arg0.nonce_table, v2);
        };
        let (v4, v5) = make_object_message<0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::soulbound::Sbt<T0>>(v2, arg2, v0, v1, &arg1, v3, arg3, arg4, arg5);
        assert!(verify_message(arg6, arg0.public_key, v4), 0);
        if (v3 == 18446744073709551615) {
            v3 = 0;
        } else {
            v3 = v3 + 1;
        };
        0x2::table::add<address, u64>(&mut arg0.nonce_table, v2, v3);
        let v6 = 0x1::vector::singleton<address>(arg2);
        while (0x1::vector::length<address>(&v6) < v1) {
            0x1::vector::push_back<address>(&mut v6, arg2);
        };
        0xc333c671dd102324ee32517420fc3faa7d147e424cb8db2d7b6a925108dbf98f::soulbound::batch_transfer<T0>(arg7, arg1, v6, arg3, arg8, arg9, arg10);
        let v7 = ObjectEvent{
            operator      : v2,
            recipient     : arg2,
            object_type   : 0x1::type_name::into_string(v0),
            object_number : v1,
            object_ids    : v5,
            code          : arg4,
            message       : arg5,
        };
        0x2::event::emit<ObjectEvent>(v7);
    }

    fun verify_message(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : bool {
        0x2::ed25519::ed25519_verify(&arg0, &arg1, &arg2)
    }

    // decompiled from Move bytecode v6
}

