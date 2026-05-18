module 0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::seal_policies {
    struct Allowlist has store, key {
        id: 0x2::object::UID,
        owner: address,
        members: vector<address>,
    }

    struct Gate has key {
        id: 0x2::object::UID,
        holders: vector<address>,
        owner: address,
    }

    public fun contains(arg0: &Allowlist, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.members, &arg1)
    }

    public fun add_member(arg0: &mut Allowlist, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        if (!0x1::vector::contains<address>(&arg0.members, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.members, arg1);
        };
    }

    public fun allowlist_id_bytes(arg0: &Allowlist) : vector<u8> {
        let v0 = 0x2::object::id<Allowlist>(arg0);
        0x2::bcs::to_bytes<0x2::object::ID>(&v0)
    }

    public fun create_allowlist(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Allowlist>(new_allowlist(arg0));
    }

    public fun create_gate(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Gate{
            id      : 0x2::object::new(arg0),
            holders : vector[],
            owner   : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Gate>(v0);
    }

    public fun grant(arg0: &mut Gate, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        if (!0x1::vector::contains<address>(&arg0.holders, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.holders, arg1);
        };
    }

    public fun new_allowlist(arg0: &mut 0x2::tx_context::TxContext) : Allowlist {
        Allowlist{
            id      : 0x2::object::new(arg0),
            owner   : 0x2::tx_context::sender(arg0),
            members : vector[],
        }
    }

    public fun remove_member(arg0: &mut Allowlist, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.members, &arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.members, v1);
        };
    }

    entry fun seal_approve_allowlist(arg0: vector<u8>, arg1: &Allowlist, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg0) == 48, 1);
        let v0 = 0x2::object::id<Allowlist>(arg1);
        let v1 = 0x2::bcs::to_bytes<0x2::object::ID>(&v0);
        assert!(starts_with(&arg0, &v1), 1);
        assert!(contains(arg1, 0x2::tx_context::sender(arg2)), 0);
    }

    entry fun seal_approve_timelock(arg0: vector<u8>, arg1: &0x2::clock::Clock) {
        assert!(0x1::vector::length<u8>(&arg0) == 24, 1);
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 16, 1);
        assert!(0x2::clock::timestamp_ms(arg1) >= 0x2::bcs::peel_u64(&mut v0), 0);
    }

    entry fun seal_approve_token_gated(arg0: vector<u8>, arg1: &Gate, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg0) == 48, 1);
        let v0 = 0x2::object::id<Gate>(arg1);
        let v1 = 0x2::bcs::to_bytes<0x2::object::ID>(&v0);
        assert!(starts_with(&arg0, &v1), 1);
        let v2 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg1.holders, &v2), 0);
    }

    public fun share_allowlist(arg0: Allowlist) {
        0x2::transfer::public_share_object<Allowlist>(arg0);
    }

    fun starts_with(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg1);
        if (v0 > 0x1::vector::length<u8>(arg0)) {
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

    // decompiled from Move bytecode v6
}

