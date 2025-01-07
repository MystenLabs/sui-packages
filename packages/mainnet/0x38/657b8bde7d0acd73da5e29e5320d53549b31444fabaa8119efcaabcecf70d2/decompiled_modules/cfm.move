module 0x38657b8bde7d0acd73da5e29e5320d53549b31444fabaa8119efcaabcecf70d2::cfm {
    struct Cap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        hd: address,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Cap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<Cap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun nc(arg0: &Cap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id : 0x2::object::new(arg1),
            hd : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun shd(arg0: &Cap, arg1: &mut Config, arg2: address) {
        if (arg1.hd != @0x0) {
            arg1.hd = arg2;
        };
    }

    public fun tfb<T0>(arg0: &Config, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg1, arg2), arg0.hd);
        };
    }

    // decompiled from Move bytecode v6
}

