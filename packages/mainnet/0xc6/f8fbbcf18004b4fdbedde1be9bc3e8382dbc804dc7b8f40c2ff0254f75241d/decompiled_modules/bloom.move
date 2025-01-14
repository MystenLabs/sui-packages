module 0xc6f8fbbcf18004b4fdbedde1be9bc3e8382dbc804dc7b8f40c2ff0254f75241d::bloom {
    struct BLOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOOM>(arg0, 6, b"BLOOM", b"Neural Bloom", x"45766f6c76696e672068756d616e697479207468726f7567682074686520667573696f6e206f6620414920616e6420696d6167696e6174696f6e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736821106034.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLOOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

