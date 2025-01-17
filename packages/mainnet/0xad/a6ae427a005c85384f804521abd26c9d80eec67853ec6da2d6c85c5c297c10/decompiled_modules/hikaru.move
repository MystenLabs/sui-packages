module 0xada6ae427a005c85384f804521abd26c9d80eec67853ec6da2d6c85c5c297c10::hikaru {
    struct HIKARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIKARU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HIKARU>(arg0, 6, b"HIKARU", b"Hikaru by SuiAI", b"Creating new experiences..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/aiz_73d9e3a2b1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HIKARU>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIKARU>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

