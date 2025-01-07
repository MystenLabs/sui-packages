module 0xd104b7f07803886c91894f6ca1155805bfae36fc327ae774fe296173f7a11df5::supersui {
    struct SUPERSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPERSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPERSUI>(arg0, 6, b"SUPERSUI", b"Super Suiyan", b"Super Suiyan is at its ultrainstinct mode of being a super saiyan with a perfect mix of meme and trump hype.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/449766213_1013832960377974_4169381918957775262_n_8517a0cfca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPERSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPERSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

