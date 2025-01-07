module 0xe29fb6c72d168815ea3f06120ce49f7bf09723fa6fb19bf9405139360eb7b4a3::shikoneko {
    struct SHIKONEKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIKONEKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIKONEKO>(arg0, 6, b"SHIKONEKO", b"SHIKO", b"NEKO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_03_01_47_15_432680ccd1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIKONEKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIKONEKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

