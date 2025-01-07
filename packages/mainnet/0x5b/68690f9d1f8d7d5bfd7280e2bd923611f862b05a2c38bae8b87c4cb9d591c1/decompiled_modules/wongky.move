module 0x5b68690f9d1f8d7d5bfd7280e2bd923611f862b05a2c38bae8b87c4cb9d591c1::wongky {
    struct WONGKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WONGKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WONGKY>(arg0, 6, b"Wongky", b"Wongkycat", b"Sui live cat pink and community great ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730982665660.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WONGKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WONGKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

