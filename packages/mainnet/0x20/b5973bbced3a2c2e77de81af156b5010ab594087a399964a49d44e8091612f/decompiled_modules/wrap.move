module 0x20b5973bbced3a2c2e77de81af156b5010ab594087a399964a49d44e8091612f::wrap {
    struct Wrap<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    public fun wrap<T0>(arg0: 0x20b5973bbced3a2c2e77de81af156b5010ab594087a399964a49d44e8091612f::shared::Shared<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0x20b5973bbced3a2c2e77de81af156b5010ab594087a399964a49d44e8091612f::shared::destroy<T0>(arg0);
        let v2 = Wrap<T0>{
            id      : 0x2::object::new(arg1),
            balance : v1,
        };
        0x2::transfer::share_object<Wrap<T0>>(v2);
    }

    // decompiled from Move bytecode v6
}

