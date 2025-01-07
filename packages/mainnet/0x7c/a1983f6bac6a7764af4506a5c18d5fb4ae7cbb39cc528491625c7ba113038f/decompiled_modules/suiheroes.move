module 0x7ca1983f6bac6a7764af4506a5c18d5fb4ae7cbb39cc528491625c7ba113038f::suiheroes {
    struct SUIHEROES has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIHEROES>, arg1: 0x2::coin::Coin<SUIHEROES>) {
        0x2::coin::burn<SUIHEROES>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIHEROES>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIHEROES>(arg0, arg1, arg2, arg3);
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SUIHEROES>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIHEROES>>(arg0, arg1);
    }

    fun init(arg0: SUIHEROES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHEROES>(arg0, 9, b"SHS", b"Suiheroes", b"Suiheroes project utility tokens. It will be used in the further games", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIHEROES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIHEROES>>(0x2::coin::mint<SUIHEROES>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHEROES>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

