module 0xbfa17b23e358905b7a37ced26be8f9546d79714930525cda2b8a347be15ca9d2::hcat {
    struct HCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HCAT>(arg0, 6, b"HCAT", b"House Cat", x"53686573206120486f757365206f6e204361742062757420646f65736e277420747261646520686f757365732e0a0a5368657320666c69707320746865206d61726b657420696e73746561642e0a0a5361792048656c6c6f20746f20486f7573652043617420436f696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000072725_70e00b409a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

