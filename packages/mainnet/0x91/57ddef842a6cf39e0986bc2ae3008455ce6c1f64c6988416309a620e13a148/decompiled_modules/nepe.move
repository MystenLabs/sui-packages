module 0x9157ddef842a6cf39e0986bc2ae3008455ce6c1f64c6988416309a620e13a148::nepe {
    struct NEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEPE>(arg0, 6, b"NEPE", b"NEPE PEPE SUI", b"First Nepe Pepe on Sui: https://nepesui.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_3_6_aa64b1abc3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

