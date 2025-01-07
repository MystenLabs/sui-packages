module 0x7032b4e650cf752ecc5acb6820f13d874b4548ceb34182243b3cc9075beab705::CLOWNPEPE {
    struct CLOWNPEPE has drop {
        dummy_field: bool,
    }

    struct Storage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<CLOWNPEPE>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: CLOWNPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOWNPEPE>(arg0, 9, b"$CPepe", b"ClownPepe", b" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://https-pinksale.finance/anhcuatung/clo.png")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<CLOWNPEPE>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<CLOWNPEPE>>(0x2::coin::from_balance<CLOWNPEPE>(0x2::balance::increase_supply<CLOWNPEPE>(&mut v2, 600000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = Storage{
            id     : 0x2::object::new(arg1),
            supply : v2,
        };
        0x2::transfer::share_object<Storage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLOWNPEPE>>(v1);
    }

    public fun total_supply(arg0: &Storage) : u64 {
        0x2::balance::supply_value<CLOWNPEPE>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

