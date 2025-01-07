module 0x6105a47d934d7c2ea5cfccdf259e83b60c297e10883de4aa9e036f5fab8bd24::LIQ {
    struct LIQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIQ>(arg0, 9, b"LIQ", b"Liquor", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/sui/0x9c86d1926a0a39e906f20674d6a35f337be8625ebcb6b799ee8ff011f328bee2::liq::liq.png?size=xl&key=50a768")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIQ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<LIQ>>(0x2::coin::mint<LIQ>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LIQ>>(v2);
    }

    // decompiled from Move bytecode v6
}

