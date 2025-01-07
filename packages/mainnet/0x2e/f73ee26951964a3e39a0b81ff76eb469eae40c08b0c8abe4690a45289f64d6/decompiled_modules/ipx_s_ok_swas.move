module 0x2ef73ee26951964a3e39a0b81ff76eb469eae40c08b0c8abe4690a45289f64d6::ipx_s_ok_swas {
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

