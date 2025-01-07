module 0x2bdf771cbc3f562a573d8314bdcae04a26508b2da82b5f9df4b3bb4ecffd53f8::HEHE {
    struct HEHE has drop {
        dummy_field: bool,
    }

    struct Storage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<HEHE>,
    }

    fun init(arg0: HEHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEHE>(arg0, 9, b"HEHE", b"hehehehe", b"tes mot ti thoi", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::coin::treasury_into_supply<HEHE>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<HEHE>>(0x2::coin::from_balance<HEHE>(0x2::balance::increase_supply<HEHE>(&mut v2, 100000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = Storage{
            id     : 0x2::object::new(arg1),
            supply : v2,
        };
        0x2::transfer::share_object<Storage>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEHE>>(v1);
    }

    public fun total_supply(arg0: &Storage) : u64 {
        0x2::balance::supply_value<HEHE>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

