module 0x302ca4237f1acfbcb827516ac052806f5478ae66a4aa18f2b10f8bef3e2fabc::great {
    struct GREAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREAT>(arg0, 9, b"GREAT", b"Dr ", b"Bull run", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e933b878-250c-41a1-be25-a2f393ebc1b4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GREAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

