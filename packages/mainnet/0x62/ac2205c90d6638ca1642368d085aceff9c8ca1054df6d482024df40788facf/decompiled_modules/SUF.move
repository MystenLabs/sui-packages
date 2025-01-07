module 0x62ac2205c90d6638ca1642368d085aceff9c8ca1054df6d482024df40788facf::SUF {
    struct SUF has drop {
        dummy_field: bool,
    }

    struct SUFStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SUF>,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SUF>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUF>>(arg0, arg1);
    }

    fun init(arg0: SUF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUF>(arg0, 9, b"SUF", b"Sui Fusion", b"Sui Fusion Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suifusion.s3.ap-southeast-2.amazonaws.com/SUF.png")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SUF>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUF>>(0x2::coin::from_balance<SUF>(0x2::balance::increase_supply<SUF>(&mut v2, 50000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = SUFStorage{
            id     : 0x2::object::new(arg1),
            supply : v2,
        };
        0x2::transfer::share_object<SUFStorage>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUF>>(v1);
    }

    public fun total_supply(arg0: &SUFStorage) : u64 {
        0x2::balance::supply_value<SUF>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

