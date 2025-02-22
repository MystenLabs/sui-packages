module 0xb1cfd3a3d0cb10e28fe659d45b50c62dc65a30af4b4131a1f392ecbb62b24dd1::life {
    struct LIFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIFE>(arg0, 9, b"LIFE", b"Most Valuable Currency", b"Most Valuable Currency On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUMp8kWMiNPQUUQ6Pf66RnVjD2VM1uEMqsxzaTnDgvV1R")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LIFE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIFE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIFE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

