module 0x7edd868a050ffd41490697659c4bb0d1da822fb0f8dcf961a52b9ceddd0e4096::profith {
    struct PROFITH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PROFITH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROFITH>(arg0, 9, b"PROFITH", b"PROFIT HEAD", b"Where Growth Becomes the Only Option", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/6qKtvGariq5BDNdR8um9xPVaHdsFQZscye6PUDrPpump.png?size=xl&key=5488b0")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PROFITH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PROFITH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PROFITH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

