module 0x888e0ffec7ddfbdaaff49e8c5bf3e79215312d0b68506f0386b29ce350a0527::shared {
    struct Shared<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    public fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Shared<T0>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Shared<T0>>(v0);
    }

    public(friend) fun destroy<T0>(arg0: Shared<T0>) : (0x2::object::ID, 0x2::balance::Balance<T0>) {
        let Shared {
            id      : v0,
            balance : v1,
        } = arg0;
        let v2 = v0;
        0x2::object::delete(v2);
        (0x2::object::uid_to_inner(&v2), v1)
    }

    // decompiled from Move bytecode v6
}

