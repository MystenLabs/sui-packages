module 0xb425ef3b69905d684dc5a8019896ad077c2623e3e457195a896a6fe18f37fcea::jump {
    struct JUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUMP>(arg0, 6, b"JUMP", b"Jump Games", b"Meme Gaming for Web3 SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Nq5_KLP_Q_400x400_7838a69ceb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

