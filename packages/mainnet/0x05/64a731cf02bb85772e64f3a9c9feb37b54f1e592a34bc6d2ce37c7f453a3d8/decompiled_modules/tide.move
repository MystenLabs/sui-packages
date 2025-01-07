module 0x564a731cf02bb85772e64f3a9c9feb37b54f1e592a34bc6d2ce37c7f453a3d8::tide {
    struct TIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIDE>(arg0, 6, b"Tide", b"SuiTide", b"30% will be burned. So, if you know, you know.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_Create_a_vibrant_and_playful_digital_art_piec_3_eec7d073d0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

