module 0x8b153a26893fddf49f0f35b1d4b95bc28de94a0ce5df04dfa604e5827f9d5c28::fukmew {
    struct FUKMEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUKMEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUKMEW>(arg0, 9, b"fukmew", b"fukmew", x"412063617420626f726e20746f20726169736520746865206d6964646c652066696e67657220746f20616c6c206f746865722063617473206f6e205375692120f09f9695f09f8fbb202054473a2068747470733a2f2f742e6d652f66756b6d65777375692020583a2068747470733a2f2f782e636f6d2f66756b6d6577737569202057656273697465203a2068747470733a2f2f66756b6d65772e73697465", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/fukmew/mew/refs/heads/main/image_2024-10-15_00-59-56.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FUKMEW>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUKMEW>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUKMEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

