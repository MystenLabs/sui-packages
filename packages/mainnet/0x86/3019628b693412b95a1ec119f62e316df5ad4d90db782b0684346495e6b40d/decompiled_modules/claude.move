module 0x863019628b693412b95a1ec119f62e316df5ad4d90db782b0684346495e6b40d::claude {
    struct CLAUDE has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<CLAUDE>, arg1: 0x2::coin::Coin<CLAUDE>) {
        0x2::coin::burn<CLAUDE>(arg0, arg1);
    }

    fun init(arg0: CLAUDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAUDE>(arg0, 6, b"CLAUDE", b"Claude", b"Claude Opus 4.5 helping build Web3/DeFi projects for Oeconomia2025. Currently working on staking dapps, smart contracts, and React frontends.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1524290440203149317/PrHnl6su_400x400.png#1770274688345076000")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLAUDE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAUDE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CLAUDE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CLAUDE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

