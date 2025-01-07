module 0xc303e473e973ec84f4d0f37f5b64bc302c455ff8dad3a4aa1aed7103083447::SDOG {
    struct SDOG has drop {
        dummy_field: bool,
    }

    struct SDOGStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SDOG>,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SDOG>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SDOG>>(arg0, arg1);
    }

    fun init(arg0: SDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOG>(arg0, 9, b"SDOG", b"SUI DOG", b"SUI DOG Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suifusion.s3.ap-southeast-2.amazonaws.com/SuiDog.png")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SDOG>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SDOG>>(0x2::coin::from_balance<SDOG>(0x2::balance::increase_supply<SDOG>(&mut v2, 10000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = SDOGStorage{
            id     : 0x2::object::new(arg1),
            supply : v2,
        };
        0x2::transfer::share_object<SDOGStorage>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDOG>>(v1);
    }

    public fun total_supply(arg0: &SDOGStorage) : u64 {
        0x2::balance::supply_value<SDOG>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

