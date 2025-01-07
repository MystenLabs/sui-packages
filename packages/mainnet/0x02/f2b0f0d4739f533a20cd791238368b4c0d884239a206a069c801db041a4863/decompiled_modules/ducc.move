module 0x2f2b0f0d4739f533a20cd791238368b4c0d884239a206a069c801db041a4863::ducc {
    struct DUCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCC>(arg0, 6, b"DUCC", b"Sui Ducc", b"QUACK QUACK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bebek_85c3724697.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCC>>(v1);
    }

    // decompiled from Move bytecode v6
}

