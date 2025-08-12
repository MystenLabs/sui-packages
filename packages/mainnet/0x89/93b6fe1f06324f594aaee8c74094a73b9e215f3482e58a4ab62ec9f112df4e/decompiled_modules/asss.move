module 0x8993b6fe1f06324f594aaee8c74094a73b9e215f3482e58a4ab62ec9f112df4e::asss {
    struct ASSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASSS>(arg0, 6, b"ASSS", b"qsff", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieoitdsf2zjqliv2h4d6adecj4tyjmuyhotqwxeikqyhfvc6s5ole")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASSS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

