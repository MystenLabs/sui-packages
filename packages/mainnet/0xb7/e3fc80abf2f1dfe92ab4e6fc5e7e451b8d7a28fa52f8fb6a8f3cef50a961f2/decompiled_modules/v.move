module 0xb7e3fc80abf2f1dfe92ab4e6fc5e7e451b8d7a28fa52f8fb6a8f3cef50a961f2::v {
    struct V has drop {
        dummy_field: bool,
    }

    fun init(arg0: V, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<V>(arg0, 9, b"V", b"Var", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/83973c0a-6443-46ed-8f5e-ae73bb00a780.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<V>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<V>>(v1);
    }

    // decompiled from Move bytecode v6
}

