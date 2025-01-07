module 0xb912465713c77d5fa65accf2db17a4153db12b8042ace024bc8e6e85c47f4e39::SUITROLLFACELAUCNHTOMORROW {
    struct SUITROLLFACELAUCNHTOMORROW has drop {
        dummy_field: bool,
    }

    struct Storage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SUITROLLFACELAUCNHTOMORROW>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: SUITROLLFACELAUCNHTOMORROW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITROLLFACELAUCNHTOMORROW>(arg0, 9, b"t.me/suitroll (https://t.me/suitroll)", b"t.me/suitroll (https://t.me/suitroll)", b"t.me/suitroll (https://t.me/suitroll)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://https-pinksale.finance/anhcuatung/spe.png")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SUITROLLFACELAUCNHTOMORROW>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUITROLLFACELAUCNHTOMORROW>>(0x2::coin::from_balance<SUITROLLFACELAUCNHTOMORROW>(0x2::balance::increase_supply<SUITROLLFACELAUCNHTOMORROW>(&mut v2, 600000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = Storage{
            id     : 0x2::object::new(arg1),
            supply : v2,
        };
        0x2::transfer::share_object<Storage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITROLLFACELAUCNHTOMORROW>>(v1);
    }

    public fun total_supply(arg0: &Storage) : u64 {
        0x2::balance::supply_value<SUITROLLFACELAUCNHTOMORROW>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

