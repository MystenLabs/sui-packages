module 0x797fb49b6aad58c874351e161c27b34ee9de918966685f45c1a059b87e549593::bshark {
    struct BSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSHARK>(arg0, 6, b"BSHARK", b"BullShark", b"Famous for their speed, strength, and determination Bullsharks thrive in SUI blockchain ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_5943059647952962416_c_5c165ef9b4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

