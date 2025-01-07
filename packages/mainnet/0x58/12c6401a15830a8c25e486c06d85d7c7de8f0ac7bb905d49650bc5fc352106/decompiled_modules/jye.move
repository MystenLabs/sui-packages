module 0x5812c6401a15830a8c25e486c06d85d7c7de8f0ac7bb905d49650bc5fc352106::jye {
    struct JYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JYE>(arg0, 9, b"JYE", b"KGE", b"But I don't ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3081e206-323c-4d3c-bec6-0e6ca1ee8eb5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

