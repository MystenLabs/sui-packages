module 0x4aab477658df9ad6a0717201cb4b474919f482c986c137d7ec0de6f2b8d0e39a::allowlist {
    struct Allowlist has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        list: vector<address>,
    }

    struct Cap has key {
        id: 0x2::object::UID,
        allowlist_id: 0x2::object::ID,
    }

    public entry fun remove(arg0: &mut Allowlist, arg1: &Cap, arg2: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.list, &arg2);
        assert!(v0, 2);
        0x1::vector::remove<address>(&mut arg0.list, v1);
    }

    public entry fun add(arg0: &mut Allowlist, arg1: &Cap, arg2: address) {
        assert!(!0x1::vector::contains<address>(&arg0.list, &arg2), 1);
        0x1::vector::push_back<address>(&mut arg0.list, arg2);
    }

    public entry fun create(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Allowlist{
            id   : 0x2::object::new(arg1),
            name : arg0,
            list : 0x1::vector::empty<address>(),
        };
        let v1 = Cap{
            id           : 0x2::object::new(arg1),
            allowlist_id : 0x2::object::id<Allowlist>(&v0),
        };
        0x2::transfer::share_object<Allowlist>(v0);
        0x2::transfer::transfer<Cap>(v1, 0x2::tx_context::sender(arg1));
    }

    fun is_prefix(arg0: vector<u8>, arg1: vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(&arg0);
        if (v0 > 0x1::vector::length<u8>(&arg1)) {
            return false
        };
        let v1 = 0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<u8>(&arg0, v1) != *0x1::vector::borrow<u8>(&arg1, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public entry fun publish(arg0: &mut Allowlist, arg1: &Cap, arg2: 0x1::string::String) {
        0x2::dynamic_field::add<0x1::string::String, bool>(&mut arg0.id, arg2, true);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &Allowlist, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Allowlist>(arg1);
        assert!(is_prefix(0x2::object::id_to_bytes(&v0), arg0), 0);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg1.list, &v1), 0);
    }

    // decompiled from Move bytecode v6
}

