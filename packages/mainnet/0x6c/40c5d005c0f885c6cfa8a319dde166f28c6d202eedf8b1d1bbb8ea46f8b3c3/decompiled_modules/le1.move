module 0x6c40c5d005c0f885c6cfa8a319dde166f28c6d202eedf8b1d1bbb8ea46f8b3c3::le1 {
    struct LE1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LE1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LE1>(arg0, 9, b"LE1", b"lelee", b"Good", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6173c1df-2695-4cb7-ac8a-44f80aabb476.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LE1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LE1>>(v1);
    }

    // decompiled from Move bytecode v6
}

