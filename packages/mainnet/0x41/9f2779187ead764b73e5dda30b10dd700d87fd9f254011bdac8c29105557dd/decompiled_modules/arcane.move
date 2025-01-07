module 0x419f2779187ead764b73e5dda30b10dd700d87fd9f254011bdac8c29105557dd::arcane {
    struct ARCANE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARCANE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARCANE>(arg0, 6, b"ARCANE", b"Arcane", x"415243414e45415243414e45415243414e45415243414e45415243414e45415243414e45415243414e45415243414e4520415243414e45415243414e45415243414e45415243414e45415243414e45415243414e45415243414e45415243414e45200a415243414e45415243414e45415243414e45415243414e45415243414e45415243414e45415243414e45415243414e45200a415243414e45415243414e45415243414e45415243414e45415243414e45415243414e45415243414e45415243414e4520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000035742_18f664b2f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARCANE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARCANE>>(v1);
    }

    // decompiled from Move bytecode v6
}

