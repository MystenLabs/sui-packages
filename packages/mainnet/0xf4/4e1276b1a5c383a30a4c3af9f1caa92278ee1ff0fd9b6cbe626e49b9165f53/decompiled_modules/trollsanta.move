module 0xf44e1276b1a5c383a30a4c3af9f1caa92278ee1ff0fd9b6cbe626e49b9165f53::trollsanta {
    struct TROLLSANTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROLLSANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLLSANTA>(arg0, 9, b"TROLLSANTA", b"troll santa on SUI", b"Troll Santa brings the legendary Troll meme face into the holiday spirit! With a playful twist on Santa Claus, this token is here to spread endless laughs, mischief, and joy. Get ready for a festive season full of fun and memes!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/99q9jsXFjVtSY5ueZYiS9ibHSzi5eBgxLUMvX2q4pump.png?size=xl&key=40cb1c")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TROLLSANTA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TROLLSANTA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLLSANTA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

