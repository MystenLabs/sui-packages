module 0xb0abfffb6aebed0459db8b400a556ae74cf78229b27cde4c6a1205925ea1846d::suisora {
    struct SUISORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISORA>(arg0, 6, b"SUISORA", b"Sora Ai Sui", b"Sora Ai on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibyvurdkukvrh67ldmibvopwat5xykmzfqkv5fff4x5qqrckrdfme")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISORA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUISORA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

