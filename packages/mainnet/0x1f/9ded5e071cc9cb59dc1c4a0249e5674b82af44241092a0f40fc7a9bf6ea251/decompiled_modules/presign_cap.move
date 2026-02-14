module 0x1f9ded5e071cc9cb59dc1c4a0249e5674b82af44241092a0f40fc7a9bf6ea251::presign_cap {
    struct PresignCap<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        wallet_key: u64,
        cap: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap,
    }

    public(friend) fun new<T0: drop>(arg0: u64, arg1: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap, arg2: &mut 0x2::tx_context::TxContext) : PresignCap<T0> {
        PresignCap<T0>{
            id         : 0x2::object::new(arg2),
            wallet_key : arg0,
            cap        : arg1,
        }
    }

    public(friend) fun destroy<T0: drop>(arg0: PresignCap<T0>) : (u64, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap) {
        let PresignCap {
            id         : v0,
            wallet_key : v1,
            cap        : v2,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v2)
    }

    public fun wallet_key<T0: drop>(arg0: &PresignCap<T0>) : u64 {
        arg0.wallet_key
    }

    // decompiled from Move bytecode v6
}

