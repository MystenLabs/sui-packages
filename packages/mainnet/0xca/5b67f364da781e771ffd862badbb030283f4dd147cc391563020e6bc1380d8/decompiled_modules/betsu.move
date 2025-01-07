module 0xca5b67f364da781e771ffd862badbb030283f4dd147cc391563020e6bc1380d8::betsu {
    struct BETSU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BETSU>, arg1: 0x2::coin::Coin<BETSU>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BETSU>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BETSU>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: BETSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BETSU>(arg0, 6, b"BABYSUI", x"f09f91b642414259535549", x"f09f91b62023537569206e6f2061697264726f702c20426162795355492077696c6c2061697264726f702e2057652077696c6c206d616b652074686520626967676573742061697264726f7020657665722e204c6574e2809973206d616b65206d656d65636f696e20677265617420616761696e2e202068747470733a2f2f626162797375692e696f2f202068747470733a2f2f782e636f6d2f426162795355495f4f66666963616c202068747470733a2f2f742e6d652f426162795355495f5447", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmTDA7rsmLT15UZ83YWigfogydZnNBguXxrVMG6ZQuoTus")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BETSU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BETSU>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<BETSU>, arg1: 0x2::coin::Coin<BETSU>) : u64 {
        0x2::coin::burn<BETSU>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<BETSU>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BETSU> {
        0x2::coin::mint<BETSU>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

