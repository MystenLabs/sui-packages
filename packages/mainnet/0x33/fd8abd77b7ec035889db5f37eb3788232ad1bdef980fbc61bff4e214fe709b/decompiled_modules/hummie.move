module 0x33fd8abd77b7ec035889db5f37eb3788232ad1bdef980fbc61bff4e214fe709b::hummie {
    struct HUMMIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUMMIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUMMIE>(arg0, 6, b"HUMMIE", b"Hummie Sui", x"48554d4d49453a204d6f7265205468616e206120436f696e2c204974732061204d6f76656d656e7421200a0a236d656d65636f696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009936_d027a5e7c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUMMIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUMMIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

