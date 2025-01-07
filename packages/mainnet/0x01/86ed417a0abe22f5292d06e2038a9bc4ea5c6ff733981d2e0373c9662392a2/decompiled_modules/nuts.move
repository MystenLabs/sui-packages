module 0x186ed417a0abe22f5292d06e2038a9bc4ea5c6ff733981d2e0373c9662392a2::nuts {
    struct NUTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUTS>(arg0, 6, b"NUTS", x"53414e4459f09f90bfefb88ff09fa59c", b"An experiment, can squirrels survive under water?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734113755321.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NUTS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUTS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

