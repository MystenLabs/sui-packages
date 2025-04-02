module 0x53231b3f7d1707f1258363d4ccd295ff62d274cb601d5885843f0f5066c424cf::mvp {
    struct MVP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MVP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MVP>(arg0, 6, b"MVP", b"MOVEPUMP", b"MovePump ($MPUMP) is a next-generation token designed to fuel the Move-based blockchain ecosystem, providing liquidity, incentives, and enhanced trading efficiency. Backed by cutting-edge tokenomics and a strong community, MPUMP is set to revolutionize decentralized finance (DeFi) and empower users across the MoveVM ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/movepump_logo_5afd89f2b2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MVP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MVP>>(v1);
    }

    // decompiled from Move bytecode v6
}

