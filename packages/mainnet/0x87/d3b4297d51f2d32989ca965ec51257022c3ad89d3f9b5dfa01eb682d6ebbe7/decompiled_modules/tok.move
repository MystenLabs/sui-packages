module 0x87d3b4297d51f2d32989ca965ec51257022c3ad89d3f9b5dfa01eb682d6ebbe7::tok {
    struct TOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOK>(arg0, 6, b"Tok", b"Tok Tok", b"We are trying to bring meme coin to a new era. Buy it and wait until it is on the top", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fc3e7d2e_1e1a_4976_a127_6685394a4cf7_3e59c62454_9b96d54af9.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

