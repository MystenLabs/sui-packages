module 0x7341cf8c32b265bb39d930ee438aeeb90da2ae44e40693af3a041565fd7f8975::suideeeeeeeng {
    struct SUIDEEEEEEENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDEEEEEEENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDEEEEEEENG>(arg0, 6, b"SUIDEEEEEeeNG", b"Sui Deng", b"Just Moodeng culture on Sui network , fanart of SUIDEEEEEeeNG another Animal's from Khao kheaw Zoo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/UA_Fh_M_Hg_400x400_9f9b27a2b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDEEEEEEENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDEEEEEEENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

