module 0xc68e58f3da9f2ee7beb497575685d4468984121ba309356561422fa4335ddef0::pepesad {
    struct PEPESAD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PEPESAD>, arg1: 0x2::coin::Coin<PEPESAD>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPESAD>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPESAD>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: PEPESAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPESAD>(arg0, 6, b"PEPESAD", b"PepeSAD", x"f09f92a7f09f92a7526f7574696e65206c69666520676f7420796f7520646f776e3f20476574207269636820616e64207475726e207570207468652066756ef09f92a7f09f92a721202068747470733a2f2f7777772e706570657361642e66756e2f202068747470733a2f2f782e636f6d2f7065706573616473756920202068747470733a2f2f742e6d652f70657065736164706f7274616c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmdxjA6E1W8GGDQDjejRD3dQbeQ7kGgKTo4wASQJUvd1Ra")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPESAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPESAD>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<PEPESAD>, arg1: 0x2::coin::Coin<PEPESAD>) : u64 {
        0x2::coin::burn<PEPESAD>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<PEPESAD>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PEPESAD> {
        0x2::coin::mint<PEPESAD>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

