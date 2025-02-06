module 0x8c6690f7c4c94dfa9badd33a7e7f55214830eff1f215ce8c5a392e81d00c6f38::strategy {
    struct STRATEGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRATEGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRATEGY>(arg0, 6, b"STRATEGY", b"Strategy Sui", b"MicroStrategy is now Strategy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001634_063d1f7790.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRATEGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRATEGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

