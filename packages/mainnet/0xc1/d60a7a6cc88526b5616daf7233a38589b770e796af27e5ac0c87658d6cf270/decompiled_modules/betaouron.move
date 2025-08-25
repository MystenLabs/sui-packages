module 0xc1d60a7a6cc88526b5616daf7233a38589b770e796af27e5ac0c87658d6cf270::betaouron {
    struct BETAOURON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BETAOURON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BETAOURON>(arg0, 6, b"BetaOuron", b"BetaOuron333", b"Just wait", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000740_9cffff6a3c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BETAOURON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BETAOURON>>(v1);
    }

    // decompiled from Move bytecode v6
}

