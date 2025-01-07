module 0xeb7a52ef523ec5099354a1ea4ada501f891323fe4d299085da5c0b7de5218c26::stsui {
    struct STSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<STSUI>, arg1: 0x2::coin::Coin<STSUI>) {
        0x2::coin::burn<STSUI>(arg0, arg1);
    }

    fun init(arg0: STSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<STSUI>(arg0, 9, b"stSUI", b"stSUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STSUI>>(v2);
        let v4 = &mut v3;
        mint(v4, 112000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STSUI>>(v3, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<STSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<STSUI>(arg0, arg1, arg2, arg3);
    }

    public entry fun transfer_ownership(arg0: 0x2::coin::TreasuryCap<STSUI>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STSUI>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

