module 0x4bc712943b0e655efbe82c3bf9f8bf1145ef9ae8a8bcb0830023c4d5b7c57680::grok {
    struct GROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROK>(arg0, 9, b"GROK", b"Grok SUI", b"Just grok it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/434a50c1-0e30-4114-9703-ca822a8f4174.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GROK>>(v1);
    }

    // decompiled from Move bytecode v6
}

