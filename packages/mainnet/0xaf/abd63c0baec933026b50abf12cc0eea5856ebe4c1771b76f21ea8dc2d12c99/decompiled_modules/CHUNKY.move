module 0xafabd63c0baec933026b50abf12cc0eea5856ebe4c1771b76f21ea8dc2d12c99::CHUNKY {
    struct CHUNKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUNKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUNKY>(arg0, 9, b"CHUNKY", b"KitKat $CHUNKY on SUI", b"KitKat $CHUNKY on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1746490675481210880/A12ZQSuA_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHUNKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUNKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHUNKY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CHUNKY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

