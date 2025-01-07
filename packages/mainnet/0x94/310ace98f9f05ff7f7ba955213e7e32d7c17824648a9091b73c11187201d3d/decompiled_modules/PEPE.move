module 0x94310ace98f9f05ff7f7ba955213e7e32d7c17824648a9091b73c11187201d3d::PEPE {
    struct PEPE has drop {
        dummy_field: bool,
    }

    struct Storage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<PEPE>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE>(arg0, 9, b"SPEPE", b"SuiPepe", b"SuiPepe is taking over from the dogs and Sui pepe will be the first bridge that will allow you to transfer your $SUIPEPE with SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://https-pinksale.finance/anhcuatung/epep.png")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<PEPE>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPE>>(0x2::coin::from_balance<PEPE>(0x2::balance::increase_supply<PEPE>(&mut v2, 600000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = Storage{
            id     : 0x2::object::new(arg1),
            supply : v2,
        };
        0x2::transfer::share_object<Storage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPE>>(v1);
    }

    public fun total_supply(arg0: &Storage) : u64 {
        0x2::balance::supply_value<PEPE>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

