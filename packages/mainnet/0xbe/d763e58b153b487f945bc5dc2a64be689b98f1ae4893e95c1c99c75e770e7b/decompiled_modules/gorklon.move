module 0xbed763e58b153b487f945bc5dc2a64be689b98f1ae4893e95c1c99c75e770e7b::gorklon {
    struct GORKLON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GORKLON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GORKLON>(arg0, 6, b"Gorklon", b"gorklon rust", x"47726f6b2d580a476f726b6c6f6e2d576f726c640a537569203e20536f6c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1746390165242.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GORKLON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GORKLON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

