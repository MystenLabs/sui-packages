module 0x90a37a3cb55862a2e12f47ae3fa833a38195bfa4b00991682c7391a9e92b52d2::fomius {
    struct FOMIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOMIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOMIUS>(arg0, 6, b"FOMIUS", b"FOMIUS the God of Regret", b"Never too late for FOMIUS. Buy now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Chat_GPT_Image_Apr_24_2025_09_58_55_PM_d7a2800523.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMIUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOMIUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

