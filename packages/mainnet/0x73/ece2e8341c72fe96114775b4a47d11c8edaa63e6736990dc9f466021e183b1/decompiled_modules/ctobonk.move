module 0x73ece2e8341c72fe96114775b4a47d11c8edaa63e6736990dc9f466021e183b1::ctobonk {
    struct CTOBONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTOBONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTOBONK>(arg0, 6, b"CTOBONK", b"CTO BONK", b" Inspired by Bonk, $BONK enthusiasts knew there needed to be a safe $BONK with strong backers on the quickly evolving Sui Chain. Bonk is known as \"The Dog Coin of the People\", inspired by internet memes and jokes.and are soon launching a smart wallet which will enable all users to use Sui and buy meme coins such as $BONK. Sui is quickly growing day by day, don't miss $BONK - one of the greatest memes in history", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_862153b2ff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTOBONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTOBONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

