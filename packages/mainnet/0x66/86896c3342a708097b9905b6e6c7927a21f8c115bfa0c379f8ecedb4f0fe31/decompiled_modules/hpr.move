module 0x6686896c3342a708097b9905b6e6c7927a21f8c115bfa0c379f8ecedb4f0fe31::hpr {
    struct HPR has drop {
        dummy_field: bool,
    }

    public entry fun cs<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 11);
    }

    fun init(arg0: HPR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<HPR>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

