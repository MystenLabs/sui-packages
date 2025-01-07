module 0x76db570bcc61c7a32ae49de3c0cf83295f9dde00683a514cf5f7ab56f8daf3b4::joke {
    struct JOKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOKE>(arg0, 9, b"JOKE", b"A joke ", b"How much are you willing to pay to laugh HA Ha Ha Ha Ha Ha Ha Ha Ha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1917fa0a-777a-4385-ae08-7d060641e26c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

