module 0x37f27d5747d56d45257b2d404bb294107c8c6f448a4629a2995bde4b60b2362c::suipreme {
    struct SUIPREME has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIPREME>, arg1: 0x2::coin::Coin<SUIPREME>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIPREME>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIPREME>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: SUIPREME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPREME>(arg0, 6, b"Suipreme", b"SUIPREME", b"SUIPREME is a meme token combining the hype of Supreme with the power of SUI. Exclusive, fun, and for the cultureperfect for streetwear and crypto lovers! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FCapture_da_A_cran_2024_09_20_002453_21a988686c.jpg&w=256&q=75")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPREME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPREME>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<SUIPREME>, arg1: 0x2::coin::Coin<SUIPREME>) : u64 {
        0x2::coin::burn<SUIPREME>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<SUIPREME>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SUIPREME> {
        0x2::coin::mint<SUIPREME>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

