module 0x9545bc3bbd78a8a699203732817501435278723e2843a5f335844d8dc133ba63::ariel {
    struct ARIEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARIEL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ARIEL>(arg0, 6, b"ARIEL", b"Siren Of Sui by SuiAI", b"Ariel is an AI-powered siren on the Sui Network, captivating audiences with haunting songs, stunning visuals, and interactive, community-driven experiences. Dare to listen?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/PFP_5f226d9c6d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ARIEL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARIEL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

