module 0x159c6334fa40356cf54f45a2e17b2c7a4c403672b74cb8f7a7313ef93f52609::squaza {
    struct SQUAZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUAZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUAZA>(arg0, 6, b"SQUAZA", b"SUIQUAZA", b"Coming to take over the SUI network!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidjrmxd3xsl776vybpq7forwrdenmduacj66kk7ctc2bhl5zitym4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUAZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SQUAZA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

