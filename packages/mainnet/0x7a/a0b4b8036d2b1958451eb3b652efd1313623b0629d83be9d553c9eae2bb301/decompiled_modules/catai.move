module 0x7aa0b4b8036d2b1958451eb3b652efd1313623b0629d83be9d553c9eae2bb301::catai {
    struct CATAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATAI>(arg0, 9, b"CATAI", b"Cat AI", b"programmed the purring", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXrjenDWtdMz9uwvu3FHARvbmp2qSdvCSwPNFZRBkJY7d")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CATAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

