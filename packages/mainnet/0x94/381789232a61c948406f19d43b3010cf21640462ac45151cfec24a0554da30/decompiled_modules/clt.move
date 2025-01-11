module 0x94381789232a61c948406f19d43b3010cf21640462ac45151cfec24a0554da30::clt {
    struct CLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CLT>(arg0, 6, b"CLT", b"SUI COLLECTIVE by SuiAI", b"The SUI Collective AI Agent is designed to be the heartbeat of our community on Twitter. It's a dynamic digital entity that interacts with followers, providing real-time updates, insights, and fostering engagement around $SUI. With a personality tailored to educate, entertain, and empower, this AI agent ensures that every interaction adds value, helping to build a closely-knit community of crypto enthusiasts. It's your guide, your companion, and your source of all things $SUI, making the Twitter experience interactive, informative, and inclusive.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_5403_212b822e75.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CLT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

