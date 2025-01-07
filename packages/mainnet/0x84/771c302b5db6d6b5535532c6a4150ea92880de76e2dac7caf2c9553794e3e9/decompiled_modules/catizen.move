module 0x84771c302b5db6d6b5535532c6a4150ea92880de76e2dac7caf2c9553794e3e9::catizen {
    struct CATIZEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATIZEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATIZEN>(arg0, 6, b"CATIZEN", b"Cats Netizens", b"Heal the world, care for the cats", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241007_220013_093_3649884b61.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATIZEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATIZEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

