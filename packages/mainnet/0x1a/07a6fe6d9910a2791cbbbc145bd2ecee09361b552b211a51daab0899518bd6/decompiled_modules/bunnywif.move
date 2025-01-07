module 0x1a07a6fe6d9910a2791cbbbc145bd2ecee09361b552b211a51daab0899518bd6::bunnywif {
    struct BUNNYWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNNYWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNNYWIF>(arg0, 6, b"BUNNYWIF", b"Bunnywifhat ", b"A bunny with hat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730970620951.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUNNYWIF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNNYWIF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

