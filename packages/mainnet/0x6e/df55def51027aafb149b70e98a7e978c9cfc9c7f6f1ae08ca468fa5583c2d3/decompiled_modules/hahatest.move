module 0x6edf55def51027aafb149b70e98a7e978c9cfc9c7f6f1ae08ca468fa5583c2d3::hahatest {
    struct HAHATEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAHATEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAHATEST>(arg0, 6, b"hahatest", b"fesaltest", b"hahaha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcaWyTUpHqPAcgWum4mSELpMRmmEYsYvWe2wmdvknDFCk")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HAHATEST>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAHATEST>>(v2, @0x33b267e87bb2a27a2d0e38671052ba1f57d41912dca265709e68e12e00986591);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAHATEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

