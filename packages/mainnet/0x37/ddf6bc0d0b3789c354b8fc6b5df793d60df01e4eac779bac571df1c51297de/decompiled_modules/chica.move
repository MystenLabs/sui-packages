module 0x37ddf6bc0d0b3789c354b8fc6b5df793d60df01e4eac779bac571df1c51297de::chica {
    struct CHICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHICA>(arg0, 6, b"Chica", b"Markipliar Dog (Chica)", x"43656c6562726174696e67206d7920446f672024436869636120666f7220686572206c6f79616c747920616e64206c6f766520616c776179732e0a492077696c6c20706f73742074686973206f6e206d792078206f6e6365202443686963612072656163682061203130302520626f6e64696e672063757276652e0a416c6c2070726f6669747320676f657320746f204368617269747920666f7220737472617920446f67732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000725612_1d5bd8e065.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHICA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHICA>>(v1);
    }

    // decompiled from Move bytecode v6
}

