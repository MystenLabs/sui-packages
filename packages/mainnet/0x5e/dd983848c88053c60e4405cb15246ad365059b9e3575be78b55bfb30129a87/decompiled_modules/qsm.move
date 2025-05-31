module 0x5edd983848c88053c60e4405cb15246ad365059b9e3575be78b55bfb30129a87::qsm {
    struct QSM has drop {
        dummy_field: bool,
    }

    fun init(arg0: QSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QSM>(arg0, 6, b"QSM", b"QuaSuiModo", b"Quasuimodo is the wildest new memecoin on Sui. Picture a deformed bell-ringer mascot, zero presale, zero team bags100% fair launch.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_16_f2db77522e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QSM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QSM>>(v1);
    }

    // decompiled from Move bytecode v6
}

