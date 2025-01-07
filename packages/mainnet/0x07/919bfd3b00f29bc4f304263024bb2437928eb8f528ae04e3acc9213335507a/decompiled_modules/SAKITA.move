module 0x7919bfd3b00f29bc4f304263024bb2437928eb8f528ae04e3acc9213335507a::SAKITA {
    struct SAKITA has drop {
        dummy_field: bool,
    }

    struct SAKITAStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SAKITA>,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SAKITA>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SAKITA>>(arg0, arg1);
    }

    fun init(arg0: SAKITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAKITA>(arg0, 9, b"SAKITA", b"SUI AKITA", b"SUI AKITA Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suifusion.s3.ap-southeast-2.amazonaws.com/SuiAkita.png")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SAKITA>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SAKITA>>(0x2::coin::from_balance<SAKITA>(0x2::balance::increase_supply<SAKITA>(&mut v2, 10000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = SAKITAStorage{
            id     : 0x2::object::new(arg1),
            supply : v2,
        };
        0x2::transfer::share_object<SAKITAStorage>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAKITA>>(v1);
    }

    public fun total_supply(arg0: &SAKITAStorage) : u64 {
        0x2::balance::supply_value<SAKITA>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

