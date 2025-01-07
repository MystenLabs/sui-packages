module 0xdb332da99f4f11a9e426559d98daed585827c6e2f3b84dc3c739e39aba0f8391::nick {
    struct NICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NICK>(arg0, 6, b"NICK", b"Nick Szabo", b"Elon Musk thinks that Nick Szabo is Satoshi Nakamoto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nick_3ffedbc749.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

