module 0xa11c4717f75523fdf88c0726a18c74781993c81108ba1693da1da3c0a6c90575::cgm {
    struct CGM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CGM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CGM>(arg0, 9, b"CGM", b"C game", b"For posterity and along with the game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0035900c-8183-4d4a-a395-6c69213330af.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CGM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CGM>>(v1);
    }

    // decompiled from Move bytecode v6
}

