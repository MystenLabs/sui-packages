module 0xf401405c30f2c55165e71b2652dffe2fc6e1b6d217c7b5fa1f52171b01badd7d::tcc {
    struct TCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCC>(arg0, 9, b"TCC", b"3 CAT ", b"It grows 300%", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8f10c56e-d165-48fd-97a7-e9f67a198093.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TCC>>(v1);
    }

    // decompiled from Move bytecode v6
}

