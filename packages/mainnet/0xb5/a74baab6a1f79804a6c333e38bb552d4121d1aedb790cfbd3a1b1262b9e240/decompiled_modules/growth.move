module 0xb5a74baab6a1f79804a6c333e38bb552d4121d1aedb790cfbd3a1b1262b9e240::growth {
    struct GROWTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROWTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROWTH>(arg0, 9, b"GROWTH", b"Growth", b"Lets growth together with GROWTH Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b8f6d6eb-1887-45ce-9e55-1c3a4aa620b4-images (1).png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROWTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GROWTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

