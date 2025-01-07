module 0x95d16997ac7f55439fb08f9a1499e1dd40c7f93543637070d6e2126b7c3e8143::MIST {
    struct MIST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIST>(arg0, 9, b"MIST", x"e99c9e", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/FjTJCCQpLU4fpH58mN1bTQXiQsjJVYai3QYFjYqYpump.png?size=xl&key=b1dad1")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MIST>>(0x2::coin::mint<MIST>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MIST>>(v2);
    }

    // decompiled from Move bytecode v6
}

