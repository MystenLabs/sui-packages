module 0xb697fede2237722a6f5d5ec7920542513db7eab253ce36cb1203e6555836888d::strike {
    struct STRIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRIKE>(arg0, 6, b"Strike", b"Sui Strike", b"Get ready for impact - Sui Strike is the meme coin missile you didn't see it coming!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_strike_82babca859.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRIKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRIKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

