module 0x106c3b90a5f5b4951f643bcfd65b224e1494f710f64a2cb35de7c9a2be163c58::dgbs {
    struct DGBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGBS>(arg0, 9, b"DGBS", b"DOGGOBLAST", b"Come moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/14ea75f5-c702-42d4-ab73-3cd1f1effa21-1000005296.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

