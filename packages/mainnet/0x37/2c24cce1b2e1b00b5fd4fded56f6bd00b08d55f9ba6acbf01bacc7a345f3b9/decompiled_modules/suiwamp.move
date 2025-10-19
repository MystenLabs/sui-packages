module 0x372c24cce1b2e1b00b5fd4fded56f6bd00b08d55f9ba6acbf01bacc7a345f3b9::suiwamp {
    struct SUIWAMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWAMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWAMP>(arg0, 9, b"SUIWAMP", b"SUIWAMP", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1760905265/sui_tokens/n8cifn5ngdilko7at1dr.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIWAMP>>(0x2::coin::mint<SUIWAMP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIWAMP>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIWAMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

