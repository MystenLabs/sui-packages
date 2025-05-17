module 0x78bf49dd04ef50e818189a6c1079c9fdd0202744b0ecd09f2ceef7435ce4835::gen {
    struct GEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEN>(arg0, 6, b"GEN", b"GENRY", b"VKEVKEKRKVRV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihuofct5ke72ksatulpem4sg6shbiwpkye5svtgxg7ux6pppkbde4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

