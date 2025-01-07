module 0xe9e992ef3e0c26bacc2aa8b5980e2544c32b6d5fe7c10e7721d8327a87a0113b::nukedoge {
    struct NUKEDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUKEDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUKEDOGE>(arg0, 9, b"NUKEDOGE", b"NUKEDOGE", b"This is a nuclear dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://crimson-magic-armadillo-10.mypinata.cloud/ipfs/bafkreieuxpsftozjusr6uqx4l7k6bz6rh73et6sd6czswuqmxfjj3fklay")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NUKEDOGE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUKEDOGE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUKEDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

