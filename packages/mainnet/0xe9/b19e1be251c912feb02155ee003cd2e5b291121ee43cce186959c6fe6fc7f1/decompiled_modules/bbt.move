module 0xe9b19e1be251c912feb02155ee003cd2e5b291121ee43cce186959c6fe6fc7f1::bbt {
    struct BBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBT>(arg0, 9, b"BBT", b"Babyturtle", b"come and heal the baby turtles", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ca5f0009-cfb3-4a96-9aa0-b44dabcd165f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBT>>(v1);
    }

    // decompiled from Move bytecode v6
}

