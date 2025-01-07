module 0x5f1e6e7f6a7185d200fb82e8474eedf98edb8840718b2b392118707ff41906cd::trollsanta {
    struct TROLLSANTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROLLSANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLLSANTA>(arg0, 6, b"TROLLSANTA", b"Troll santa Sui", b"Troll Santa brings the legendary Troll meme face into the holiday spirit! With a playful twist on Santa Claus, this token is here to spread endless laughs, mischief, and joy. Get ready for a festive season full of fun and memes!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul32_20241219190431_40dc9d0aa5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLLSANTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TROLLSANTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

