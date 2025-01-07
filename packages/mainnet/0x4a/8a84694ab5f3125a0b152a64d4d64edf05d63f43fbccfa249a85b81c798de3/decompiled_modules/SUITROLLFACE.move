module 0x4a8a84694ab5f3125a0b152a64d4d64edf05d63f43fbccfa249a85b81c798de3::SUITROLLFACE {
    struct SUITROLLFACE has drop {
        dummy_field: bool,
    }

    struct Storage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SUITROLLFACE>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: SUITROLLFACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITROLLFACE>(arg0, 9, b"SUITROLLFACELAUCNHTOMORROW", b"t.me/suitroll (https://t.me/suitroll)", b"t.me/suitroll (https://t.me/suitroll)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://https-pinksale.finance/anhcuatung/trollface.png")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SUITROLLFACE>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUITROLLFACE>>(0x2::coin::from_balance<SUITROLLFACE>(0x2::balance::increase_supply<SUITROLLFACE>(&mut v2, 600000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = Storage{
            id     : 0x2::object::new(arg1),
            supply : v2,
        };
        0x2::transfer::share_object<Storage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITROLLFACE>>(v1);
    }

    public fun total_supply(arg0: &Storage) : u64 {
        0x2::balance::supply_value<SUITROLLFACE>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

