module 0x62950809905a3b70c1e528824d44497e2a30be57b64c93fae3966ddcc4a4dcce::frats {
    struct FRATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRATS>(arg0, 6, b"Frats", b"Effin Rats", b"Meet the Effinrats, a quirky crew of adventurous rodents on a mission to explore the wild and wacky world of decentralized finance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1911_ae3d0c5b7f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

