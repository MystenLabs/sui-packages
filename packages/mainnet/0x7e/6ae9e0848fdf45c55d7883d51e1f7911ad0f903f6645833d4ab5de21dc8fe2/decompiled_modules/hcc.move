module 0x7e6ae9e0848fdf45c55d7883d51e1f7911ad0f903f6645833d4ab5de21dc8fe2::hcc {
    struct HCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: HCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HCC>(arg0, 9, b"HCC", b"Hydra Coin", b"Hail Hydra", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HCC>(&mut v2, 5555555555000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HCC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HCC>>(v1);
    }

    // decompiled from Move bytecode v6
}

