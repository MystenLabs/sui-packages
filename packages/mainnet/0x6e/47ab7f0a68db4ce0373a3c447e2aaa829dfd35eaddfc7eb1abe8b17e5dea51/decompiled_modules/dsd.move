module 0x6e47ab7f0a68db4ce0373a3c447e2aaa829dfd35eaddfc7eb1abe8b17e5dea51::dsd {
    struct DSD has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DSD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DSD>>(0x2::coin::mint<DSD>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSD>(arg0, 1, b"DSD", b"sd", b"sds", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DSD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<DSD>>(0x2::coin::mint<DSD>(&mut v2, 0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

