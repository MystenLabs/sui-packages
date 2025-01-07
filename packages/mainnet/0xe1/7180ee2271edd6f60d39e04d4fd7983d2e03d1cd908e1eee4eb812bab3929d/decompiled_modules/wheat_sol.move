module 0xe17180ee2271edd6f60d39e04d4fd7983d2e03d1cd908e1eee4eb812bab3929d::wheat_sol {
    struct WHEAT_SOL has drop {
        dummy_field: bool,
    }

    public fun join(arg0: &mut 0x2::coin::Coin<WHEAT_SOL>, arg1: 0x2::coin::Coin<WHEAT_SOL>) {
        0x2::coin::join<WHEAT_SOL>(arg0, arg1);
    }

    public fun split(arg0: &mut 0x2::coin::Coin<WHEAT_SOL>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<WHEAT_SOL> {
        assert!(balance<WHEAT_SOL>(arg0) >= arg1, 0);
        0x2::coin::split<WHEAT_SOL>(arg0, arg1, arg2)
    }

    public fun balance<T0>(arg0: &0x2::coin::Coin<T0>) : u64 {
        0x2::coin::value<T0>(arg0)
    }

    fun init(arg0: WHEAT_SOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHEAT_SOL>(arg0, 9, b"SWHIT", b"Wheat-Sol", b"Wheat-Sol (SWHIT) is an innovative blockchain-based platform reimagining long-term value storage for the digital age.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/wheat-eco/wheatsol-asset/refs/heads/main/swhit_64x64.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHEAT_SOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHEAT_SOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WHEAT_SOL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WHEAT_SOL>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

