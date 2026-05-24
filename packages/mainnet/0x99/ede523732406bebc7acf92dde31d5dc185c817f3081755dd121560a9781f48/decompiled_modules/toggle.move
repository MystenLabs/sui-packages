module 0x99ede523732406bebc7acf92dde31d5dc185c817f3081755dd121560a9781f48::toggle {
    struct Toggle has key {
        id: 0x2::object::UID,
        should_abort: bool,
        flip_count: u64,
    }

    struct Trophy has store, key {
        id: 0x2::object::UID,
        number: u64,
    }

    public entry fun checkpoint_and_maybe_abort(arg0: &mut Toggle, arg1: &0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.flip_count = arg0.flip_count + 1;
        0x2::coin::value<0x2::sui::SUI>(arg1);
        0x2::tx_context::sender(arg2);
        assert!(!arg0.should_abort, 42);
    }

    public entry fun flip(arg0: &mut Toggle) {
        arg0.should_abort = !arg0.should_abort;
        arg0.flip_count = arg0.flip_count + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Toggle{
            id           : 0x2::object::new(arg0),
            should_abort : false,
            flip_count   : 0,
        };
        0x2::transfer::share_object<Toggle>(v0);
    }

    public entry fun mint_trophy(arg0: u64, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Trophy{
            id     : 0x2::object::new(arg2),
            number : arg0,
        };
        0x2::transfer::public_transfer<Trophy>(v0, arg1);
    }

    // decompiled from Move bytecode v7
}

