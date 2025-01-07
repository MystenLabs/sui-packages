module 0x8ad1a018bc2f4af0caa061dc8c00678dc557c3920575bb45aabfd3137552c4b2::pct {
    struct PCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PCT>(arg0, 9, b"PCT", b"Popcat", b"Poppy cat meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5c7b3d3a-6676-4904-bec9-d577d75a0496.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

