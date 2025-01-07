module 0x2810068a199f0080c605d4c62d4a538a7e32f6fd1f1093e0475310bf9ee3f23d::movedump {
    struct MOVEDUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEDUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEDUMP>(arg0, 6, b"MOVEDUMP", b"MoveDump", b"The First Meme Fair Launch Platform on SUI Network coming up after a hole issue day.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/_ac2436fe70.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEDUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVEDUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

