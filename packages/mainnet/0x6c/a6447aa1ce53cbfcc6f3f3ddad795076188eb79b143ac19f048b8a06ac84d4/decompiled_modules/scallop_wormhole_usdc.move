module 0x6ca6447aa1ce53cbfcc6f3f3ddad795076188eb79b143ac19f048b8a06ac84d4::scallop_wormhole_usdc {
    struct SCALLOP_WORMHOLE_USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_WORMHOLE_USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_WORMHOLE_USDC>(arg0, 6, b"sWUSDC", b"sWUSDC", b"Scallop interest-bearing token for wormhole USDC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://mvzsegpfvgaxtb5e4cfpu26bq5r6dnf7qetzj7l77yvkymkvo5ra.arweave.net/ZXMiGeWpgXmHpOCK-mvBh2PhtL-BJ5T9f_4qrDFVd2I")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_WORMHOLE_USDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_WORMHOLE_USDC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

