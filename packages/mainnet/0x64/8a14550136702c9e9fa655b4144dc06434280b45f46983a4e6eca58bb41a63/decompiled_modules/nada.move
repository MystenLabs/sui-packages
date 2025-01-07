module 0x648a14550136702c9e9fa655b4144dc06434280b45f46983a4e6eca58bb41a63::nada {
    struct NADA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NADA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NADA>(arg0, 6, b"NADA", b"Probably Nothing", b"Probably $NADA...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/k0msiz_TM_400x400_01c31114af.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NADA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NADA>>(v1);
    }

    // decompiled from Move bytecode v6
}

