module 0x55610b579f0909a0120ecbf2dc0244a69a932be4356636d8122bee3a59677837::moonpig {
    struct MOONPIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONPIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONPIG>(arg0, 9, b"MOONPIG", b"moonpig", b"moonpig.moonpig.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/Ai3eKAWjzKMV8wRwd41nVP83yqfbAVJykhvJVPxspump.png?size=xl&key=e58103")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOONPIG>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONPIG>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOONPIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

