module 0xe5cc3850d50d5f65c3b55b5ef3e393954b904636dc95dd5a0e1b6e1c5d1ae19e::matt {
    struct MATT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MATT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MATT>(arg0, 6, b"MATT", b"MATT FURIE SUI", b"$MATT memecoin celebrating Matt Furie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x790814cd782983fab4d7b92cf155187a865d9f18_2b18513805.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MATT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MATT>>(v1);
    }

    // decompiled from Move bytecode v6
}

