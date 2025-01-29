module 0xe0d29e6744c8a2b28b639164d2bce98f771ebb93930510bd9f5d9557da23dc5c::simba {
    struct SIMBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMBA>(arg0, 6, b"SIMBA", b"Simba On Sui", b"This is a community based token - so it only works if the entire community engages in the liquidity pool - no whales will come in if they're nervous someone will just sell on them. There needs to be liquidity provided. And this only works if everyone contributes. Doesn't matter if it's 1 SUI or 1000 SUI. Then everyone owns a piece of it. People trade off of what YOU provide. Turbos then offers you APR % interest based off what you decided to contribute. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250129_203319_740_74f9a24ffc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

