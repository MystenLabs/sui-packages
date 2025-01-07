module 0xd4ddb0eff7f74ad449ec4effec397182c6764dcf1bc4c2e96940a43fd7344e9d::coolx {
    struct COOLX has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOLX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOLX>(arg0, 9, b"COOLX", b"Cool", b"Cool Elon musk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b25339f2-3952-4e67-b0a0-bf3e5f72af3a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOLX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COOLX>>(v1);
    }

    // decompiled from Move bytecode v6
}

