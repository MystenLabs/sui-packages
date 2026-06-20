module 0x693d8efd850e82847d774680d6b1741fb123fc98a1994bc650ec2c6cea3de1ec::wholesale {
    struct Allowlist has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        list: vector<address>,
    }

    struct Cap has key {
        id: 0x2::object::UID,
        allowlist_id: 0x2::object::ID,
    }

    public fun add(arg0: &mut Allowlist, arg1: &Cap, arg2: address) {
        assert!(arg1.allowlist_id == 0x2::object::id<Allowlist>(arg0), 0);
        assert!(!0x1::vector::contains<address>(&arg0.list, &arg2), 2);
        0x1::vector::push_back<address>(&mut arg0.list, arg2);
    }

    fun approve_internal(arg0: address, arg1: vector<u8>, arg2: &Allowlist) : bool {
        let v0 = namespace(arg2);
        if (!is_prefix(&v0, &arg1)) {
            return false
        };
        0x1::vector::contains<address>(&arg2.list, &arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = vector[];
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = Allowlist{
            id   : 0x2::object::new(arg0),
            name : 0x1::string::utf8(b"Wilson Wholesale PDFs"),
            list : v0,
        };
        let v2 = Cap{
            id           : 0x2::object::new(arg0),
            allowlist_id : 0x2::object::id<Allowlist>(&v1),
        };
        0x2::transfer::share_object<Allowlist>(v1);
        0x2::transfer::transfer<Cap>(v2, 0x2::tx_context::sender(arg0));
    }

    fun is_prefix(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (0x1::vector::length<u8>(arg1) < v0) {
            return false
        };
        let v1 = 0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<u8>(arg0, v1) != *0x1::vector::borrow<u8>(arg1, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun namespace(arg0: &Allowlist) : vector<u8> {
        0x2::object::uid_to_bytes(&arg0.id)
    }

    public fun remove(arg0: &mut Allowlist, arg1: &Cap, arg2: address) {
        assert!(arg1.allowlist_id == 0x2::object::id<Allowlist>(arg0), 0);
        let v0 = vector[];
        let v1 = arg0.list;
        0x1::vector::reverse<address>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v1)) {
            let v3 = 0x1::vector::pop_back<address>(&mut v1);
            if (&v3 != &arg2) {
                0x1::vector::push_back<address>(&mut v0, v3);
            };
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<address>(v1);
        arg0.list = v0;
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &Allowlist, arg2: &0x2::tx_context::TxContext) {
        assert!(approve_internal(0x2::tx_context::sender(arg2), arg0, arg1), 1);
    }

    // decompiled from Move bytecode v7
}

