module 0xc3beeceeb9ffdd551b720db641cfe147698ba725cf42e13f16542b5adac65c22::SBIT {
    struct SBIT has drop {
        dummy_field: bool,
    }

    struct SBITStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SBIT>,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SBIT>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SBIT>>(arg0, arg1);
    }

    fun init(arg0: SBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBIT>(arg0, 9, b"SBIT", b"SUI BIT", b"SUI BIT Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suifusion.s3.ap-southeast-2.amazonaws.com/SuiBit.png")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SBIT>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SBIT>>(0x2::coin::from_balance<SBIT>(0x2::balance::increase_supply<SBIT>(&mut v2, 10000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = SBITStorage{
            id     : 0x2::object::new(arg1),
            supply : v2,
        };
        0x2::transfer::share_object<SBITStorage>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBIT>>(v1);
    }

    public fun total_supply(arg0: &SBITStorage) : u64 {
        0x2::balance::supply_value<SBIT>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

