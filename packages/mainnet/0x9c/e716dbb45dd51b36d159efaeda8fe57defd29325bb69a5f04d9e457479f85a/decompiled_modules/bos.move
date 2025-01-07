module 0x9ce716dbb45dd51b36d159efaeda8fe57defd29325bb69a5f04d9e457479f85a::bos {
    struct BOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOS>(arg0, 6, b"BOS", b"Bonk On Sui", b"Inspired by Bonk, $BONK enthusiasts knew there needed to be a safe $BONK with strong backers on the quickly evolving Sui Chain. Bonk is known as \"The Dog Coin of the People\", inspired by internet memes and jokes.and are soon launching a smart wallet which will enable all users to use Sui and buy meme coins such as $BONK. Sui is quickly growing day by day, don't miss $BONK - one of the greatest memes in history.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_680461e83c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

