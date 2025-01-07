module 0xaa1559ffdfef2f8406a61bcc6dfc123f085285d37e6b6f075281a900842d255b::emoji {
    struct EMOJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMOJI>(arg0, 6, b"EMOJI", b"SUI EMOJI", b"In the vibrant world of Emojiland, there lived a cheerful emoji on Sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cb8ac690_880e_4c44_961c_ad6626fbd1ad_900d6fee3a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMOJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EMOJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

