module 0xee937a8c136c3df1def04b6ba1f3a981f04968623a946650d64126b0556abcd5::bluerug {
    struct BLUERUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUERUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUERUG>(arg0, 6, b"BlueRug", b"50/50", b"50%chance rug/50% chance moon you decide ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241030_154322_7e7cb1f36a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUERUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUERUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

