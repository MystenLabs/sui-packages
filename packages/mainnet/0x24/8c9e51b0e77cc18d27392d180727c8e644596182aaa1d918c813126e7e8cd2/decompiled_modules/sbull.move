module 0x248c9e51b0e77cc18d27392d180727c8e644596182aaa1d918c813126e7e8cd2::sbull {
    struct SBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBULL>(arg0, 6, b"sBull", b"sui bull", b"As the first bull on the Sui network, SUIBULL represents the bullish momentum, innovation, and unstoppable drive toward decentralization.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/profpic_bull_6f4fad0bd4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

