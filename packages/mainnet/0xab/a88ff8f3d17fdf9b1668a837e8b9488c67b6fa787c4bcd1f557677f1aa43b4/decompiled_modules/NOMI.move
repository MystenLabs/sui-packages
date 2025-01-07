module 0xaba88ff8f3d17fdf9b1668a837e8b9488c67b6fa787c4bcd1f557677f1aa43b4::NOMI {
    struct NOMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOMI>(arg0, 6, b"NOMI", b"sui sui no mi", b"The Sui Sui no Mi is a Paramecia-type Devil Fruit that allows the user to swim in the ground or walls, making the user a Free-Swimming Human", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmWNRAf6kE7ukG6TwBj6aTd49s7pgyYVtpFv2g6ssxgpax")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOMI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOMI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

