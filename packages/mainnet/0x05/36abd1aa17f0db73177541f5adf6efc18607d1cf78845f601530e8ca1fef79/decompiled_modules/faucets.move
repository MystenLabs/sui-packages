module 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::faucets {
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

