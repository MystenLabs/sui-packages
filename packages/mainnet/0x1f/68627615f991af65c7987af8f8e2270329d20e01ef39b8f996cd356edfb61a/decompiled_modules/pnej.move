module 0x1f68627615f991af65c7987af8f8e2270329d20e01ef39b8f996cd356edfb61a::pnej {
    struct PNEJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNEJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNEJ>(arg0, 9, b"PNEJ", b"hehe", b"hdbd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e46f566e-3eb0-4deb-afc6-86f384fe0dea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNEJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNEJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

