module 0x25ee5fbd0dea6bfbf9e5d8abad2c5d9da09837cfae916e205f44ec8cf985fc5c::cte {
    struct CTE has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CTE>, arg1: 0x2::coin::Coin<CTE>) {
        assert!(true == false, 100);
        0x2::coin::burn<CTE>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CTE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (true == true && 0x2::balance::supply_value<CTE>(0x2::coin::supply<CTE>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<CTE>>(0x2::coin::mint<CTE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTE>(arg0, 6, b"CTE", b"Cat Emperor ", b"Just vibes and dreams ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.arweave.net/tCc8mWWhYFeR-CGwXOfA4_pe7TPIkmxiuF0kd3mPTDs?ext=jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

