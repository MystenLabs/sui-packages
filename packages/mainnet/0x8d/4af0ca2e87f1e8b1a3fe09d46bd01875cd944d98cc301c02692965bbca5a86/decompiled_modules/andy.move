module 0x8d4af0ca2e87f1e8b1a3fe09d46bd01875cd944d98cc301c02692965bbca5a86::andy {
    struct ANDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANDY>(arg0, 6, b"ANDY", b"Andy", b"$ANDY- A legendary character inspired by Matt Furies Boys club comic. Joining $PEPE, $BRETT and $WOLF on SUI chain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_01_at_12_38_39_PM_279971e582.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

