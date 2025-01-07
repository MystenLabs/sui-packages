module 0x5809662bd0845e406e99266a3c86ece8a1f7b9d2570945659d964a88bba9a99f::dogimus {
    struct DOGIMUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGIMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGIMUS>(arg0, 6, b"DOGIMUS", b"TeslaDogimus", b"https://x.com/MarioNawfal/status/1844991610842390906", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmapxobj8_Hza_Y_Kn_Gxq7_K2esm_Np9r6_Txs9kqn_Sfu_Q_Mf_Qbq_K_ef4c0a1132.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGIMUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGIMUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

