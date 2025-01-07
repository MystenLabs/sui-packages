module 0x845654a16e1c8776bd10315fac64baee88630af23421ecfda572e1defd8543eb::ghoul {
    struct GHOUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHOUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHOUL>(arg0, 6, b"GHOUL", b"Ghoul", b"tokyo ghoul", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ken_Kaneki_bb4d0bfb4f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHOUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GHOUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

