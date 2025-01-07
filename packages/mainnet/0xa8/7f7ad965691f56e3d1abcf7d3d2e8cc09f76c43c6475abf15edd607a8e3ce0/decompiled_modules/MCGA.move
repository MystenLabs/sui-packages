module 0xa87f7ad965691f56e3d1abcf7d3d2e8cc09f76c43c6475abf15edd607a8e3ce0::MCGA {
    struct MCGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCGA>(arg0, 9, b"MCGA", b"Make Crypto Great Again", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/DsTuRWqwZ3n99zEvsQVRcxP62uxDJekxzpfHr7bZpump.png?size=xl&key=ab2eb4")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MCGA>>(0x2::coin::mint<MCGA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MCGA>>(v2);
    }

    // decompiled from Move bytecode v6
}

