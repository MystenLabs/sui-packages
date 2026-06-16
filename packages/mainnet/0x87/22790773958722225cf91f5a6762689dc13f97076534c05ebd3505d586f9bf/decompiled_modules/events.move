module 0x8722790773958722225cf91f5a6762689dc13f97076534c05ebd3505d586f9bf::events {
    struct NewPool<phantom T0> has copy, drop {
        pool: address,
    }

    struct NewCommitment<phantom T0> has copy, drop {
        index: u64,
        commitment: u256,
        encrypted_output: vector<u8>,
    }

    struct NullifierSpent<phantom T0> has copy, drop {
        nullifier: u256,
    }

    public(friend) fun new_commitment<T0>(arg0: u64, arg1: u256, arg2: vector<u8>) {
        let v0 = NewCommitment<T0>{
            index            : arg0,
            commitment       : arg1,
            encrypted_output : arg2,
        };
        0x2::event::emit<NewCommitment<T0>>(v0);
    }

    public(friend) fun new_pool<T0>(arg0: address) {
        let v0 = NewPool<T0>{pool: arg0};
        0x2::event::emit<NewPool<T0>>(v0);
    }

    public(friend) fun nullifier_spent<T0>(arg0: u256) {
        let v0 = NullifierSpent<T0>{nullifier: arg0};
        0x2::event::emit<NullifierSpent<T0>>(v0);
    }

    // decompiled from Move bytecode v7
}

