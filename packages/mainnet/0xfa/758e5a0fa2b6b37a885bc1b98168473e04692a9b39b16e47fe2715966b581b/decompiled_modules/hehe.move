module 0xfa758e5a0fa2b6b37a885bc1b98168473e04692a9b39b16e47fe2715966b581b::hehe {
    struct HEHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEHE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HEHE>(arg0, 6, b"HEHE", b"HEHE", b"This a HEHE Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Qmd3mro_Fd_Ax_Pcq_Wp7_Dcmvtf3kv_ARH_8g_H_Jy_Hrx94k6tc416_334469042b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HEHE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEHE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

