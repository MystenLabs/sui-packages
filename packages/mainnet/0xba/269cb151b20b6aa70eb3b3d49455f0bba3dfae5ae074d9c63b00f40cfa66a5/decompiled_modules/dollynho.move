module 0xba269cb151b20b6aa70eb3b3d49455f0bba3dfae5ae074d9c63b00f40cfa66a5::dollynho {
    struct DOLLYNHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLLYNHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLLYNHO>(arg0, 6, b"Dollynho", b"Dollynho on sui", b"Dolly, the meme coin inspired by a lively green bottle character, embodies fun and energy in the crypto world. With its bold personality and cheerful spirit, Dolly aims to capture the hearts of the meme coin community while delivering an exciting and engaging investment opportunity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000258376_0710ad0c7a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLLYNHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLLYNHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

