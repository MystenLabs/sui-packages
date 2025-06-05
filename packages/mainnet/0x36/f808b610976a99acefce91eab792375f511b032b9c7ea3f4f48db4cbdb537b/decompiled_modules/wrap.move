module 0x36f808b610976a99acefce91eab792375f511b032b9c7ea3f4f48db4cbdb537b::wrap {
    struct Wrap<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    public fun wrap<T0>(arg0: 0x36f808b610976a99acefce91eab792375f511b032b9c7ea3f4f48db4cbdb537b::shared::Shared<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0x36f808b610976a99acefce91eab792375f511b032b9c7ea3f4f48db4cbdb537b::shared::destroy<T0>(arg0);
        let v2 = Wrap<T0>{
            id      : 0x2::object::new(arg1),
            balance : v1,
        };
        0x2::transfer::share_object<Wrap<T0>>(v2);
    }

    // decompiled from Move bytecode v6
}

