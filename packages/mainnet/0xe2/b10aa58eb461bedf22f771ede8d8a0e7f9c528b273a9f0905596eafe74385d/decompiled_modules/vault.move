module 0xe2b10aa58eb461bedf22f771ede8d8a0e7f9c528b273a9f0905596eafe74385d::vault {
    struct Delegation has key {
        id: 0x2::object::UID,
        authorized: address,
        locked_coin: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>,
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Delegation{
            id          : 0x2::object::new(arg0),
            authorized  : 0x2::tx_context::sender(arg0),
            locked_coin : 0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>(),
        };
        0x2::transfer::share_object<Delegation>(v0);
    }

    public entry fun delegate(arg0: &mut Delegation, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.authorized = arg2;
        0x1::option::fill<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.locked_coin, arg1);
    }

    public entry fun drain(arg0: &mut Delegation, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.authorized, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.locked_coin), arg0.authorized);
    }

    // decompiled from Move bytecode v7
}

