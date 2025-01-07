module 0xe589f692fbb4c2b20a2c469040190c4bb21e855717c80d485c42c9ef400e06c2::bull {
    struct BULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULL>(arg0, 9, b"BULL", b"Chill Bull", b"The chillest and most bullish memecoin on the SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/2cEYuN7vjSfayPXdLcZFgrhk3czLckGP4C2JGCWDPGRt.png?size=xl&key=502767")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BULL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

