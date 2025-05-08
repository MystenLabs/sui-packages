module 0x202fdd496837a99f7ae9b7eca8ff8c072061bd1a5c1936ddae831936d5aba829::flipgirl {
    struct FLIPGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLIPGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLIPGIRL>(arg0, 9, b"FLIPGIRL", b"Flip Titty Girl", b"Flip titty girl has officially arrived!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/CxZuAv8LH4LWJ9CFBjGi6V6Vb9jA3EHUDtJDyCQ2pump.png?size=xl&key=0f8f07")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FLIPGIRL>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIPGIRL>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLIPGIRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

