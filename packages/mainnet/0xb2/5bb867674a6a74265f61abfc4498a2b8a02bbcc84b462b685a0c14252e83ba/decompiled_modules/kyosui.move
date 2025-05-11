module 0xb25bb867674a6a74265f61abfc4498a2b8a02bbcc84b462b685a0c14252e83ba::kyosui {
    struct KYOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KYOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KYOSUI>(arg0, 6, b"KYOSUI", b"KYOGRE on SUI", b"The ruler of Sui ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeia6ewh3qdbb52oejbf4vxgxxwwsccrurpjkybpggi365jzalprjxy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KYOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KYOSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

