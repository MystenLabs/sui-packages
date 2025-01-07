module 0x9e2a901abb49b31af2b3c4ac07f8aef664fd501af37b2462e36dd82c086f1be3::afgafdg {
    struct AFGAFDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFGAFDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFGAFDG>(arg0, 6, b"afgafdg", b"haetasdg", b"afgadg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcaWyTUpHqPAcgWum4mSELpMRmmEYsYvWe2wmdvknDFCk")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AFGAFDG>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFGAFDG>>(v2, @0x33b267e87bb2a27a2d0e38671052ba1f57d41912dca265709e68e12e00986591);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AFGAFDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

