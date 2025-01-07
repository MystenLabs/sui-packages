module 0x6535a95fc377f6d866e25104b5b4e328bf64bbba233b90c054cae9aa8c85ae2d::ipx_s_sui_usdc {
    struct IPX_S_SUI_USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: IPX_S_SUI_USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IPX_S_SUI_USDC>(arg0, 9, b"ipx-s-sui-usdc", b"iSUI/USDC", b"CLAMM Interest Protocol LpCoin for SUI/USDC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.interestprotocol.com/logo.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IPX_S_SUI_USDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IPX_S_SUI_USDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

