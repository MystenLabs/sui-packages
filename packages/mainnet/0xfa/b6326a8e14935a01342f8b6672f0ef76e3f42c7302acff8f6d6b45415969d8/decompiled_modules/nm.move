module 0xfab6326a8e14935a01342f8b6672f0ef76e3f42c7302acff8f6d6b45415969d8::nm {
    struct NM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NM>(arg0, 9, b"NM", b"Nemo", b"Nemo is best cartoon in world ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e6ee1e88-c5bb-45c3-8f48-aaae6f47bde4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NM>>(v1);
    }

    // decompiled from Move bytecode v6
}

