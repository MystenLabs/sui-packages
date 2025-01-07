module 0x19986cd0499e93111f44abcd7ba8a766e4a4029e870b95b5f238576a7ec87f00::oggie {
    struct OGGIE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<OGGIE>, arg1: 0x2::coin::Coin<OGGIE>) {
        0x2::coin::burn<OGGIE>(arg0, arg1);
    }

    fun init(arg0: OGGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGGIE>(arg0, 9, b"Oggie", b"OGGIE", b"Oggie Leading MEME SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/D85UjuRzazGeSS24E8yFy4DtKczmipwFNew4SKe1dEBy.png?size=lg&key=391dc7")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OGGIE>>(v1);
        0x2::coin::mint_and_transfer<OGGIE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<OGGIE>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<OGGIE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<OGGIE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

