module 0xd710ecf3b5d71137af7b1c8d02bdb6529a379258f5082689fb217a9988ab0263::elonmeme {
    struct ELONMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONMEME>(arg0, 6, b"ELONMEME", b"ELON MEME", b"it's $EMF day why not say gm ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004429_b91fc51799.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELONMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

