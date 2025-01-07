module 0x7f466c277adc5703920dda6fbe4514120b558b45b09b573fe3a4b47f5f1804de::rushi {
    struct RUSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUSHI>(arg0, 6, b"RUSHI", b"rushi", b"the original move creator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rushi_Move_Image_80a7ba572c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

