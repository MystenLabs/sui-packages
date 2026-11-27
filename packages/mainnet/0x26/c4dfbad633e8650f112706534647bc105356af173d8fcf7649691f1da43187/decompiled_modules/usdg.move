module 0x26c4dfbad633e8650f112706534647bc105356af173d8fcf7649691f1da43187::usdg {
    struct USDG has drop {
        dummy_field: bool,
    }

    struct Vault has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: USDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDG>(arg0, 9, b"USDG", b"USDG Global Dollar", b"USDG: 1 USDG = 1 USDC. Fixed supply, no mint authority, immutable metadata.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.klife.world/logos/usdg.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<USDG>>(0x2::coin::mint<USDG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        let v3 = Vault{id: 0x2::object::new(arg1)};
        0x2::dynamic_field::add<vector<u8>, 0x2::balance::Supply<USDG>>(&mut v3.id, b"locked_supply", 0x2::coin::treasury_into_supply<USDG>(v2));
        0x2::transfer::share_object<Vault>(v3);
    }

    // decompiled from Move bytecode v7
}

