module 0xa004752b531eb83ef7c6f795f94d799a416ee9f84abd2668c86ff33ed2ea1963::TEST1 {
    struct TEST1 has drop {
        dummy_field: bool,
    }

    struct Storage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<TEST1>,
    }

    fun init(arg0: TEST1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST1>(arg0, 9, b"TEST1", b"hehehehe", b"tes mot ti thoi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://https-pinksale.finance/anhcuatung/epep.png")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<TEST1>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST1>>(0x2::coin::from_balance<TEST1>(0x2::balance::increase_supply<TEST1>(&mut v2, 1000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = Storage{
            id     : 0x2::object::new(arg1),
            supply : v2,
        };
        0x2::transfer::share_object<Storage>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST1>>(v1);
    }

    public fun total_supply(arg0: &Storage) : u64 {
        0x2::balance::supply_value<TEST1>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

