module 0xcbe5d5c2e52b537a3a77940f5a67cab115c14b07b13930c0a22e857b5fe349a8::glo_43 {
    struct GLO_43 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLO_43, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLO_43>(arg0, 9, b"GLO_43", b"Glory ", b"Glorycoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c4430c63-7b93-4731-a40f-716a900ca844.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLO_43>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLO_43>>(v1);
    }

    // decompiled from Move bytecode v6
}

