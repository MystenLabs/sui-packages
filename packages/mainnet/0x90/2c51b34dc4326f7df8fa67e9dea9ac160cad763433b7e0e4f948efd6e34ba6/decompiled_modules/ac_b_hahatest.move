module 0x902c51b34dc4326f7df8fa67e9dea9ac160cad763433b7e0e4f948efd6e34ba6::ac_b_hahatest {
    struct AC_B_HAHATEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: AC_B_HAHATEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AC_B_HAHATEST>(arg0, 6, b"ac_b_hahatest", b"TicketForfesaltest", b"Pre sale ticket of bonding curve pool for the following memecoin: fesaltest", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcaWyTUpHqPAcgWum4mSELpMRmmEYsYvWe2wmdvknDFCk")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AC_B_HAHATEST>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AC_B_HAHATEST>>(v2, @0x33b267e87bb2a27a2d0e38671052ba1f57d41912dca265709e68e12e00986591);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AC_B_HAHATEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

