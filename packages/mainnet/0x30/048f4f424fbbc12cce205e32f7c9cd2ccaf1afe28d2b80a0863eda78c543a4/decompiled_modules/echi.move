module 0x30048f4f424fbbc12cce205e32f7c9cd2ccaf1afe28d2b80a0863eda78c543a4::echi {
    struct ECHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECHI>(arg0, 6, b"ECHI", b"Ecchi", b"I know you jorked at me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022459_28fd7e22fd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ECHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

