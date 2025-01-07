module 0xe9e7d2e07fac23cea2b706da0734fc825849b844bfb715275a1e9091b7637b06::bio {
    struct BIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIO>(arg0, 6, b"BIO", b"BIO Protocol", b"A new home for Decentralized Biotech. Co-own the medicines of the future, BIO connects DeSci's early experimental hubs, using DeFi dynamics & real- world IP to grow an ecosystem of living, adaptive scientific networks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731781355559.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

