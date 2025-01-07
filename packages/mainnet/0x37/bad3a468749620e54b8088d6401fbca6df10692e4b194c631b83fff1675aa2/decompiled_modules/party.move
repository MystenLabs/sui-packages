module 0x37bad3a468749620e54b8088d6401fbca6df10692e4b194c631b83fff1675aa2::party {
    struct PARTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PARTY>(arg0, 6, b"PARTY", b"PDiddy-BootyCoin", b"The only meme coin with enough \"assets\" to shake off any rivals!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/booty_9427b85a53.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PARTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

