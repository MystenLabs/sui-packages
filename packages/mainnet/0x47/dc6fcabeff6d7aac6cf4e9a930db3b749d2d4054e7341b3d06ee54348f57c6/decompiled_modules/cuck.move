module 0x47dc6fcabeff6d7aac6cf4e9a930db3b749d2d4054e7341b3d06ee54348f57c6::cuck {
    struct CUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUCK>(arg0, 6, b"Cuck", b"BLUE ANON", b"Liberal cope, new world hope", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731473099619.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

