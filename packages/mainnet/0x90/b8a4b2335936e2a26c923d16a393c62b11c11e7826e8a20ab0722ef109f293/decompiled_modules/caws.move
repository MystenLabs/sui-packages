module 0x90b8a4b2335936e2a26c923d16a393c62b11c11e7826e8a20ab0722ef109f293::caws {
    struct CAWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAWS>(arg0, 9, b"CAWS", b"Caws Coin", b"CAWS coin is the best....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3591318c-98f2-407d-8422-6c3658219d42.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

