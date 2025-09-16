module 0xf04d376c31f1604f236542aebf3c7e15cc76d392b4b759872a1801ec2789f9cc::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN>(arg0, 9, b"coinmonster", b"CMON", b"Coin monster creation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1758021616/sui_tokens/avdgalwhiwnkp7avzrtu.webp"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<COIN>>(0x2::coin::mint<COIN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

