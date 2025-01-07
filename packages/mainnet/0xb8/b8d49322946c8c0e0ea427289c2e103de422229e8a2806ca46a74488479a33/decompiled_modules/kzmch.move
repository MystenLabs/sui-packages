module 0xb8b8d49322946c8c0e0ea427289c2e103de422229e8a2806ca46a74488479a33::kzmch {
    struct KZMCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: KZMCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KZMCH>(arg0, 9, b"KZMCH", b"Kuzmich", b"Coin for my dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e94350f4-9977-41cd-8763-3df3a28fdd96.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KZMCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KZMCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

