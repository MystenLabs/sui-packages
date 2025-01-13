module 0x51ecf1f79afd7ec56791d06ac76328bd0b76f3ea402709f1da78f7fc3fddc41f::neiry {
    struct NEIRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NEIRY>(arg0, 6, b"NEIRY", b"Neirylab by SuiAI", b"Bridging neurobiology, AI & future. Licensed under the Animal Ethics Committee Approval Certificate.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/E0_S94neb_400x400_dd988b7894.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NEIRY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

