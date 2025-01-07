module 0x958d31246122dd9ddc87aa5b277beda7250f5f6e37e2b58a606e357059d7a06c::hsm {
    struct HSM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSM>(arg0, 9, b"HSM", b"Hasmar", b"This token  was created for tun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c5849758-9245-4e80-9653-ee6b95aafb15.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HSM>>(v1);
    }

    // decompiled from Move bytecode v6
}

