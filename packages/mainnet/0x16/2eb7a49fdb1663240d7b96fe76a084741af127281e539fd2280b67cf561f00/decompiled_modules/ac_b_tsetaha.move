module 0x162eb7a49fdb1663240d7b96fe76a084741af127281e539fd2280b67cf561f00::ac_b_tsetaha {
    struct AC_B_TSETAHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AC_B_TSETAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AC_B_TSETAHA>(arg0, 6, b"ac_b_tsetaha", b"TicketFortestesgtasdgad", b"Pre sale ticket of bonding curve pool for the following memecoin: testesgtasdgad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcaWyTUpHqPAcgWum4mSELpMRmmEYsYvWe2wmdvknDFCk")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AC_B_TSETAHA>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AC_B_TSETAHA>>(v2, @0x33b267e87bb2a27a2d0e38671052ba1f57d41912dca265709e68e12e00986591);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AC_B_TSETAHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

