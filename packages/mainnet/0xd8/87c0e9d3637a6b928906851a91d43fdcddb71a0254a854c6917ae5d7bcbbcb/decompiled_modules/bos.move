module 0xd887c0e9d3637a6b928906851a91d43fdcddb71a0254a854c6917ae5d7bcbbcb::bos {
    struct BOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BOS>(arg0, 6, b"BOS", b"Boss", b"The boss that will put in place every tokenomics that is its wrong path", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/B_P_522d4b856f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

