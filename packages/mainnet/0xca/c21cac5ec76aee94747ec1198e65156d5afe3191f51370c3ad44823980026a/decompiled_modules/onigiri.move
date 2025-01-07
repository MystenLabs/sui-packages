module 0xcac21cac5ec76aee94747ec1198e65156d5afe3191f51370c3ad44823980026a::onigiri {
    struct ONIGIRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONIGIRI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONIGIRI>(arg0, 6, b"ONIGIRI", b"ONIGIRI CAT", b"ONIGIRI is Neiro & Doge brother", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6860_3e639794a2.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONIGIRI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONIGIRI>>(v1);
    }

    // decompiled from Move bytecode v6
}

