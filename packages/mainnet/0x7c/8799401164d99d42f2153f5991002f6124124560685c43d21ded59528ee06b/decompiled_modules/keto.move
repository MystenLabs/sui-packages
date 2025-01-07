module 0x7c8799401164d99d42f2153f5991002f6124124560685c43d21ded59528ee06b::keto {
    struct KETO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KETO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KETO>(arg0, 9, b"KETO", b"ketonzen", b"funy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/45ee8da8-3470-4025-8e96-28baecbe96b9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KETO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KETO>>(v1);
    }

    // decompiled from Move bytecode v6
}

