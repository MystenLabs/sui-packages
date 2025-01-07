module 0xca71d64239fd34e452b7af0a88ba6e641bdd83c78d2d800cb68f8604f67b3e0::fsd {
    struct FSD has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FSD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FSD>>(0x2::coin::mint<FSD>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSD>(arg0, 6, b"FSD", b"fds", b"e12", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FSD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<FSD>>(0x2::coin::mint<FSD>(&mut v2, 0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

