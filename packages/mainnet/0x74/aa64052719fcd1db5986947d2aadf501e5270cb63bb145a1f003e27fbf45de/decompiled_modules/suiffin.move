module 0x74aa64052719fcd1db5986947d2aadf501e5270cb63bb145a1f003e27fbf45de::suiffin {
    struct SUIFFIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFFIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFFIN>(arg0, 6, b"SUIFFIN", b"Sui Griffin", b"Its Peter Griffin... but on Sui!  $SUIFFIN brings his unmistakable humor and offbeat antics to the blockchain. Expect laughs, randomness, and maybe a questionable decision or two!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_058b0b9b01.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFFIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFFIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

