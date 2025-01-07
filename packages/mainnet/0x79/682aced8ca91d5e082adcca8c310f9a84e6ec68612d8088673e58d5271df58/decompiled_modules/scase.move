module 0x79682aced8ca91d5e082adcca8c310f9a84e6ec68612d8088673e58d5271df58::scase {
    struct SCASE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCASE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCASE>(arg0, 6, b"SCASE", b"suitcase", b"fill your suitcase with this", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_15_16_28_16_9266bee8e9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCASE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCASE>>(v1);
    }

    // decompiled from Move bytecode v6
}

