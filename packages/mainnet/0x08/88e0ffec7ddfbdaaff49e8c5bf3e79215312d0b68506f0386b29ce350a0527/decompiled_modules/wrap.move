module 0x888e0ffec7ddfbdaaff49e8c5bf3e79215312d0b68506f0386b29ce350a0527::wrap {
    struct Wrap<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    public fun wrap<T0>(arg0: 0x888e0ffec7ddfbdaaff49e8c5bf3e79215312d0b68506f0386b29ce350a0527::shared::Shared<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0x888e0ffec7ddfbdaaff49e8c5bf3e79215312d0b68506f0386b29ce350a0527::shared::destroy<T0>(arg0);
        let v2 = Wrap<T0>{
            id      : 0x2::object::new(arg1),
            balance : v1,
        };
        0x2::transfer::share_object<Wrap<T0>>(v2);
    }

    // decompiled from Move bytecode v6
}

