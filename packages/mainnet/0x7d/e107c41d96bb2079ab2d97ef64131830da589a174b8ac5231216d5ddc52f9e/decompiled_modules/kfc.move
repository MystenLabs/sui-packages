module 0x7de107c41d96bb2079ab2d97ef64131830da589a174b8ac5231216d5ddc52f9e::kfc {
    struct KFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KFC>(arg0, 9, b"KFC", b"#KFC", b"KFC Corporation, doing business as KFC (also commonly referred to by its historical name Kentucky Fried Chicken), is an American fast food restaurant chain that specializes in fried chicken.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/00bd7352-defd-496b-a837-a396286e8233.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

