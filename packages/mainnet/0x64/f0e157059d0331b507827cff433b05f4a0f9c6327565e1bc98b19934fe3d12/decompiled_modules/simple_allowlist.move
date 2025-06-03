module 0x64f0e157059d0331b507827cff433b05f4a0f9c6327565e1bc98b19934fe3d12::simple_allowlist {
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

    public fun check_access(arg0: &Allowlist, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.list, &arg1)
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

    // decompiled from Move bytecode v6
}

