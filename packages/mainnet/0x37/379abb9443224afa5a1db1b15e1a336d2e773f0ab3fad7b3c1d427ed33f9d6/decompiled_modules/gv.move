module 0x37379abb9443224afa5a1db1b15e1a336d2e773f0ab3fad7b3c1d427ed33f9d6::gv {
    struct GV has drop {
        dummy_field: bool,
    }

    fun init(arg0: GV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GV>(arg0, 9, b"GV", b"FSA", b"DFS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f6ae8fbf-d0f6-42fd-9f22-3e497032514a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GV>>(v1);
    }

    // decompiled from Move bytecode v6
}

