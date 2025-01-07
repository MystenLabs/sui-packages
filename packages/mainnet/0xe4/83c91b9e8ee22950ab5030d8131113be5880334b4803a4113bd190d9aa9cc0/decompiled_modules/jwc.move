module 0xe483c91b9e8ee22950ab5030d8131113be5880334b4803a4113bd190d9aa9cc0::jwc {
    struct JWC has drop {
        dummy_field: bool,
    }

    fun init(arg0: JWC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JWC>(arg0, 6, b"JWC", b"JamesWoof", b"Meme coin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9534_5630312d8e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JWC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JWC>>(v1);
    }

    // decompiled from Move bytecode v6
}

