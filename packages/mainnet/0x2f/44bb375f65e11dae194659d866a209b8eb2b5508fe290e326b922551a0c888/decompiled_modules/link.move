module 0x2f44bb375f65e11dae194659d866a209b8eb2b5508fe290e326b922551a0c888::link {
    struct LINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LINK>(arg0, 6, b"LINK", b"LinkOnchain", b"Chainlink (LINK) is a decentralized oracle network that enables smart contracts on blockchains to securely connect with real-world data, events, and payment systems.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/18ceec47-6d36-4cce-8755-d4e0c7a43d47.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LINK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LINK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

