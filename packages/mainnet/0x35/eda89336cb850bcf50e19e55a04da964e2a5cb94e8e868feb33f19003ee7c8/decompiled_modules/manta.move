module 0x35eda89336cb850bcf50e19e55a04da964e2a5cb94e8e868feb33f19003ee7c8::manta {
    struct MANTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANTA>(arg0, 6, b"MANTA", b"Manta Ray", b"$MANTA  The first manta ray on the Sui blockchain, gliding through DeFi oceans. Power meets playfulness. Ride the waves with $MANTA ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/manta_6d523dca3a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

