module 0x17845e5dae6c2f78695441cb4cc5f96295917f755a68423ec0e69d896d9b1648::suitube {
    struct SUITUBE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUITUBE>, arg1: 0x2::coin::Coin<SUITUBE>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUITUBE>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUITUBE>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: SUITUBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITUBE>(arg0, 6, b"SuiTube", b"TUBE", b"Empowering creators with blockchain technology. Stream, share, and earn in a truly open ecosystem.  https://www.suitube.xyz/  https://x.com/suitube_dev", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2F58_C6_B3_A2_D57_F_4562_A7_BE_C20_BAB_51_FF_89_d4969a6586.jpeg&w=256&q=75")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITUBE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITUBE>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<SUITUBE>, arg1: 0x2::coin::Coin<SUITUBE>) : u64 {
        0x2::coin::burn<SUITUBE>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<SUITUBE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SUITUBE> {
        0x2::coin::mint<SUITUBE>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

