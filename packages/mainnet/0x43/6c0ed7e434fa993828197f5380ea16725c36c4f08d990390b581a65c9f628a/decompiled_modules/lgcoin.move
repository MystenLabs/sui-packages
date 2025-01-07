module 0x436c0ed7e434fa993828197f5380ea16725c36c4f08d990390b581a65c9f628a::lgcoin {
    struct LGCOIN has drop {
        dummy_field: bool,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<LGCOIN>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun mint(arg0: &AdminCap, arg1: &mut Treasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LGCOIN> {
        0x2::coin::mint<LGCOIN>(&mut arg1.cap, arg2, arg3)
    }

    fun init(arg0: LGCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LGCOIN>(arg0, 9, b"LGCOIN", b"Lugon Token", b"Testing purpose", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = Treasury{
            id  : 0x2::object::new(arg1),
            cap : v0,
        };
        0x2::transfer::share_object<Treasury>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LGCOIN>>(v1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

