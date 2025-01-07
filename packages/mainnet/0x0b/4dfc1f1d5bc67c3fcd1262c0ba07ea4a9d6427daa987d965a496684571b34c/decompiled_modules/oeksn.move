module 0xb4dfc1f1d5bc67c3fcd1262c0ba07ea4a9d6427daa987d965a496684571b34c::oeksn {
    struct OEKSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OEKSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OEKSN>(arg0, 9, b"OEKSN", b"shieje", b"jdnsb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6e692e67-e162-48f1-9a3e-cacca573d087.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OEKSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OEKSN>>(v1);
    }

    // decompiled from Move bytecode v6
}

