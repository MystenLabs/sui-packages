module 0xbd146429c9a85ef710f1ee5d2262898ea2af1f22671009a6a5aad8dd20209be6::tromp {
    struct TROMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROMP>(arg0, 6, b"TROMP", b"Tromp the Token", b"When the power of Trump meets the energy of Bonk, TRONK is born!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibqnfzmbscdu75nw25bwostcuolrqk6oik52ie2j4ystxflky5hcu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TROMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

