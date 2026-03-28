module 0x6e38812f93d06b6933ba72101357e2905566cd55681469e10b13c7e7507c77b1::thunder {
    struct ThunderDeposited has copy, drop {
        name_hash: vector<u8>,
        timestamp_ms: u64,
    }

    struct ThunderStruck has copy, drop {
        name_hash: vector<u8>,
        payload: vector<u8>,
        aes_key: vector<u8>,
        aes_nonce: vector<u8>,
    }

    struct Thunder has key {
        id: 0x2::object::UID,
    }

    struct ThunderBolt has copy, drop, store {
        payload: vector<u8>,
        aes_key: vector<u8>,
        aes_nonce: vector<u8>,
        timestamp_ms: u64,
    }

    struct ThunderInbox has store {
        bolts: vector<ThunderBolt>,
    }

    public fun count(arg0: &Thunder, arg1: vector<u8>) : u64 {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)) {
            return 0
        };
        0x1::vector::length<ThunderBolt>(&0x2::dynamic_field::borrow<vector<u8>, ThunderInbox>(&arg0.id, arg1).bolts)
    }

    entry fun deposit(arg0: &mut Thunder, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = ThunderBolt{
            payload      : arg2,
            aes_key      : arg3,
            aes_nonce    : arg4,
            timestamp_ms : v0,
        };
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)) {
            0x1::vector::push_back<ThunderBolt>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, ThunderInbox>(&mut arg0.id, arg1).bolts, v1);
        } else {
            let v2 = 0x1::vector::empty<ThunderBolt>();
            0x1::vector::push_back<ThunderBolt>(&mut v2, v1);
            let v3 = ThunderInbox{bolts: v2};
            0x2::dynamic_field::add<vector<u8>, ThunderInbox>(&mut arg0.id, arg1, v3);
        };
        let v4 = ThunderDeposited{
            name_hash    : arg1,
            timestamp_ms : v0,
        };
        0x2::event::emit<ThunderDeposited>(v4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Thunder{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Thunder>(v0);
    }

    entry fun strike(arg0: &mut Thunder, arg1: vector<u8>, arg2: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg2);
        let v1 = 0x1::string::into_bytes(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::to_string(&v0));
        assert!(0x2::hash::keccak256(&v1) == arg1, 0);
        let v2 = 0x2::dynamic_field::borrow_mut<vector<u8>, ThunderInbox>(&mut arg0.id, arg1);
        assert!(!0x1::vector::is_empty<ThunderBolt>(&v2.bolts), 1);
        let v3 = 0x1::vector::remove<ThunderBolt>(&mut v2.bolts, 0);
        if (0x1::vector::is_empty<ThunderBolt>(&v2.bolts)) {
            let ThunderInbox {  } = 0x2::dynamic_field::remove<vector<u8>, ThunderInbox>(&mut arg0.id, arg1);
        };
        let v4 = 0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(arg2);
        let v5 = 0x2::object::id_to_bytes(&v4);
        let v6 = ThunderStruck{
            name_hash : arg1,
            payload   : v3.payload,
            aes_key   : xor_bytes(v3.aes_key, 0x2::hash::keccak256(&v5)),
            aes_nonce : v3.aes_nonce,
        };
        0x2::event::emit<ThunderStruck>(v6);
    }

    fun xor_bytes(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0, v1) ^ *0x1::vector::borrow<u8>(&arg1, v1 % 0x1::vector::length<u8>(&arg1)));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

