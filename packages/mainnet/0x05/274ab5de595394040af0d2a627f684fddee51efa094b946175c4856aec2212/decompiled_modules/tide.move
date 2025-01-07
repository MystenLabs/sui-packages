module 0x5274ab5de595394040af0d2a627f684fddee51efa094b946175c4856aec2212::tide {
    struct TIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIDE>(arg0, 6, b"Tide", b"SuiTide", b"If you know, you know", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_Create_a_vibrant_and_playful_digital_art_piec_3_4e81c83f1b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

