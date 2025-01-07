module 0xba7bd82e914e5cfd36e5fc38312399c29f74276bb2e78c24854c3b4bd73c9dc2::nl {
    struct NL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NL>(arg0, 6, b"NL", b"NeuroLink.io", b"NeuroLink.io is a revolutionary project combining advanced neurotechnology and blockchain. We are creating a decentralized ecosystem where your thoughts and ideas can be visualized, securing your intellectual potential. Invest in NeuroLink.io tokens ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734366244078.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

