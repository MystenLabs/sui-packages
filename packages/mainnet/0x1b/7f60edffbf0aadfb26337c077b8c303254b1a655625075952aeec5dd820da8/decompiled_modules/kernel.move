module 0x1b7f60edffbf0aadfb26337c077b8c303254b1a655625075952aeec5dd820da8::kernel {
    struct KERNEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: KERNEL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KERNEL>(arg0, 6, b"KERNEL", b"Kernel by SuiAI", b"buy it there", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Designer_2_3b7a6b0402.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KERNEL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KERNEL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

