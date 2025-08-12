module 0x448782ee798f673de81aa29a71cdb9cf516f2ecc3c85e6cd117fc49efd60eae1::auaus {
    struct AUAUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUAUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUAUS>(arg0, 6, b"AUAUS", b"eewew", b"asasaddd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieoitdsf2zjqliv2h4d6adecj4tyjmuyhotqwxeikqyhfvc6s5ole")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUAUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AUAUS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

