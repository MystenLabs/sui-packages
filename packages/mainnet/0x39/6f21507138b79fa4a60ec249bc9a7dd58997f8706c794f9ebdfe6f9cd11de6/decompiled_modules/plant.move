module 0x396f21507138b79fa4a60ec249bc9a7dd58997f8706c794f9ebdfe6f9cd11de6::plant {
    struct PLANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLANT>(arg0, 6, b"PLANT", b"PLANT SUI", b"$PLANT  Need Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/123_b376bcd8a4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLANT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

