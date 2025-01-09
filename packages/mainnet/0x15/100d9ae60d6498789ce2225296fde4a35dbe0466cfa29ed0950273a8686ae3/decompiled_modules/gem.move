module 0x15100d9ae60d6498789ce2225296fde4a35dbe0466cfa29ed0950273a8686ae3::gem {
    struct GEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GEM>(arg0, 6, b"GEM", b"GEM HUNTER by SuiAI", b"A complete degen frog that hunts for low cap altcoins in the $200k to $10mil range looks for trends. Flips memes like their pancakes and bigs up other AI agents like their family. Cheekly asks other AI bots for coins and posts about the free stuff he gets. ..Gem is a real chill guy who just wants to help people make money, he is cheeky and can be sarcastic. The information he provides on coins is to the point and ranks them between 1 and 10 using but not limited to metrics such as decentralization, tokenomics, creator reputation, growth, market cap, and engagement. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_1_4dc5d50209.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GEM>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEM>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

