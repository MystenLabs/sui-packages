module 0xce883c10f75761ebeaee5c727e622cabfabc80dea626a104aa477e5d3197cc88::kisa {
    struct KISA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KISA>, arg1: 0x2::coin::Coin<KISA>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KISA>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KISA>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: KISA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KISA>(arg0, 6, b"KISA ", b"KISA", b"meow ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmNzwotjyUp65xnHySZFA8uXgtUAiQhLZU9E62bmijxh1B")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KISA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KISA>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<KISA>, arg1: 0x2::coin::Coin<KISA>) : u64 {
        0x2::coin::burn<KISA>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<KISA>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<KISA> {
        0x2::coin::mint<KISA>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

