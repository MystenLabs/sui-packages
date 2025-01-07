module 0x501b80c4428a5df9d4330c49820cae8aa9fe9eeb2fa9fa1020afb570edce6c1c::edge {
    struct EDGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDGE>(arg0, 6, b"EDGE", b"ReefEdge", b"ReefEdge is a cutting-edge cryptocurrency token inspired by the dynamic beauty of ocean reefs and the sharp precision of blockchain technology. Representing innovation, resilience, and sustainability, ReefEdge bridges the world of decentralized finance with the elegance of marine ecosystems, creating a token thats as vibrant and forward-thinking as its name suggests.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cd7cdac6_c835_47be_9718_a2ded43af202_4c2f845da9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EDGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

