module 0x47807c1724ccef4081c0e823e91cdb403e71bbc0949b4731c97b0061885670a2::astro_coin {
    struct ASTRO_COIN has drop {
        dummy_field: bool,
    }

    struct CoinsBurned has copy, drop {
        burn_amount: u64,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ASTRO_COIN>, arg1: 0x2::coin::Coin<ASTRO_COIN>) : u64 {
        let v0 = 0x2::coin::value<ASTRO_COIN>(&arg1);
        assert!(0x2::coin::total_supply<ASTRO_COIN>(arg0) - v0 >= 500000000000000000, 9223372311732944901);
        let v1 = CoinsBurned{burn_amount: v0};
        0x2::event::emit<CoinsBurned>(v1);
        0x2::coin::burn<ASTRO_COIN>(arg0, arg1)
    }

    public fun total_supply(arg0: &0x2::coin::TreasuryCap<ASTRO_COIN>) : u64 {
        0x2::coin::total_supply<ASTRO_COIN>(arg0)
    }

    fun init(arg0: ASTRO_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASTRO_COIN>(arg0, 8, b"ASTRO", b"Astro Coin", b"To the Moon and beyond!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://astrogenesis.xyz/astro.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASTRO_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASTRO_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ASTRO_COIN>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 9223372238718369795);
        assert!(0x2::coin::total_supply<ASTRO_COIN>(arg0) + arg2 <= 1000000000000000000, 9223372247308173313);
        0x2::coin::mint_and_transfer<ASTRO_COIN>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

