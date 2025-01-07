module 0xf386220a0487746eaa9fd7deab154d6c68ce7f556e8381d949b5390c13613d63::CLOCK {
    struct CLOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOCK>(arg0, 6, b"CLOCK", b"CLOCK", b"Clocks and cryptocurrency share a symbolic connection through their emphasis on time and precision. Clocks represent the relentless passage of time and the importance of timing in life's decisions, while cryptocurrency relies on precise algorithms and timestamped transactions within blockchain technology. In the crypto world, timing can also mean the difference between profit and loss, as markets are dynamic and operate 24/7. This interplay of time and technology underscores the importance of staying synchronized and adaptive in a rapidly evolving digital age", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmUg6UU34jaXJ2ZRx8ivFs2H3mHypoMjbXmoT745oHV7Ua")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLOCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

