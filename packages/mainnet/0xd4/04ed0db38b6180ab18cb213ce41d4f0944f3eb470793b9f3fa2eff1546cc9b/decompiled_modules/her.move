module 0xd404ed0db38b6180ab18cb213ce41d4f0944f3eb470793b9f3fa2eff1546cc9b::her {
    struct HER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HER>(arg0, 6, b"HER", b"Herakles", b"olimp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/t_672cecb233.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HER>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HER>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

