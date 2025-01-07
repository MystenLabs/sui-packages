module 0xa880df98f1556b41e4f6e206c5627ea1305ad83c91ccf9d6fc1411b604a0b997::booo {
    struct BOOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOO>(arg0, 6, b"Booo", b"Booosui", b"Nothing, just meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6710_96efd4b45b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

