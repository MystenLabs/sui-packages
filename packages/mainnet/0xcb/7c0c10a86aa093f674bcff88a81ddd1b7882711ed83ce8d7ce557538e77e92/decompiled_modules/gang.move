module 0xcb7c0c10a86aa093f674bcff88a81ddd1b7882711ed83ce8d7ce557538e77e92::gang {
    struct GANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GANG>(arg0, 6, b"GANG", b"ggang", b"we are gang", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731225769026.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GANG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GANG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

