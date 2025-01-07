module 0xf36b26b7365b4bd1f2afbcbb356be51f99a961e5707c7e06349620be30395f98::doge2049 {
    struct DOGE2049 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE2049, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE2049>(arg0, 6, b"DOGE2049", b"DOGE-2049", b"Inspired by Token2049 Summit  | AI-driven tools, education, & investment strategies | Join the future of memecoins!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3575_599965aa25.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE2049>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGE2049>>(v1);
    }

    // decompiled from Move bytecode v6
}

