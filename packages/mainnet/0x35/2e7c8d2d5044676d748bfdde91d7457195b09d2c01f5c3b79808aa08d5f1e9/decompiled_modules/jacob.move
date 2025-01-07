module 0x352e7c8d2d5044676d748bfdde91d7457195b09d2c01f5c3b79808aa08d5f1e9::jacob {
    struct JACOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: JACOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JACOB>(arg0, 6, b"JACOB", b"Sui Jacob", b"Projacobly nothing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5534_394ecbe68f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JACOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JACOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

