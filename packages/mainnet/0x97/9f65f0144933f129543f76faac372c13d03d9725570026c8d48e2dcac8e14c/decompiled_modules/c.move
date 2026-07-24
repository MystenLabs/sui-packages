module 0x979f65f0144933f129543f76faac372c13d03d9725570026c8d48e2dcac8e14c::c {
    struct X<phantom T0> has key {
        id: 0x2::object::UID,
        s: 0x2::balance::Supply<T0>,
    }

    public entry fun d<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = X<T0>{
            id : 0x2::object::new(arg1),
            s  : 0x2::coin::treasury_into_supply<T0>(arg0),
        };
        0x2::transfer::freeze_object<X<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

