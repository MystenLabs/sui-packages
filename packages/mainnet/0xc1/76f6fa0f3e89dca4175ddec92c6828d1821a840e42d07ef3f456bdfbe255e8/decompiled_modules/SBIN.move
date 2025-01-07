module 0xc176f6fa0f3e89dca4175ddec92c6828d1821a840e42d07ef3f456bdfbe255e8::SBIN {
    struct SBIN has drop {
        dummy_field: bool,
    }

    struct SBINStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SBIN>,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SBIN>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SBIN>>(arg0, arg1);
    }

    fun init(arg0: SBIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBIN>(arg0, 9, b"SBIN", b"SUI BIN", b"SUI BIN Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suifusion.s3.ap-southeast-2.amazonaws.com/SUIBIN.png")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SBIN>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SBIN>>(0x2::coin::from_balance<SBIN>(0x2::balance::increase_supply<SBIN>(&mut v2, 10000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = SBINStorage{
            id     : 0x2::object::new(arg1),
            supply : v2,
        };
        0x2::transfer::share_object<SBINStorage>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBIN>>(v1);
    }

    public fun total_supply(arg0: &SBINStorage) : u64 {
        0x2::balance::supply_value<SBIN>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

