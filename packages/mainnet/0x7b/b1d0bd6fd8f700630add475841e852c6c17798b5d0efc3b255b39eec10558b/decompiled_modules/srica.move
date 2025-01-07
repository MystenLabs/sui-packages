module 0x7bb1d0bd6fd8f700630add475841e852c6c17798b5d0efc3b255b39eec10558b::srica {
    struct SRICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRICA>(arg0, 9, b"SRICA", b"PirateRica on Sui", b"$SRica, a beautiful mermaid, is fascinated with stories about the human world. After transforming into a young girl with the power to control the value of gold, Rica becomes a member of \"Rica the Pirate\", Stealing ill-gotten wealth from the wicked and giving gifts to the poor. The meme coin \"Rica the Pirate\" spread around the world, becoming a symbol of freedom, decentralization and the infinite potential of blockchain. Rica the Pirate inspires people about the power of kindness and fairness. X: https://x.com/rica_sui, Web: ricasui.fun, Telegram: https://t.me/ricasui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://x.com/NNV1247349/status/1842225006182535354")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SRICA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRICA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRICA>>(v1);
    }

    // decompiled from Move bytecode v6
}

