module 0x7e66cd63548c8bb16573935f0d460539cd6510c73f406ee362c6a86da819e48::km {
    struct KM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KM>(arg0, 6, b"KM", b"KEKIUS MAXIMUS  by SuiAI", b"KEKIUS MAXIMUS IN THE SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Untitled_design_ba2807b114.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KM>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KM>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

