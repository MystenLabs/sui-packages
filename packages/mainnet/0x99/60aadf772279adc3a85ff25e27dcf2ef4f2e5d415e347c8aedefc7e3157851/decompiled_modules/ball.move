module 0x9960aadf772279adc3a85ff25e27dcf2ef4f2e5d415e347c8aedefc7e3157851::ball {
    struct BALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALL>(arg0, 6, b"BALL", b"Sui Ball", b"Not a pokeball, but a SUI ball! Meet one of SUINS's first artworks!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fjkhgk_e86b92f76e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALL>>(v1);
    }

    // decompiled from Move bytecode v6
}

