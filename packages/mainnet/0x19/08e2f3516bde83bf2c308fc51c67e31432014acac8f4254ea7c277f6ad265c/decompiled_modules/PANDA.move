module 0x1908e2f3516bde83bf2c308fc51c67e31432014acac8f4254ea7c277f6ad265c::PANDA {
    struct PANDA has drop {
        dummy_field: bool,
    }

    struct Storage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<PANDA>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: PANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANDA>(arg0, 9, b"SPANDA", b"SuiPanda", b"New sui meme coin will go to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://https-pinksale.finance/anhcuatung/panda.png")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<PANDA>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<PANDA>>(0x2::coin::from_balance<PANDA>(0x2::balance::increase_supply<PANDA>(&mut v2, 600000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = Storage{
            id     : 0x2::object::new(arg1),
            supply : v2,
        };
        0x2::transfer::share_object<Storage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PANDA>>(v1);
    }

    public fun total_supply(arg0: &Storage) : u64 {
        0x2::balance::supply_value<PANDA>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

