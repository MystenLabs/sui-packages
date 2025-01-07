module 0x38a89b1929a28f4c39e583fd3ab3e14c8c28abe4beec38445f5bba5478c61503::SETH {
    struct SETH has drop {
        dummy_field: bool,
    }

    struct SETHStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SETH>,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SETH>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SETH>>(arg0, arg1);
    }

    fun init(arg0: SETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SETH>(arg0, 9, b"SETH", b"SUI ETH", b"SUI ETH Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suifusion.s3.ap-southeast-2.amazonaws.com/SuiETH.png")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SETH>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SETH>>(0x2::coin::from_balance<SETH>(0x2::balance::increase_supply<SETH>(&mut v2, 10000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = SETHStorage{
            id     : 0x2::object::new(arg1),
            supply : v2,
        };
        0x2::transfer::share_object<SETHStorage>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SETH>>(v1);
    }

    public fun total_supply(arg0: &SETHStorage) : u64 {
        0x2::balance::supply_value<SETH>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

