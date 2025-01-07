module 0xdc3861d40fdc1797d6cbda26e337c848d1afb2f269bfb4334adcfd9255f0b049::arumi {
    struct ARUMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARUMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARUMI>(arg0, 6, b"ARUMI", b"ARUMI SATORO", x"5348555420555020414e4420425559204d45210a5348555420555020414e4420425559204d45210a5348555420555020414e4420425559204d45210a5348555420555020414e4420425559204d45210a5348555420555020414e4420425559204d45210a5348555420555020414e4420425559204d4521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/giphy_1_d45342120f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARUMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARUMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

