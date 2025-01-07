module 0xeac91a234c537f679a9c7c2324c932e386052cfb05bda3719b3f97893e9aab47::ipx_s_sui_zakecoin {
    struct IPX_S_SUI_ZAKECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: IPX_S_SUI_ZAKECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IPX_S_SUI_ZAKECOIN>(arg0, 9, b"ipx-s-sui-zakecoin", b"iSUI/ZAKECOIN", b"CLAMM Interest Protocol LpCoin for SUI/ZAKECOIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.interestprotocol.com/logo.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IPX_S_SUI_ZAKECOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IPX_S_SUI_ZAKECOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

