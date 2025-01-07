module 0x7741298794fbf04970ef9b537c6e38534a20640e50d6e6a27c3b6746261f5e6c::SIR {
    struct SIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIR>(arg0, 9, b"SIR", b"Strategic Inu Reserve", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x44171cbbfa69aba3d0a3fd91ab3c979900c620e9.png?size=xl&key=327e8d")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SIR>>(0x2::coin::mint<SIR>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SIR>>(v2);
    }

    // decompiled from Move bytecode v6
}

