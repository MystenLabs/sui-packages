module 0xfc4d9fd8dc73aac89116e9e9563e45483cee42bab0d180182d310ab5d25e4ea7::sfx {
    struct SFX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFX>(arg0, 6, b"SFX", b"Suuflex", b"not just another streaming platfrom. we make moves we make waves", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0955_321e944c89.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFX>>(v1);
    }

    // decompiled from Move bytecode v6
}

