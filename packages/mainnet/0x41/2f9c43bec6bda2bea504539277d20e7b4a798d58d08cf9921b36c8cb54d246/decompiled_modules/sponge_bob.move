module 0x412f9c43bec6bda2bea504539277d20e7b4a798d58d08cf9921b36c8cb54d246::sponge_bob {
    struct SPONGE_BOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPONGE_BOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPONGE_BOB>(arg0, 6, b"SPNG", b"SPONGE BOB", b"Are you ready, kids? https://t.me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://live.staticflickr.com/2010/2110721622_2c15433541_m.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPONGE_BOB>>(v1);
        0x2::coin::mint_and_transfer<SPONGE_BOB>(&mut v2, 1000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPONGE_BOB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

