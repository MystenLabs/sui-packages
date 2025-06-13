module 0x4668bd53ce2cb7626cc3e4ec1aa33c0f754a55467aee917acffdd12dd856dbfe::barron {
    struct BARRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARRON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARRON>(arg0, 9, b"BARRON", b"BARRON TRUMP", b"Son of the President, master of memes. Barron aped Sui and now everyone's watching his wallet. Buy, hold, and pray he doesn't dump. Only diamond hands survive.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/gigagfun/barrontrump/refs/heads/main/BARRONTRUMP.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BARRON>>(0x2::coin::mint<BARRON>(&mut v2, 6420420420000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BARRON>>(v2);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARRON>>(v1);
    }

    // decompiled from Move bytecode v6
}

