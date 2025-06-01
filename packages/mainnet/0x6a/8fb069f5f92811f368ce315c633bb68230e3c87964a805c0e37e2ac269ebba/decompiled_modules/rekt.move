module 0x6a8fb069f5f92811f368ce315c633bb68230e3c87964a805c0e37e2ac269ebba::rekt {
    struct REKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: REKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REKT>(arg0, 6, b"REKT", b"Rekt on Sui", b"Only REKT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiblqdt3j25okk3byxhtvwepy7uxyo7l57p7yryjunzbp3hx6a5mum")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REKT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REKT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

