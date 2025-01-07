module 0x11d541c9d98a5786a5989ce471865f1a21dd80ae98077eb4ea9bde7e4273ca90::dggdd {
    struct DGGDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGGDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGGDD>(arg0, 6, b"DGGDD", b"Doggy Dog", b"Doggy Dog is another version Doge in the world of Matt Furie and Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_09_21_29_c51b290fa6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGGDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DGGDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

