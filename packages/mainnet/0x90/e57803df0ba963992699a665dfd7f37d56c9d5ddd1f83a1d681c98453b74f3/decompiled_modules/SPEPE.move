module 0x90e57803df0ba963992699a665dfd7f37d56c9d5ddd1f83a1d681c98453b74f3::SPEPE {
    struct SPEPE has drop {
        dummy_field: bool,
    }

    struct SPEPEStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SPEPE>,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SPEPE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SPEPE>>(arg0, arg1);
    }

    fun init(arg0: SPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEPE>(arg0, 9, b"SPEPE", b"SUI PEPE", b"SUI PEPE Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suifusion.s3.ap-southeast-2.amazonaws.com/SuiPEPE.png")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SPEPE>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SPEPE>>(0x2::coin::from_balance<SPEPE>(0x2::balance::increase_supply<SPEPE>(&mut v2, 10000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = SPEPEStorage{
            id     : 0x2::object::new(arg1),
            supply : v2,
        };
        0x2::transfer::share_object<SPEPEStorage>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPEPE>>(v1);
    }

    public fun total_supply(arg0: &SPEPEStorage) : u64 {
        0x2::balance::supply_value<SPEPE>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

