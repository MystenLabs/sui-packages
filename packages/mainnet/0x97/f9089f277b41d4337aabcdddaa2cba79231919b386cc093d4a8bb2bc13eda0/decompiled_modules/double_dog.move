module 0x97f9089f277b41d4337aabcdddaa2cba79231919b386cc093d4a8bb2bc13eda0::double_dog {
    struct DOUBLE_DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOUBLE_DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOUBLE_DOG>(arg0, 9, b"DD", b"Double Dog", b"Double dog good coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775893928752-1bb87d41d15fe27b500a4bfcde01bb0e.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<DOUBLE_DOG>>(0x2::coin::mint<DOUBLE_DOG>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOUBLE_DOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOUBLE_DOG>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

