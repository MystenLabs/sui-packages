module 0xd8bbab10d5e675e99e6619c66289dc244d5408431941350b3c0d586191883b2::protected {
    struct ProtectedMarket {
        market: 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market,
    }

    public(friend) fun borrow_mut(arg0: &mut ProtectedMarket) : &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market {
        &mut arg0.market
    }

    public fun protect(arg0: 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) : ProtectedMarket {
        ProtectedMarket{market: arg0}
    }

    public fun unprotect_and_reshare(arg0: ProtectedMarket) {
        let ProtectedMarket { market: v0 } = arg0;
        0x2::transfer::public_share_object<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(v0);
    }

    // decompiled from Move bytecode v6
}

