module 0x2f93b2bc3856220dc1d32fe98d75d988a37c653d534c6bb3ed638246e3abdc9c::mes {
    struct MES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MES>(arg0, 9, b"MES", b"Memesui", b"Memesui token focuses on currencies transfer among countries with the aid of cryptocurrency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cc11becf-2fd1-4dce-860e-92d4b72f455a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MES>>(v1);
    }

    // decompiled from Move bytecode v6
}

