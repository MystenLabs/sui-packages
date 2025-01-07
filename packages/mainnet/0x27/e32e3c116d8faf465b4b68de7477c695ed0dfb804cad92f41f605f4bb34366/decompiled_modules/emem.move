module 0x27e32e3c116d8faf465b4b68de7477c695ed0dfb804cad92f41f605f4bb34366::emem {
    struct EMEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMEM>(arg0, 9, b"EMEM", b"Emem", b"Reverse WEWE token from community to community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2290fbfe-95df-4d57-872a-6903056cd21f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EMEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

