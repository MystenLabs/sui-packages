module 0xf493420f9701130085790357d91fb6a99d0ee5ea838815892220192b2ca81b29::SPEPE {
    struct SPEPE has drop {
        dummy_field: bool,
    }

    struct Storage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SPEPE>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: SPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEPE>(arg0, 9, b"$SPEPE", b"SuiPepe", b"NO TELEGRAM , NO TWITTER , NO FOMO , Just meme coin for everyone ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://https-pinksale.finance/anhcuatung/epep.png")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SPEPE>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SPEPE>>(0x2::coin::from_balance<SPEPE>(0x2::balance::increase_supply<SPEPE>(&mut v2, 600000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = Storage{
            id     : 0x2::object::new(arg1),
            supply : v2,
        };
        0x2::transfer::share_object<Storage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPEPE>>(v1);
    }

    public fun total_supply(arg0: &Storage) : u64 {
        0x2::balance::supply_value<SPEPE>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

