module 0xb076265eb6cae85e68cde617e63cd56e56e73b57c1c488bbc979be296d74d8e1::aaameme {
    struct AAAMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAMEME>(arg0, 6, b"AAAMEME", b"aaa Meme", b"AAAAAAAAAAAAAAAAAAAAA  Meme Is Gemes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000207_16a5633255_0416923d52.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

