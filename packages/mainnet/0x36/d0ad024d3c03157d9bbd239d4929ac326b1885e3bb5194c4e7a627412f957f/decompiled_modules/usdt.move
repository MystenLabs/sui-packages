module 0x36d0ad024d3c03157d9bbd239d4929ac326b1885e3bb5194c4e7a627412f957f::usdt {
    struct USDT has drop {
        dummy_field: bool,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<USDT>,
    }

    public fun burn(arg0: &mut Treasury, arg1: 0x2::coin::Coin<USDT>) {
        0x2::coin::burn<USDT>(&mut arg0.cap, arg1);
    }

    public fun mint(arg0: &mut Treasury, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<USDT>>(0x2::coin::mint<USDT>(&mut arg0.cap, arg1, arg3), arg2);
    }

    public fun total_supply(arg0: &Treasury) : u64 {
        0x2::coin::total_supply<USDT>(&arg0.cap)
    }

    fun init(arg0: USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT>(arg0, 6, b"USDT", b"Tether USD", b"Tether USD Stablecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cryptologos.cc/logos/tether-usdt-logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDT>>(v1);
        let v2 = Treasury{
            id  : 0x2::object::new(arg1),
            cap : v0,
        };
        0x2::transfer::share_object<Treasury>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<USDT>>(0x2::coin::mint<USDT>(&mut v2.cap, 10000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

