module 0x594a29f595ff17312982b683bf9433c75e9c0ad4b8a370878738aabc58da3997::mxp {
    struct MXP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MXP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MXP>(arg0, 9, b"MXP", b"MAxPro", b"Maximum Professional", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d6b715b2-1a46-4f49-8858-59de01d5fc73.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MXP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MXP>>(v1);
    }

    // decompiled from Move bytecode v6
}

