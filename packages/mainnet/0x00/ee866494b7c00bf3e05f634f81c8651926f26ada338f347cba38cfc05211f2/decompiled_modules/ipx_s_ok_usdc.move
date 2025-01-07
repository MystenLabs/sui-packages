module 0xee866494b7c00bf3e05f634f81c8651926f26ada338f347cba38cfc05211f2::ipx_s_ok_usdc {
    struct IPX_S_OK_USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: IPX_S_OK_USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IPX_S_OK_USDC>(arg0, 9, b"ipx-s-ok-usdc", b"iOK/USDC", b"CLAMM Interest Protocol LpCoin for OK/USDC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.interestprotocol.com/logo.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IPX_S_OK_USDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IPX_S_OK_USDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

