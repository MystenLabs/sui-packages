module 0x107c805561f80f2eea77c83f43548f3b553ac8173e778d52695139fdc35c5e73::bos {
    struct BOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOS>(arg0, 6, b"BOS", b"Bonk On Sui", b"Inspired by Bonk, $BONK enthusiasts knew there needed to be a safe $BONK with strong backers on the quickly evolving Sui Chain. Bonk is known as \"The Dog Coin of the People\", inspired by internet memes and jokes.and are soon launching a smart wallet which will enable all users to use Sui and buy meme coins such as $BONK. Sui is quickly growing day by day, don't miss $BONK - one of the greatest memes in history.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bonk_bonk_7f7ed60df4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

