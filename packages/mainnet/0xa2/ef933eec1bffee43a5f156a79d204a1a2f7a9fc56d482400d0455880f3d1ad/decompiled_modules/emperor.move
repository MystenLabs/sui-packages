module 0xa2ef933eec1bffee43a5f156a79d204a1a2f7a9fc56d482400d0455880f3d1ad::emperor {
    struct EMPEROR has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMPEROR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMPEROR>(arg0, 6, b"EMPEROR", b"KABOSUI THE EMPEROR", b"The most powerful empawroar to ever set foot in SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_04_16_57_05_f216bba348.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMPEROR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EMPEROR>>(v1);
    }

    // decompiled from Move bytecode v6
}

