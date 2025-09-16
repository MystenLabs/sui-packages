module 0x1185768eb29dc41fd6b143b12486186d01b02695e583ca82ac6581f72fea02f9::quai {
    struct QUAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUAI>(arg0, 9, b"QUAI", b"Quai Network", b"Accelerating humanity with the world's first energy based monetary system.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/Qmb9iSuzPESXB9JestT8koeWCnPPiBaKG4xDCA5Qp8m6BH")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<QUAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUAI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

