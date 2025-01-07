module 0x7fc8c7aec2ffd025538ce8c21699515543e3775716d00d7cc97ffaf087b41986::cgk {
    struct CGK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CGK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CGK>(arg0, 9, b"CGK", b"CINGOGOK", b"Cingogok Meme Pirates", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ec6a4c7e-8bcd-4801-b5ce-b8840b9db2ed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CGK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CGK>>(v1);
    }

    // decompiled from Move bytecode v6
}

