module 0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::faucets {
    struct Faucet<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
    }

    public fun new<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Faucet<T0>{
            id           : 0x2::object::new(arg1),
            treasury_cap : arg0,
        };
        0x2::transfer::public_share_object<Faucet<T0>>(v0);
    }

    public fun get_coins<T0>(arg0: &mut Faucet<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::mint<T0>(&mut arg0.treasury_cap, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

