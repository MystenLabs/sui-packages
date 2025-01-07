module 0xdf3bf15837f6f5621225dff3576f32a4e8cd192063e72e216c9a43ac8774fbb9::wewcat {
    struct WEWCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWCAT>(arg0, 9, b"WEWCAT", b"WeweCat", b"WeweCat is not just memecoin,its a special memecoin that can pump as you dream in your childhood stories.so hope you will have great time with this chance of pumpation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/46aa0903-54b3-44b8-9af2-5c423caacb60.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

