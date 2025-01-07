module 0x643ae7722e5916e2ce9b654ba791cb432a5b18e0c4ad7f55776a27e99c0db248::man {
    struct MAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAN>(arg0, 9, b"MAN", b"Man", x"54686973206973204d616e2e200a0a4265206c696b65204d616e2e0a0a42652061204d616e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/WhZEoFj5uejcq392GeYEC7Fmwr5q49wyq9jD5U3pump.png?size=xl&key=12e7a4")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

