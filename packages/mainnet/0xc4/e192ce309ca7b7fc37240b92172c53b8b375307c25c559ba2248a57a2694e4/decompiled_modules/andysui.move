module 0xc4e192ce309ca7b7fc37240b92172c53b8b375307c25c559ba2248a57a2694e4::andysui {
    struct ANDYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANDYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANDYSUI>(arg0, 6, b"AndySui", b"ANDY BOYS CLUB", b"ANDY BY BOYS CLUB FURRIE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3498_3a7f62dd52.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANDYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANDYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

