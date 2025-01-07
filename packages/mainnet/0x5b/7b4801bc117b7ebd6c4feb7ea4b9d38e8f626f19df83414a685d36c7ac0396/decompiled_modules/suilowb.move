module 0x5b7b4801bc117b7ebd6c4feb7ea4b9d38e8f626f19df83414a685d36c7ac0396::suilowb {
    struct SUILOWB has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUILOWB>, arg1: 0x2::coin::Coin<SUILOWB>) {
        0x2::coin::burn<SUILOWB>(arg0, arg1);
    }

    fun init(arg0: SUILOWB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILOWB>(arg0, 2, b"SUILOWB", b"SUILOWB", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://losercoin.org/img/light.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUILOWB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILOWB>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUILOWB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUILOWB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

