module 0xbfc7a302ac957d352e063df8d14beb3ad649c2f84e14dcd3604ce1505da79cd2::suisora {
    struct SUISORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISORA>(arg0, 6, b"SUISORA", b"Sui Sora", b"Sora AiOn Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibyvurdkukvrh67ldmibvopwat5xykmzfqkv5fff4x5qqrckrdfme")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISORA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUISORA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

