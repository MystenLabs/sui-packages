module 0xae24ae86fdc507ff4ee375679ae379b40f045ce8435a7bf9458d60b8f1bd7e34::aaameme {
    struct AAAMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAMEME>(arg0, 6, b"aaaMEME", b"Meme Is Gemes", b"aaa is popular in Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000207_16a5633255.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

