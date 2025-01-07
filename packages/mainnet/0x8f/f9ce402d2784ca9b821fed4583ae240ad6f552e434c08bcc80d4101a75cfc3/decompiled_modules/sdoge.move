module 0x8ff9ce402d2784ca9b821fed4583ae240ad6f552e434c08bcc80d4101a75cfc3::sdoge {
    struct SDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOGE>(arg0, 6, b"Sdoge", b"suidoge", b"Doge in Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/841727625797_pic_ea298c6360.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

