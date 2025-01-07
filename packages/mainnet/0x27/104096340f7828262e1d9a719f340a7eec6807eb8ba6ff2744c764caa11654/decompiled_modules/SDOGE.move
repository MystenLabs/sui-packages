module 0x27104096340f7828262e1d9a719f340a7eec6807eb8ba6ff2744c764caa11654::SDOGE {
    struct SDOGE has drop {
        dummy_field: bool,
    }

    struct SDOGEStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SDOGE>,
    }

    struct SDOGEAdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SDOGE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SDOGE>>(arg0, arg1);
    }

    public fun burn(arg0: &mut SDOGEStorage, arg1: 0x2::coin::Coin<SDOGE>) : u64 {
        0x2::balance::decrease_supply<SDOGE>(&mut arg0.supply, 0x2::coin::into_balance<SDOGE>(arg1))
    }

    fun init(arg0: SDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOGE>(arg0, 9, b"SDOGE", b"SUIDOGE Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/Qmc4rzRTCGZiZkTKtA1hZMd9LG6eK2wTTMjo5ZFh6QiJma")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SDOGE>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SDOGE>>(0x2::coin::from_balance<SDOGE>(0x2::balance::increase_supply<SDOGE>(&mut v2, 1000000000000000000), arg1), @0xde8027e78b89b87a4ab8841034a072bb8ba405b0c7fc9bdd0f2fee1b83c7a178);
        let v3 = SDOGEStorage{
            id     : 0x2::object::new(arg1),
            supply : v2,
        };
        0x2::transfer::share_object<SDOGEStorage>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDOGE>>(v1);
    }

    public fun total_supply(arg0: &SDOGEStorage) : u64 {
        0x2::balance::supply_value<SDOGE>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

