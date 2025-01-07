module 0x3e441e6c2e1ad28709577e5a1cc441e5ce2c0c6b0c7b35ce8d365c60f01163b8::ZORO {
    struct ZORO has drop {
        dummy_field: bool,
    }

    struct Storage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<ZORO>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: ZORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZORO>(arg0, 9, b"$SZORO", b"SuiZoro", b"NO TELEGRAM , NO TWITTER , NO FOMO , Just meme coin for everyone ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://https-pinksale.finance/anhcuatung/zoro.png")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<ZORO>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<ZORO>>(0x2::coin::from_balance<ZORO>(0x2::balance::increase_supply<ZORO>(&mut v2, 600000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = Storage{
            id     : 0x2::object::new(arg1),
            supply : v2,
        };
        0x2::transfer::share_object<Storage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZORO>>(v1);
    }

    public fun total_supply(arg0: &Storage) : u64 {
        0x2::balance::supply_value<ZORO>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

