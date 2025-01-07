module 0xca354328f29b4c1363783dd9ed5ac5cdc29c033127779768208bee909e6876b1::jsnt {
    struct JSNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JSNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JSNT>(arg0, 6, b"JSNT", b"Jason Token", b"Get $JSNT and be part of the most feared community on the SUI network. Jason Token the meme coin killer.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Jason_Token_715de21d28.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JSNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JSNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

