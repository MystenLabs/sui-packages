module 0xa18d31960f15ccc95f0f93612fac0c5966b2c4385209566c0343f1996fdd8364::allowlist {
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
        if (!0xa18d31960f15ccc95f0f93612fac0c5966b2c4385209566c0343f1996fdd8364::utils::is_prefix(namespace(arg2), arg1)) {
            return false
        };
        0x1::vector::contains<address>(&arg2.list, &arg0)
    }

    public fun create_allowlist(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : Cap {
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
        v1
    }

    entry fun create_allowlist_entry(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_allowlist(arg0, arg1);
        0x2::transfer::transfer<Cap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun namespace(arg0: &Allowlist) : vector<u8> {
        0x2::object::uid_to_bytes(&arg0.id)
    }

    public fun publish(arg0: &mut Allowlist, arg1: &Cap, arg2: 0x1::string::String) {
        assert!(arg1.allowlist_id == 0x2::object::id<Allowlist>(arg0), 0);
        0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg0.id, arg2, 3);
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

    // decompiled from Move bytecode v6
}

