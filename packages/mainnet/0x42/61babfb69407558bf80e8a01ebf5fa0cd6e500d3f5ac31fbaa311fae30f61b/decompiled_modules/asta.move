module 0x4261babfb69407558bf80e8a01ebf5fa0cd6e500d3f5ac31fbaa311fae30f61b::asta {
    struct ASTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASTA>(arg0, 9, b"ASTA", b"Astacoin", b"Astalavista baby", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7ed586b9-fc7e-4513-a24c-af606c76096a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

