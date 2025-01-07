module 0x863ec0a0c2fb8aa91f4e08861d9caae54c5506d1d9c448801e43b1fca71ea8f::beggplant {
    struct BEGGPLANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEGGPLANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEGGPLANT>(arg0, 6, b"Beggplant", b"Burn Eggplant", b"burn the eggplant! for the eggplant!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733145036371.gallery")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEGGPLANT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEGGPLANT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

