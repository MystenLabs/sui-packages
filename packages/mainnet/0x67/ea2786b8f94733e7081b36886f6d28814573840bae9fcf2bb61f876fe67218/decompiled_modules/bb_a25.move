module 0x67ea2786b8f94733e7081b36886f6d28814573840bae9fcf2bb61f876fe67218::bb_a25 {
    struct BB_A25 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BB_A25, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BB_A25>(arg0, 9, b"BB_A25", b"bb", x"73c4916664", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dacd8ec7-b760-439b-b380-ec71a2679add.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BB_A25>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BB_A25>>(v1);
    }

    // decompiled from Move bytecode v6
}

