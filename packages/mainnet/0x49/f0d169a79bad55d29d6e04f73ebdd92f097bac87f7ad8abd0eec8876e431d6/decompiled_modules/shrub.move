module 0x49f0d169a79bad55d29d6e04f73ebdd92f097bac87f7ad8abd0eec8876e431d6::shrub {
    struct SHRUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRUB>(arg0, 6, b"SHRUB", b"Shrub Elons Pets", b"Shrub - Elons Pets", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6472_085c00741f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHRUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

