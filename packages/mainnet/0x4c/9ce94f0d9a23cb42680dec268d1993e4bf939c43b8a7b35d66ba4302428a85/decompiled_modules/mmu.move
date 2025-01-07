module 0x4c9ce94f0d9a23cb42680dec268d1993e4bf939c43b8a7b35d66ba4302428a85::mmu {
    struct MMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMU>(arg0, 9, b"MMU", b"mouse", b"busy collector", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/53c4ff5e-2007-4710-97de-c746afd82125.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

