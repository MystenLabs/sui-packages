module 0x42a8e0861033d5d0a4be3189e17750181e20b1e2afe4f63f3b2b40f1e7b5078f::moo {
    struct MOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOO>(arg0, 9, b"MOO", b"MooDeng", b"1000000000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d7343ad-bfd7-43be-8360-551911b07a10.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

