module 0x37ac389babda7abe4cf94c39b5516bad59d01b607174104bf14b59b45773e696::dika {
    struct DIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIKA>(arg0, 6, b"DIKA", b"DARKPIKA", b"darkk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid7nujmqo4p5ugzikfuklgl3rxkul6pw6zagxr7s6gdbcw64hs5yi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DIKA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

