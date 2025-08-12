module 0x62525871ad5b7885efff77a5880bd5cfbcb7f881648fbafb6aa5ab17ddcb9388::asss {
    struct ASSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASSS>(arg0, 6, b"ASSS", b"adsas", b"fafafsafsa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieoitdsf2zjqliv2h4d6adecj4tyjmuyhotqwxeikqyhfvc6s5ole")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASSS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

