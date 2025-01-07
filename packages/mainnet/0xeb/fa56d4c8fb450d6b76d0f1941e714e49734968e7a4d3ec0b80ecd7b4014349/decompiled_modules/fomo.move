module 0xebfa56d4c8fb450d6b76d0f1941e714e49734968e7a4d3ec0b80ecd7b4014349::fomo {
    struct FOMO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FOMO>, arg1: 0x2::coin::Coin<FOMO>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FOMO>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FOMO>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: FOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOMO>(arg0, 6, b"FOMO SUI", b"FOMO", b"$FOMO Coin is a playful and energetic memecoin designed to tap into the , Fear of Missing Out. #SUI  https://x.com/fomoonsui  https://t.me/fomosui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aquamarine-magnetic-ptarmigan-262.mypinata.cloud/ipfs/QmTEYjwEpENYDYRiN5FBF3Bp8j2vZ3EY7vjVfhLtWsZmjX")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOMO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMO>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<FOMO>, arg1: 0x2::coin::Coin<FOMO>) : u64 {
        0x2::coin::burn<FOMO>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<FOMO>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<FOMO> {
        0x2::coin::mint<FOMO>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

