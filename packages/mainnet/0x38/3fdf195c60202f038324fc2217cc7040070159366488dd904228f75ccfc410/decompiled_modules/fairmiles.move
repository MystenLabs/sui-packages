module 0x383fdf195c60202f038324fc2217cc7040070159366488dd904228f75ccfc410::fairmiles {
    struct FAIRMILES has drop {
        dummy_field: bool,
    }

    struct Authority has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    public fun mint(arg0: &Authority, arg1: &mut 0x2::coin::TreasuryCap<FAIRMILES>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<FAIRMILES>>(0x2::coin::mint<FAIRMILES>(arg1, arg2, arg4), arg3);
    }

    fun init(arg0: FAIRMILES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAIRMILES>(arg0, 6, b"Fairmiles", b"FAIM", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAIRMILES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAIRMILES>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = Authority{
            id    : 0x2::object::new(arg1),
            admin : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_transfer<Authority>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

