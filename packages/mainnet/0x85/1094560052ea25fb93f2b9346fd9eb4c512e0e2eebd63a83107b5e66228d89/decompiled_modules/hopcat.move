module 0x851094560052ea25fb93f2b9346fd9eb4c512e0e2eebd63a83107b5e66228d89::hopcat {
    struct HOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPCAT>(arg0, 6, b"Hopcat", b"HOPCAT", x"41726520796f75206578636974656420666f7220746865206c61756e6368206f6620686f702e66756e20696e206a75737420612066657720686f7572732c206275742063616e277420776169743f200a0a5468697320697320776879207765206c61756e636865642074686520484f5043415420546f6b656e203a3a3a556e6f6666696369616c3a3a3a200a0a4c6574277320686176652066756e2068657265207768696c6520746865206f6666696369616c2072656c6561736573206f6e20484f502e46554e20617272697665", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000043133_cd16437418.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

