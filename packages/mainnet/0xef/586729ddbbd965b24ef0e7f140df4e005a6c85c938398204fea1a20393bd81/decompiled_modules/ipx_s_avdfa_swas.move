module 0xef586729ddbbd965b24ef0e7f140df4e005a6c85c938398204fea1a20393bd81::ipx_s_avdfa_swas {
    struct IPX_S_AVDFA_SWAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IPX_S_AVDFA_SWAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IPX_S_AVDFA_SWAS>(arg0, 9, b"ipx-s-avdfa-swas", b"iAVDFA/SWAS", b"CLAMM Interest Protocol LpCoin for AVDFA/SWAS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.interestprotocol.com/logo.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IPX_S_AVDFA_SWAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IPX_S_AVDFA_SWAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

