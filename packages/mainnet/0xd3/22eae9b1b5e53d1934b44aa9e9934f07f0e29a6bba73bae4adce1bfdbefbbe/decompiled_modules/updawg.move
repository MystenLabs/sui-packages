module 0xd322eae9b1b5e53d1934b44aa9e9934f07f0e29a6bba73bae4adce1bfdbefbbe::updawg {
    struct UPDAWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPDAWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPDAWG>(arg0, 9, b"UPDAWG", b"UPDAWG", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1761575892/sui_tokens/tryoqsbq8nvvhazgh0f6.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<UPDAWG>>(0x2::coin::mint<UPDAWG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<UPDAWG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UPDAWG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

