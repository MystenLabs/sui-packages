module 0x868d926b9a07275b2a647ee2ac8267e4a76ff3edc1f238248dee90749917b1b1::thunder {
    struct ThunderDeposited has copy, drop {
        name_hash: vector<u8>,
        timestamp_ms: u64,
    }

    struct ThunderPopped has copy, drop {
        name_hash: vector<u8>,
        blob_id: vector<u8>,
    }

    struct ThunderMailbox has key {
        id: 0x2::object::UID,
    }

    struct ThunderPointer has copy, drop, store {
        blob_id: vector<u8>,
        sealed_namespace: vector<u8>,
        timestamp_ms: u64,
    }

    struct ThunderInbox has store {
        pointers: vector<ThunderPointer>,
    }

    public fun count(arg0: &ThunderMailbox, arg1: vector<u8>) : u64 {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)) {
            return 0
        };
        0x1::vector::length<ThunderPointer>(&0x2::dynamic_field::borrow<vector<u8>, ThunderInbox>(&arg0.id, arg1).pointers)
    }

    entry fun deposit(arg0: &mut ThunderMailbox, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = ThunderPointer{
            blob_id          : arg2,
            sealed_namespace : arg3,
            timestamp_ms     : v0,
        };
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)) {
            0x1::vector::push_back<ThunderPointer>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, ThunderInbox>(&mut arg0.id, arg1).pointers, v1);
        } else {
            let v2 = 0x1::vector::empty<ThunderPointer>();
            0x1::vector::push_back<ThunderPointer>(&mut v2, v1);
            let v3 = ThunderInbox{pointers: v2};
            0x2::dynamic_field::add<vector<u8>, ThunderInbox>(&mut arg0.id, arg1, v3);
        };
        let v4 = ThunderDeposited{
            name_hash    : arg1,
            timestamp_ms : v0,
        };
        0x2::event::emit<ThunderDeposited>(v4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ThunderMailbox{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<ThunderMailbox>(v0);
    }

    fun is_prefix(arg0: vector<u8>, arg1: vector<u8>) : bool {
        if (0x1::vector::length<u8>(&arg0) > 0x1::vector::length<u8>(&arg1)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg0)) {
            if (*0x1::vector::borrow<u8>(&arg0, v0) != *0x1::vector::borrow<u8>(&arg1, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun peek(arg0: &ThunderMailbox, arg1: vector<u8>) : (vector<u8>, vector<u8>, u64) {
        let v0 = 0x2::dynamic_field::borrow<vector<u8>, ThunderInbox>(&arg0.id, arg1);
        assert!(!0x1::vector::is_empty<ThunderPointer>(&v0.pointers), 1);
        let v1 = 0x1::vector::borrow<ThunderPointer>(&v0.pointers, 0);
        (v1.blob_id, v1.sealed_namespace, v1.timestamp_ms)
    }

    entry fun pop(arg0: &mut ThunderMailbox, arg1: vector<u8>, arg2: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg2);
        let v1 = 0x1::string::into_bytes(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::to_string(&v0));
        assert!(0x2::hash::keccak256(&v1) == arg1, 0);
        let v2 = 0x2::dynamic_field::borrow_mut<vector<u8>, ThunderInbox>(&mut arg0.id, arg1);
        assert!(!0x1::vector::is_empty<ThunderPointer>(&v2.pointers), 1);
        let v3 = 0x1::vector::remove<ThunderPointer>(&mut v2.pointers, 0);
        let v4 = ThunderPopped{
            name_hash : arg1,
            blob_id   : v3.blob_id,
        };
        0x2::event::emit<ThunderPopped>(v4);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg1);
        let v1 = 0x1::string::into_bytes(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::to_string(&v0));
        assert!(is_prefix(0x2::hash::keccak256(&v1), arg0), 0);
    }

    // decompiled from Move bytecode v6
}

