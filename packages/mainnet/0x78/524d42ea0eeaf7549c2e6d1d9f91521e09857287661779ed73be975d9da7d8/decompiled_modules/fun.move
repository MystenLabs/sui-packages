module 0x78524d42ea0eeaf7549c2e6d1d9f91521e09857287661779ed73be975d9da7d8::fun {
    struct FUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUN>(arg0, 6, b"FUN", b"Funnify AI meme video generator", x"46756e6e69667920204149206d656d6520766964656f2067656e657261746f722066726f6d20616e7920696d6167652e0a506f77657265642062792066756e2c206275696c74206f6e205355492e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017028_f29489694b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

