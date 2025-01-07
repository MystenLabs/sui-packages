module 0x4328baaba8940aa2128a4e26b5f3da7eb94c6988399270bebb8b914c4926755::pepesad {
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
        let (v0, v1) = 0x2::coin::create_currency<PEPESAD>(arg0, 6, b"PEPESAD", b"PepeSAD", b"https://belaunchio.infura-ipfs.io/ipfs/QmdxjA6E1W8GGDQDjejRD3dQbeQ7kGgKTo4wASQJUvd1Ra  https://www.pepesad.fun/  https://x.com/pepesadsui   https://t.me/pepesadportal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmU1L6zxptpFZJSvfGyyRhQtjiuPN4cXZi1UycCtq4cFbx")), arg1);
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

