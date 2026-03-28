module 0xab627152bfbafeb06f567c1932f4d2eba11799160042219d2edaa0706c306ee6::thunder {
    struct Signaled has copy, drop {
        name_hash: vector<u8>,
        timestamp_ms: u64,
    }

    struct Questfi has copy, drop {
        name_hash: vector<u8>,
        payload: vector<u8>,
        aes_key: vector<u8>,
        aes_nonce: vector<u8>,
    }

    struct Storm has key {
        id: 0x2::object::UID,
    }

    struct Signal has copy, drop, store {
        payload: vector<u8>,
        aes_key: vector<u8>,
        aes_nonce: vector<u8>,
        timestamp_ms: u64,
    }

    struct Ragtag has store {
        signals: vector<Signal>,
        last_activity_ms: u64,
    }

    public fun count(arg0: &Storm, arg1: vector<u8>) : u64 {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)) {
            return 0
        };
        0x1::vector::length<Signal>(&0x2::dynamic_field::borrow<vector<u8>, Ragtag>(&arg0.id, arg1).signals)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Storm{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Storm>(v0);
    }

    entry fun quest(arg0: &mut Storm, arg1: vector<u8>, arg2: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg2);
        let v1 = 0x1::string::into_bytes(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::to_string(&v0));
        assert!(0x2::hash::keccak256(&v1) == arg1, 0);
        let v2 = 0x2::dynamic_field::borrow_mut<vector<u8>, Ragtag>(&mut arg0.id, arg1);
        assert!(!0x1::vector::is_empty<Signal>(&v2.signals), 1);
        let v3 = 0x1::vector::remove<Signal>(&mut v2.signals, 0);
        v2.last_activity_ms = 0x2::clock::timestamp_ms(arg3);
        let v4 = 0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(arg2);
        let v5 = 0x2::object::id_to_bytes(&v4);
        let v6 = Questfi{
            name_hash : arg1,
            payload   : v3.payload,
            aes_key   : xor_bytes(v3.aes_key, 0x2::hash::keccak256(&v5)),
            aes_nonce : v3.aes_nonce,
        };
        0x2::event::emit<Questfi>(v6);
    }

    entry fun signal(arg0: &mut Storm, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = Signal{
            payload      : arg2,
            aes_key      : arg3,
            aes_nonce    : arg4,
            timestamp_ms : v0,
        };
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)) {
            let v2 = 0x2::dynamic_field::borrow_mut<vector<u8>, Ragtag>(&mut arg0.id, arg1);
            0x1::vector::push_back<Signal>(&mut v2.signals, v1);
            v2.last_activity_ms = v0;
        } else {
            let v3 = 0x1::vector::empty<Signal>();
            0x1::vector::push_back<Signal>(&mut v3, v1);
            let v4 = Ragtag{
                signals          : v3,
                last_activity_ms : v0,
            };
            0x2::dynamic_field::add<vector<u8>, Ragtag>(&mut arg0.id, arg1, v4);
        };
        let v5 = Signaled{
            name_hash    : arg1,
            timestamp_ms : v0,
        };
        0x2::event::emit<Signaled>(v5);
    }

    entry fun sweep(arg0: &mut Storm, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_field::borrow<vector<u8>, Ragtag>(&arg0.id, arg1);
        assert!(0x1::vector::is_empty<Signal>(&v0.signals), 1);
        assert!(0x2::clock::timestamp_ms(arg2) >= v0.last_activity_ms + 604800000, 2);
        let Ragtag {
            signals          : _,
            last_activity_ms : _,
        } = 0x2::dynamic_field::remove<vector<u8>, Ragtag>(&mut arg0.id, arg1);
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

