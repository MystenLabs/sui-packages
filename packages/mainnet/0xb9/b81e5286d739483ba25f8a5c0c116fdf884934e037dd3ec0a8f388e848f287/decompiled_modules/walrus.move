module 0xb9b81e5286d739483ba25f8a5c0c116fdf884934e037dd3ec0a8f388e848f287::walrus {
    struct WALRUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALRUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WALRUS>(arg0, 6, b"WALRUS", b"SuiAi Walrus by SuiAI", b"This agent has yet to discover it's limits and possibilities", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Albedo_Base_XL_Imagine_sentient_creature_that_looks_like_a_mix_2_7293b7b134.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WALRUS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALRUS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

