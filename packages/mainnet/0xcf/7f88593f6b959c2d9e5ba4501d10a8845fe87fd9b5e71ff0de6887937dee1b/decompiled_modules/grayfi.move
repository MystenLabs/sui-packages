module 0xcf7f88593f6b959c2d9e5ba4501d10a8845fe87fd9b5e71ff0de6887937dee1b::grayfi {
    struct GRAYFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRAYFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRAYFI>(arg0, 6, b"GRAYFI", b"GrayfiDog Sui", b"$GRAYFI - the cutest but most vicious Dog on the SUI blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001310_1c403f0ddc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRAYFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRAYFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

