module 0xebb9dcf5ad272ff6162f1a0a8e5aed11b0f656dc9f629f444d4bdf5c74be12b6::aaaa {
    struct AAAA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AAAA>, arg1: 0x2::coin::Coin<AAAA>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AAAA>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AAAA>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: AAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAA>(arg0, 6, b"aaaa", b"AAAA", b"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dkpo6c3me/image/upload/v1728223109/haha_rwvjlz.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAAA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAA>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<AAAA>, arg1: 0x2::coin::Coin<AAAA>) : u64 {
        0x2::coin::burn<AAAA>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<AAAA>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<AAAA> {
        0x2::coin::mint<AAAA>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

