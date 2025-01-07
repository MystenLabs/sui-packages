module 0x6d07904b90fbbd6c2a2caa1851c06009ec79cd7e12518cb76503a132cef3f7ae::acw {
    struct ACW has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACW>(arg0, 9, b"ACW", b"ACWILA", b"LOVE TOKEN MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ebb94743-bb40-4e57-9697-b8454d1a917f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACW>>(v1);
    }

    // decompiled from Move bytecode v6
}

