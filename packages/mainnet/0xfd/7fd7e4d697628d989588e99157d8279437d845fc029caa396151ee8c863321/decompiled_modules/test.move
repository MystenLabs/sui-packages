module 0xfd7fd7e4d697628d989588e99157d8279437d845fc029caa396151ee8c863321::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<TEST>,
    }

    public fun burn(arg0: &mut Treasury, arg1: 0x2::coin::Coin<TEST>) {
        0x2::coin::burn<TEST>(&mut arg0.cap, arg1);
    }

    public fun total_supply(arg0: &Treasury) : u64 {
        0x2::coin::total_supply<TEST>(&arg0.cap)
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 9, b"Test", b"Test", b"Test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST>>(v1);
        let v3 = Treasury{
            id  : 0x2::object::new(arg1),
            cap : v2,
        };
        0x2::transfer::share_object<Treasury>(v3);
    }

    // decompiled from Move bytecode v6
}

