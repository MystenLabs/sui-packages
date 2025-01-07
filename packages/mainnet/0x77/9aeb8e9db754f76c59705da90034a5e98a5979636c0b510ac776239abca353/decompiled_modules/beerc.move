module 0x779aeb8e9db754f76c59705da90034a5e98a5979636c0b510ac776239abca353::beerc {
    struct BEERC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEERC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEERC>(arg0, 9, b"BEERC", b"BeerCoin", b"Beer nice", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cf10eff7-9c7d-432e-a82c-8d6d6b6dc6a0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEERC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEERC>>(v1);
    }

    // decompiled from Move bytecode v6
}

