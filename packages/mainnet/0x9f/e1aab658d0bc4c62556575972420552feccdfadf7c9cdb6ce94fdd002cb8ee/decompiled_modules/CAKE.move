module 0x9fe1aab658d0bc4c62556575972420552feccdfadf7c9cdb6ce94fdd002cb8ee::CAKE {
    struct CAKE has drop {
        dummy_field: bool,
    }

    struct Storage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<CAKE>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: CAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAKE>(arg0, 9, b"SCAKE", b"SuiCAKE", b"New sui meme coin will go to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://https-pinksale.finance/anhcuatung/cake.png")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<CAKE>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<CAKE>>(0x2::coin::from_balance<CAKE>(0x2::balance::increase_supply<CAKE>(&mut v2, 600000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = Storage{
            id     : 0x2::object::new(arg1),
            supply : v2,
        };
        0x2::transfer::share_object<Storage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAKE>>(v1);
    }

    public fun total_supply(arg0: &Storage) : u64 {
        0x2::balance::supply_value<CAKE>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

