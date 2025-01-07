module 0x88edea487b0775211561096213addfd88ae7e0c8b870844f012ecad5fafa2e0f::trust {
    struct TRUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUST>(arg0, 9, b"TRUST", b"Dodo", b"Trust dodo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/01251f79-ba25-465b-9e43-9ffeb9cfd730.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUST>>(v1);
    }

    // decompiled from Move bytecode v6
}

