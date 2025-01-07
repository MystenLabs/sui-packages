module 0x3c3b81f8f44cc924140ec5b443933cadc5e67a4be6520b104d0d99e35a781f1d::suitel69 {
    struct SUITEL69 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITEL69, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITEL69>(arg0, 6, b"SUITEL69", b"SuiantelKorei69", b"69 MMMMM keke, ap I69-4200000XXX CpEEEEu too 6,66Ghz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_2024_10_10_T160842_303_d0d972198f_633b5852ee.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITEL69>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITEL69>>(v1);
    }

    // decompiled from Move bytecode v6
}

