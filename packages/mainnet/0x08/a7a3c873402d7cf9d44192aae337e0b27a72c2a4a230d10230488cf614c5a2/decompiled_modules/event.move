module 0x8a7a3c873402d7cf9d44192aae337e0b27a72c2a4a230d10230488cf614c5a2::event {
    struct Mint<phantom T0> has copy, drop {
        scoin_amount: u64,
        scable_amount: u64,
    }

    struct Burn<phantom T0> has copy, drop {
        scable_amount: u64,
        scoin_amount: u64,
    }

    struct Claim<phantom T0> has copy, drop {
        amount: u64,
    }

    public(friend) fun emit_burn<T0>(arg0: u64, arg1: u64) {
        let v0 = Burn<T0>{
            scable_amount : arg0,
            scoin_amount  : arg1,
        };
        0x2::event::emit<Burn<T0>>(v0);
    }

    public(friend) fun emit_claim<T0>(arg0: &0x2::coin::Coin<T0>) {
        let v0 = Claim<T0>{amount: 0x2::coin::value<T0>(arg0)};
        0x2::event::emit<Claim<T0>>(v0);
    }

    public(friend) fun emit_mint<T0>(arg0: u64, arg1: u64) {
        let v0 = Mint<T0>{
            scoin_amount  : arg0,
            scable_amount : arg1,
        };
        0x2::event::emit<Mint<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

