module 0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::supply {
    struct Monopoly has drop {
        dummy_field: bool,
    }

    struct StoredSupply<phantom T0> has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<T0>,
    }

    public fun new_supply(arg0: &0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::monopoly::AdminCap) : 0x2::balance::Supply<Monopoly> {
        let v0 = Monopoly{dummy_field: false};
        0x2::balance::create_supply<Monopoly>(v0)
    }

    public fun store_supply<T0>(arg0: 0x2::balance::Supply<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = StoredSupply<T0>{
            id     : 0x2::object::new(arg2),
            supply : arg0,
        };
        0x2::transfer::transfer<StoredSupply<T0>>(v0, arg1);
    }

    public fun take_supply<T0>(arg0: StoredSupply<T0>) : 0x2::balance::Supply<T0> {
        let StoredSupply {
            id     : v0,
            supply : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    // decompiled from Move bytecode v6
}

