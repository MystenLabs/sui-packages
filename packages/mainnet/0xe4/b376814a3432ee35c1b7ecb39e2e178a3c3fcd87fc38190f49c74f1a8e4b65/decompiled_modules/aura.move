module 0xe4b376814a3432ee35c1b7ecb39e2e178a3c3fcd87fc38190f49c74f1a8e4b65::aura {
    struct AURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AURA>(arg0, 6, b"AURA", b"SUI AURA", b"SUI has the AURA now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_39758a8169.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AURA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AURA>>(v1);
    }

    // decompiled from Move bytecode v6
}

