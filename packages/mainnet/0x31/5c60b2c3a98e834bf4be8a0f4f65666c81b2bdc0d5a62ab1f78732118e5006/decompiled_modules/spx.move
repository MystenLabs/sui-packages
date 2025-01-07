module 0x315c60b2c3a98e834bf4be8a0f4f65666c81b2bdc0d5a62ab1f78732118e5006::spx {
    struct SPX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPX>(arg0, 6, b"SPX", b"SPACE X", b"SpaceX could leverage the Sui network to enhance its operations through decentralized applications (dApps) that improve data management, supply chain logistics, and communication systems. The high throughput and low latency characteristics of the Sui blockchain could facilitate real-time tracking of spacecraft components and mission-critical data.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/spcaexx_4fa6a13fc1.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPX>>(v1);
    }

    // decompiled from Move bytecode v6
}

