module 0x1a72db4a51d64160144e539f388cfb5d9feddd8576308bc6e9c309695fe80223::SAPT {
    struct SAPT has drop {
        dummy_field: bool,
    }

    struct SAPTStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SAPT>,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SAPT>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SAPT>>(arg0, arg1);
    }

    fun init(arg0: SAPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAPT>(arg0, 9, b"SAPT", b"SUI APT", b"SUI APT Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suifusion.s3.ap-southeast-2.amazonaws.com/SuiAPT.png")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SAPT>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SAPT>>(0x2::coin::from_balance<SAPT>(0x2::balance::increase_supply<SAPT>(&mut v2, 10000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = SAPTStorage{
            id     : 0x2::object::new(arg1),
            supply : v2,
        };
        0x2::transfer::share_object<SAPTStorage>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAPT>>(v1);
    }

    public fun total_supply(arg0: &SAPTStorage) : u64 {
        0x2::balance::supply_value<SAPT>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

