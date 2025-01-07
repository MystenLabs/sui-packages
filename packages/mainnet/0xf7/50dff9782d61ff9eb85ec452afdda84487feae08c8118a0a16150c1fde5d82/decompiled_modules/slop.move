module 0xf750dff9782d61ff9eb85ec452afdda84487feae08c8118a0a16150c1fde5d82::slop {
    struct SLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOP>(arg0, 6, b"Slop", b"sui slop", b"SLOP is the story of a unique project in the blockchain world, which began as a failed smart contract experiment but grew into a vibrant digital ecosystem through community resilience and innovation.In a group of blockchain developers, a team set out to create an automated liquidity provisioning protocol that would help users easily trade across decentralized platforms, saving both time and costs. The project was initially named the \"Simple Liquidity Optimization Protocol,\" or **SLOP**. The goal was to develop a simple yet efficient liquidity optimization system, allowing users to seamlessly switch between assets and profit from their trades", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/type_default_350_0_7495deb153.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

