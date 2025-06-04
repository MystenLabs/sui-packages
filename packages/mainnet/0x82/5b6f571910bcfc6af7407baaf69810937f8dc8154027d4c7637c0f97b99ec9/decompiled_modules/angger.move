module 0x825b6f571910bcfc6af7407baaf69810937f8dc8154027d4c7637c0f97b99ec9::angger {
    struct ANGGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGGER>(arg0, 6, b"ANGGER", b"Angger on Sui", b"Jajaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiadqk6o5q2injc6nxq2o7xvwbxgtu7bb5ptkhbaiakzcwlvmeybfa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ANGGER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

