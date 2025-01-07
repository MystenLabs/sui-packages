module 0x719ccbec4b38ef8ad163e6898655ca63af122e80a7749acfa237549647b244bb::suits {
    struct SUITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITS>(arg0, 6, b"SUITS", b"SUI_SUITS", b"SUITS restores your faith in meme investing. The Real Deal, making sure everyone gets a meal. Here to pump your bags, not leave you sad. Welcome to the firm.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/94i_A9_D_400x400_7f9e580190.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITS>>(v1);
    }

    // decompiled from Move bytecode v6
}

