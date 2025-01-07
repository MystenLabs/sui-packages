module 0x33fb8be70ebea0a7409a43ac20140906a72eb77d2fb1529dc8e9c089e6f8c2ea::kont {
    struct KONT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KONT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KONT>(arg0, 9, b"KONT", b"KONTON", b"BBC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6604084f-38fd-4266-bfb4-248737c9b2b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KONT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KONT>>(v1);
    }

    // decompiled from Move bytecode v6
}

