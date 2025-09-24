module 0x3f1bc647e3494f450ae3cc5eb0420b193271ce1b54eff2a1a6abbbfa61e9b8d6::dirtyharry {
    struct DIRTYHARRY has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DIRTYHARRY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DIRTYHARRY>>(0x2::coin::mint<DIRTYHARRY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DIRTYHARRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIRTYHARRY>(arg0, 9, b"DIRTY HARRY", b"DIRTYHARRY", b"Dirty Harry is a SHLAAAG!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1758735459/sui_tokens/ipasjcg0o9lceqoulvf7.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<DIRTYHARRY>>(0x2::coin::mint<DIRTYHARRY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIRTYHARRY>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DIRTYHARRY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

