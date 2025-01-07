module 0x1e1bd06a6052e60fe03afbf0f347fdfd60a8bec78619f0cba030dc009e2044fd::movedump {
    struct MOVEDUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEDUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEDUMP>(arg0, 6, b"MOVEDUMP", b"MoveDump", b"The First Meme Dump Platform on SUI Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_8720706bc3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEDUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVEDUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

