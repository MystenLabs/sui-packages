module 0xa0db5276c7b7f0f3ce9a0a39b24b4177eb40d034fb9a80258a2548fd217269fd::burn_dog {
    struct BURN_DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURN_DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURN_DOG>(arg0, 9, b"Bdog", b"BurnDog", b"BurnDog Live Now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775667643827-9592ed2cdcc83a085965b626c525d2c9.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BURN_DOG>>(0x2::coin::mint<BURN_DOG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BURN_DOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURN_DOG>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

