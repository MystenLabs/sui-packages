module 0xa2593305ce2ee339fe65d4c149e441e632298f48f98321350314d2ac1b007c04::hikaru {
    struct HIKARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIKARU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HIKARU>(arg0, 6, b"HIKARU", b"Hikaru A16z by SuiAI", b"Your delivery AI Agent..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/RK_Hl7_VP_400x400_d9568ee548_fb1743c2f3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HIKARU>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIKARU>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

