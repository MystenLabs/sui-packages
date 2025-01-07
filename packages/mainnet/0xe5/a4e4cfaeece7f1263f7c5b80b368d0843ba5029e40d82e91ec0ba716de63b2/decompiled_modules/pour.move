module 0xe5a4e4cfaeece7f1263f7c5b80b368d0843ba5029e40d82e91ec0ba716de63b2::pour {
    struct POUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: POUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POUR>(arg0, 6, b"POUR", b"Pour On Sui", b"Thirsty bro? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_10_at_6_02_17_PM_832deed0f8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

