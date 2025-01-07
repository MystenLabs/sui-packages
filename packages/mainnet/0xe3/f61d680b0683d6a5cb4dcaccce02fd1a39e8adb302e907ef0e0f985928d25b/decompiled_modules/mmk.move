module 0xe3f61d680b0683d6a5cb4dcaccce02fd1a39e8adb302e907ef0e0f985928d25b::mmk {
    struct MMK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMK>(arg0, 9, b"MMK", b"Afa iyah", b"Buat nuyul aja", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3cb1905a-1538-4cff-91cd-cf649851e341.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMK>>(v1);
    }

    // decompiled from Move bytecode v6
}

