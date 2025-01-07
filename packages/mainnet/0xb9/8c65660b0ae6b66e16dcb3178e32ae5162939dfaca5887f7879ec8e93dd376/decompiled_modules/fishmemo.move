module 0xb98c65660b0ae6b66e16dcb3178e32ae5162939dfaca5887f7879ec8e93dd376::fishmemo {
    struct FISHMEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHMEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHMEMO>(arg0, 9, b"FISHMEMO", b"MEMO", b"meme coin adaption from fish memo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/969d6f85-66c7-431b-9e6d-5efecd3a5403.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHMEMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FISHMEMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

