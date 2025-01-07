module 0x8f190871f2d4282bf00ba3eabaf9cce3961263ce8aab99df11d47bd2206db0ba::nami {
    struct NAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAMI>(arg0, 9, b"NAMI", x"f09f8c8a5375696e616d69", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NAMI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAMI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

