module 0x97effa53acbf98a3a98aa61f5fb920fc4967c52b60dfcbee63665d576c19e3b::suirange {
    struct SUIRANGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRANGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRANGE>(arg0, 6, b"SUIRANGE", b"Annoying Suirange", b" Suirange: The meme coin that's as juicy as it is annoying!  Built for laughs, vibes, and community-driven fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/real_annoying_orange_240_6daa5ff1799643988f0965819ffd5c31_b77e20581c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRANGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRANGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

