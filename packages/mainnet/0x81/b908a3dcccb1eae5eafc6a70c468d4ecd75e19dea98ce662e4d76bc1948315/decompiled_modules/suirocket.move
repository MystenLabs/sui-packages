module 0x81b908a3dcccb1eae5eafc6a70c468d4ecd75e19dea98ce662e4d76bc1948315::suirocket {
    struct SUIROCKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIROCKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIROCKET>(arg0, 9, b"SuiRocket", b"SUIROCKET", b"Rocket to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1760969902/sui_tokens/k5du9sac5j1no5zp1p4d.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIROCKET>>(0x2::coin::mint<SUIROCKET>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIROCKET>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIROCKET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

