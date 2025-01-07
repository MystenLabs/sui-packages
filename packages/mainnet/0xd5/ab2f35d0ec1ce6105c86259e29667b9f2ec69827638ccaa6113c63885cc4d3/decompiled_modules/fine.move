module 0xd5ab2f35d0ec1ce6105c86259e29667b9f2ec69827638ccaa6113c63885cc4d3::fine {
    struct FINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINE>(arg0, 6, b"FINE", b"ThisIsFine", x"4e6f2042530a4a7573742050757265204d656d6521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734835031867.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FINE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

