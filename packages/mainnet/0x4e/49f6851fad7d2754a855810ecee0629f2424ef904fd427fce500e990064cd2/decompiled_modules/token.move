module 0x4e49f6851fad7d2754a855810ecee0629f2424ef904fd427fce500e990064cd2::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOKEN>, arg1: 0x2::coin::Coin<TOKEN>) {
        0x2::coin::burn<TOKEN>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOKEN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TOKEN> {
        0x2::coin::mint<TOKEN>(arg0, arg1, arg2)
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 9, b"SEND", b"SEND", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-ezNqd2nf1W.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TOKEN>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v1);
    }

    public entry fun mint_to(arg0: &mut 0x2::coin::TreasuryCap<TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN>>(0x2::coin::mint<TOKEN>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

