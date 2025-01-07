module 0x6b44c984d811dc141db245bdeedd305af589d0f3bdeacbdc07257dc2c654888a::boo {
    struct BOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOO>(arg0, 6, b"BOO", b"Sheiboo", b"The Only Boo You Need!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_09_19_at_3_08_50_PM_7f4fdbf291.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

