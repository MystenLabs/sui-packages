module 0x423e2a858d268a178f75f7afd1c0f844d9ac4c6883e16cf506c02419b5fdcf45::sharke {
    struct SHARKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKE>(arg0, 6, b"SHARKE", b"Sharke", b"Sharke is a, JEETNIVOROUS. Big fish with a deep stomach.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_eef3c9547a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

