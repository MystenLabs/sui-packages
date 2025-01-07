module 0xf023713b4521f4af3898c3df36ee9db05c43b9abbd6fb1cf4ef0187e09b6cf2b::templarsui {
    struct TEMPLARSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEMPLARSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEMPLARSUI>(arg0, 6, b"Templarsui", b"Order of the Ancients", b"May the father of understanding guide us to blue dex/raydium.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/templar_image_6dfcbad8ee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEMPLARSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEMPLARSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

