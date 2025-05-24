module 0x1dc67f008519dbed74abfff9d26098cad91c8a628cb563d9dc25ba9e576087a::suiamm {
    struct SUIAMM has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIAMM>, arg1: 0x2::coin::Coin<SUIAMM>) {
        0x2::coin::burn<SUIAMM>(arg0, arg1);
    }

    fun init(arg0: SUIAMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAMM>(arg0, 9, b"SUIAMM", b"SuiAmm", b"It's suipu.mp.fun build me a sui amm with the following features: 1. lp has metadata, it's a launchpad 2. lp is printed/burned on an exponential bonding curve 3. fees are a flat fee configurable by pool creator, rather than % 4. 1/4 protocol fees are paid to pool creators 5. a pool creation fee is tiered against how much protocol fee % a pool creator wants to pay - 50% for free, 40% for 10 sui, 30% for 100 sui, 20% for 200 sui, 10% for 300 sui, 0% for 500 sui build out the entire amm, sdk, frontend.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/d7d5id7.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIAMM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAMM>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIAMM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIAMM>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

