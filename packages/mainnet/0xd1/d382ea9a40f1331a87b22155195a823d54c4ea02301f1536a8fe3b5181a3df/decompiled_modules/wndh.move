module 0xd1d382ea9a40f1331a87b22155195a823d54c4ea02301f1536a8fe3b5181a3df::wndh {
    struct WNDH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WNDH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WNDH>(arg0, 9, b"WNDH", b"Windah", b"Windah Basudara", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/42b65c75-4bf3-4cca-a429-feb09232a49d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WNDH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WNDH>>(v1);
    }

    // decompiled from Move bytecode v6
}

