module 0xb9e48cf7105f7ca35565d2ec803cabde1e6f4a4314edf53f9f58e6829a78303a::oend {
    struct OEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: OEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OEND>(arg0, 9, b"OEND", b"iend", b"dnnw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6a7fa08f-efd0-46cc-b557-5aa99509178e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

