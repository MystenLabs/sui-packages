module 0xaa194a698942c3d910562a24e3af04b2b7f7c593e19ea116f99a4e84e33d0a85::bwoo {
    struct BWOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWOO>(arg0, 9, b"BWOO", b"Sui Bwoo", b"are you feeling bwoo?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmaJV9HXiDAEg96KU9d6VZdcrZ7fPBXbCqCk7McqbjxGpp?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BWOO>(&mut v2, 999000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWOO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BWOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

