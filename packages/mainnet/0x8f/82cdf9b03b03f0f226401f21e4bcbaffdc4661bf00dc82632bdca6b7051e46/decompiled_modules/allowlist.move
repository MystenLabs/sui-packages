module 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::allowlist {
    struct Allowlist has key {
        id: 0x2::object::UID,
        per_protocol: 0x2::table::Table<vector<u8>, vector<address>>,
    }

    struct AllowlistCap has store, key {
        id: 0x2::object::UID,
        allowlist_id: 0x2::object::ID,
    }

    public fun contains(arg0: &Allowlist, arg1: vector<u8>, arg2: address) : bool {
        if (!0x2::table::contains<vector<u8>, vector<address>>(&arg0.per_protocol, arg1)) {
            return false
        };
        list_contains(0x2::table::borrow<vector<u8>, vector<address>>(&arg0.per_protocol, arg1), &arg2)
    }

    public fun add(arg0: &mut Allowlist, arg1: &AllowlistCap, arg2: vector<u8>, arg3: address) {
        if (arg1.allowlist_id != 0x2::object::id<Allowlist>(arg0)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_invalid_cap();
        };
        if (!0x2::table::contains<vector<u8>, vector<address>>(&arg0.per_protocol, arg2)) {
            0x2::table::add<vector<u8>, vector<address>>(&mut arg0.per_protocol, arg2, 0x1::vector::empty<address>());
        };
        let v0 = 0x2::table::borrow_mut<vector<u8>, vector<address>>(&mut arg0.per_protocol, arg2);
        if (list_contains(v0, &arg3)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_duplicate_allowlist();
        };
        0x1::vector::push_back<address>(v0, arg3);
    }

    public fun remove(arg0: &mut Allowlist, arg1: &AllowlistCap, arg2: vector<u8>, arg3: address) {
        if (arg1.allowlist_id != 0x2::object::id<Allowlist>(arg0)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_invalid_cap();
        };
        if (!0x2::table::contains<vector<u8>, vector<address>>(&arg0.per_protocol, arg2)) {
            return
        };
        let v0 = list_without(0x2::table::remove<vector<u8>, vector<address>>(&mut arg0.per_protocol, arg2), arg3);
        if (0x1::vector::length<address>(&v0) > 0) {
            0x2::table::add<vector<u8>, vector<address>>(&mut arg0.per_protocol, arg2, v0);
        };
    }

    fun approve_internal(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: &Allowlist) : bool {
        if (!is_prefix(namespace(arg3), arg1)) {
            return false
        };
        contains(arg3, arg2, arg0)
    }

    public fun assessor_count(arg0: &Allowlist, arg1: vector<u8>) : u64 {
        if (!0x2::table::contains<vector<u8>, vector<address>>(&arg0.per_protocol, arg1)) {
            return 0
        };
        (0x1::vector::length<address>(0x2::table::borrow<vector<u8>, vector<address>>(&arg0.per_protocol, arg1)) as u64)
    }

    public fun create_allowlist(arg0: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::admin::GovernanceCap, arg1: &mut 0x2::tx_context::TxContext) : (AllowlistCap, Allowlist) {
        let v0 = Allowlist{
            id           : 0x2::object::new(arg1),
            per_protocol : 0x2::table::new<vector<u8>, vector<address>>(arg1),
        };
        let v1 = AllowlistCap{
            id           : 0x2::object::new(arg1),
            allowlist_id : 0x2::object::id<Allowlist>(&v0),
        };
        (v1, v0)
    }

    entry fun create_allowlist_entry(arg0: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::admin::GovernanceCap, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_allowlist(arg0, arg1);
        0x2::transfer::transfer<AllowlistCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Allowlist>(v1);
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

    fun list_contains(arg0: &vector<address>, arg1: &address) : bool {
        0x1::vector::contains<address>(arg0, arg1)
    }

    fun list_without(arg0: vector<address>, arg1: address) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0)) {
            let v2 = *0x1::vector::borrow<address>(&arg0, v1);
            if (v2 != arg1) {
                0x1::vector::push_back<address>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun namespace(arg0: &Allowlist) : vector<u8> {
        let v0 = 0x2::object::id<Allowlist>(arg0);
        0x2::object::id_to_bytes(&v0)
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: vector<u8>, arg2: &Allowlist, arg3: &0x2::tx_context::TxContext) {
        if (!approve_internal(0x2::tx_context::sender(arg3), arg0, arg1, arg2)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_no_access();
        };
    }

    public fun to_share(arg0: Allowlist) {
        0x2::transfer::share_object<Allowlist>(arg0);
    }

    // decompiled from Move bytecode v6
}

