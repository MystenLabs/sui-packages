module 0x5eb32e85d924358f4d7db2b5c11b82a957ca390e91001fb1cd3ab18cd0c00ab5::guppy {
    struct GUPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUPPY>(arg0, 6, b"GUPPY", b"GUPPY", b"The cool GUPPY meme on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://guppy.cool/images/guppy.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUPPY>>(v1);
        0x2::coin::mint_and_transfer<GUPPY>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUPPY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

