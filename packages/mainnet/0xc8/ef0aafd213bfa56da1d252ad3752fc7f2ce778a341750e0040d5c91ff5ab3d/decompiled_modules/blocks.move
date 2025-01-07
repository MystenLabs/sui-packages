module 0xc8ef0aafd213bfa56da1d252ad3752fc7f2ce778a341750e0040d5c91ff5ab3d::blocks {
    struct BLOCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOCKS>(arg0, 6, b"BLOCKS", b"THE BLOCKS", b"The first toys on Turbos.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956489784.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLOCKS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOCKS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

