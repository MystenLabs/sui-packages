module 0xff418c761708e18c9e495c16fe837f7fddfcdf22dbb86a04e5e8f1e68dbc2667::spepe {
    struct SPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEPE>(arg0, 9, b"SPEPE", b"SUI PEPE", b"F`irst Off Pepe on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuOzk5MzHrB4gOhrVkr_436IRmlujgQjC2-w&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPEPE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

