module 0x64c68a1c52960e617790d9693da1ac5f4b6b72a5a7da0b9af2d84e906cf2d46e::digbick {
    struct DIGBICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIGBICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIGBICK>(arg0, 6, b"DIGBICK", b"Big Dick", b"i've got a dig bick", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_3_45b42649b1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIGBICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIGBICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

