module 0xd3f22ac80e14e3f6acdeefb46e78abea21767f0e61535c104bc25463a7e109db::ASD {
    struct ASD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ASD>, arg1: 0x2::coin::Coin<ASD>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<ASD>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ASD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ASD>>(0x2::coin::mint<ASD>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<ASD>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ASD>>(arg0);
    }

    fun init(arg0: ASD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASD>(arg0, 9, b"asd", b"TEST FINAL", b"CoinDesc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:3000/lotus_logo.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

