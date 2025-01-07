module 0xb663a2e1bf64d4581804a5af2094e4da4b2904f73f98cec32dda6fac0d689ece::sui_penguin {
    struct SUI_PENGUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_PENGUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_PENGUIN>(arg0, 9, b"SUI PENGUIN", x"f09f90a75375692050656e6775696e", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_PENGUIN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_PENGUIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_PENGUIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

