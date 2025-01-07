module 0xb3cb825d8c61ee9c2ec68ffe9918758a96013d81cc0b7ae4fde9a67529a69208::SFLOKI {
    struct SFLOKI has drop {
        dummy_field: bool,
    }

    struct SFLOKIStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SFLOKI>,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SFLOKI>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SFLOKI>>(arg0, arg1);
    }

    fun init(arg0: SFLOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFLOKI>(arg0, 9, b"SFLOKI", b"SUI FLOKI", b"SUI FLOKI Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suifusion.s3.ap-southeast-2.amazonaws.com/SuiFLOKI.png")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SFLOKI>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SFLOKI>>(0x2::coin::from_balance<SFLOKI>(0x2::balance::increase_supply<SFLOKI>(&mut v2, 10000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = SFLOKIStorage{
            id     : 0x2::object::new(arg1),
            supply : v2,
        };
        0x2::transfer::share_object<SFLOKIStorage>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SFLOKI>>(v1);
    }

    public fun total_supply(arg0: &SFLOKIStorage) : u64 {
        0x2::balance::supply_value<SFLOKI>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

