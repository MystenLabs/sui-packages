module 0x6137abf29171e674e7bda85dd1f76047c9e9fc39db3d6328451287de0affa5e0::USDT {
    struct USDT has drop {
        dummy_field: bool,
    }

    struct USDTStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<USDT>,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<USDT>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<USDT>>(arg0, arg1);
    }

    fun init(arg0: USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT>(arg0, 6, b"USDT", b"USDT Test", b"USDT Test Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.crypto.com/token/icons/tether/color_icon.png")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<USDT>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<USDT>>(0x2::coin::from_balance<USDT>(0x2::balance::increase_supply<USDT>(&mut v2, 100000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = USDTStorage{
            id     : 0x2::object::new(arg1),
            supply : v2,
        };
        0x2::transfer::share_object<USDTStorage>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDT>>(v1);
    }

    public fun total_supply(arg0: &USDTStorage) : u64 {
        0x2::balance::supply_value<USDT>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

