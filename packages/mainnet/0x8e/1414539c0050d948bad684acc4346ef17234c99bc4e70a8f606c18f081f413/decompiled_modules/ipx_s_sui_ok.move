module 0x8e1414539c0050d948bad684acc4346ef17234c99bc4e70a8f606c18f081f413::ipx_s_sui_ok {
    struct IPX_S_SUI_OK has drop {
        dummy_field: bool,
    }

    fun init(arg0: IPX_S_SUI_OK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IPX_S_SUI_OK>(arg0, 9, b"ipx-s-sui-ok", b"iSUI/OK", b"CLAMM Interest Protocol LpCoin for SUI/OK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.interestprotocol.com/logo.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IPX_S_SUI_OK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IPX_S_SUI_OK>>(v1);
    }

    // decompiled from Move bytecode v6
}

