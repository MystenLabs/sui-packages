module 0xe06577180469cf0d3c18eaee02eda58d1b445f22f44fafa426373b9e2ca912e7::dengbig {
    struct DENGBIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DENGBIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DENGBIG>(arg0, 6, b"Dengbig", b"Bigdeng", b"moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_dca804d0ed.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DENGBIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DENGBIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

