module 0x3d2cc2c03ed4822b53fc4dd071643bff563e74b90cccbd98d2339b27de484214::milkshake {
    struct MILKSHAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILKSHAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILKSHAKE>(arg0, 6, b"MILKSHAKE", b"ALL LIFE IS MILKSHAKE", b"MILKSHAKE IS VERY IMPORTANT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/BiPqXXjDuX3P8iy3zBp7x6SfTZFzxSRDwYc3WE1UeUUr.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MILKSHAKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MILKSHAKE>>(0x2::coin::mint<MILKSHAKE>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MILKSHAKE>>(v2);
    }

    // decompiled from Move bytecode v6
}

