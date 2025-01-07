module 0xd60d5c08ff42328cbee7fb49b5bf1dadd08fb9799b3ddd87a02949257757f9e8::SCAR {
    struct SCAR has drop {
        dummy_field: bool,
    }

    struct SCARStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SCAR>,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SCAR>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SCAR>>(arg0, arg1);
    }

    fun init(arg0: SCAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAR>(arg0, 9, b"SCAR", b"SUI CAR", b"SUI CAR Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suifusion.s3.ap-southeast-2.amazonaws.com/SuiCar.png")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SCAR>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SCAR>>(0x2::coin::from_balance<SCAR>(0x2::balance::increase_supply<SCAR>(&mut v2, 10000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = SCARStorage{
            id     : 0x2::object::new(arg1),
            supply : v2,
        };
        0x2::transfer::share_object<SCARStorage>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCAR>>(v1);
    }

    public fun total_supply(arg0: &SCARStorage) : u64 {
        0x2::balance::supply_value<SCAR>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

