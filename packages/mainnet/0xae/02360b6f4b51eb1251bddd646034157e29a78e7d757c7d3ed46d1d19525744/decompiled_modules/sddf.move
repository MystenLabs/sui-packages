module 0xae02360b6f4b51eb1251bddd646034157e29a78e7d757c7d3ed46d1d19525744::sddf {
    struct SDDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDDF>(arg0, 9, b"SDDF", b"dhfkd", b"fgjsklfgjkdfjgk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SDDF>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDDF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

