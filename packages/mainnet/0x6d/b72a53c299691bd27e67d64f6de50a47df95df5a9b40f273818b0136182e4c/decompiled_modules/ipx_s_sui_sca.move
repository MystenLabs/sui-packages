module 0x6db72a53c299691bd27e67d64f6de50a47df95df5a9b40f273818b0136182e4c::ipx_s_sui_sca {
    struct IPX_S_SUI_SCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IPX_S_SUI_SCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IPX_S_SUI_SCA>(arg0, 9, b"ipx-s-sui-sca", b"iSUI/SCA", b"CLAMM Interest Protocol LpCoin for SUI/SCA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.interestprotocol.com/logo.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IPX_S_SUI_SCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IPX_S_SUI_SCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

