module 0xe61e6aec4b2c6f6262718b6601e3368749aa80b527eed8a348d287f53eb1b87f::trumps {
    struct TRUMPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPS>(arg0, 6, b"TRUMPS", b"Trumps", b"NEW Official Trump Meme is HERE!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000026954_8789088962.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

