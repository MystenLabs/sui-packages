module 0x963c07429f902d56b221ffbf5d7ee1d9a12bef6196f76d7b453781b17b8906d::ipx_s_ok_swas {
    struct IPX_S_OK_SWAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IPX_S_OK_SWAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IPX_S_OK_SWAS>(arg0, 9, b"ipx-s-ok-swas", b"iOK/SWAS", b"CLAMM Interest Protocol LpCoin for OK/SWAS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.interestprotocol.com/logo.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IPX_S_OK_SWAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IPX_S_OK_SWAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

