module 0xbf38e396970aa06e188e81c4a0dcf677941f5d43cffa7f5565af708a00f7e609::fuentes {
    struct FUENTES has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUENTES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUENTES>(arg0, 6, b"FUENTES", b"NICK", b"FUENTES ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nick_7c1613e3ee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUENTES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUENTES>>(v1);
    }

    // decompiled from Move bytecode v6
}

