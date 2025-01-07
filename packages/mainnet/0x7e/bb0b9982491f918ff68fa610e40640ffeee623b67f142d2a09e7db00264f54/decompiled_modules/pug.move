module 0x7ebb0b9982491f918ff68fa610e40640ffeee623b67f142d2a09e7db00264f54::pug {
    struct PUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUG>(arg0, 9, b"PUG", b"Pump Up God", b"Pug is surfing on his jetski while dolphins are jumping around him and whales are swimming.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRLpH187Kn7ZHGxj2p3bYep22yjNavxfq3zQ49k3n8akn")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

