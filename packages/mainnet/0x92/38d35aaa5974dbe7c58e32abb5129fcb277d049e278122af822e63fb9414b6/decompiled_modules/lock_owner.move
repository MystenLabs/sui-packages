module 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::lock_owner {
    struct OwnerProof {
        prover: 0x2::object::ID,
        lock: 0x2::object::ID,
        owner: address,
    }

    public fun consume(arg0: OwnerProof) : (0x2::object::ID, 0x2::object::ID, address) {
        let OwnerProof {
            prover : v0,
            lock   : v1,
            owner  : v2,
        } = arg0;
        (v0, v1, v2)
    }

    public(friend) fun issue(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address) : OwnerProof {
        OwnerProof{
            prover : arg0,
            lock   : arg1,
            owner  : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

