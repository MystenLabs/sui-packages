module 0xa62fc0b5b8f12d37dbcd6a3991f40216cae37eb999f30df7a72d12c7e100c1bc::SLE {
    struct SLE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SLE>, arg1: 0x2::coin::Coin<SLE>) {
        0x2::coin::burn<SLE>(arg0, arg1);
    }

    fun init(arg0: SLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLE>(arg0, 9, b"SLE", b"Slime Sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/9Whw1MY/slime.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SLE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SLE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

