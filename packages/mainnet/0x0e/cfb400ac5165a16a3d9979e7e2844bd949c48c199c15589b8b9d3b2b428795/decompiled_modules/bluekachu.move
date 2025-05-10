module 0xecfb400ac5165a16a3d9979e7e2844bd949c48c199c15589b8b9d3b2b428795::bluekachu {
    struct BLUEKACHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEKACHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEKACHU>(arg0, 6, b"BLUEKACHU", b"BLUEKACHUSUI", b"Blukachu on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidivlxchtyscnnvzcoh652ioogmthxsjjx7xtuthhd3fasrwgynlm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEKACHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUEKACHU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

