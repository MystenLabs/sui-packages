module 0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK {
    struct HK has drop {
        dummy_field: bool,
    }

    struct TreasuryCapHolder has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<HK>,
    }

    entry fun mint(arg0: &mut TreasuryCapHolder, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HK>>(0x2::coin::mint<HK>(&mut arg0.treasury_cap, arg1, arg3), arg2);
    }

    fun init(arg0: HK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HK>(arg0, 9, b"HK", b"HK", b"HK", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HK>>(v1);
        let v2 = TreasuryCapHolder{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::share_object<TreasuryCapHolder>(v2);
    }

    entry fun transfer_coins(arg0: &mut 0x2::coin::Coin<HK>, arg1: u64, arg2: &mut 0x2::coin::Coin<HK>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<HK>(0x2::coin::balance_mut<HK>(arg2), 0x2::coin::take<HK>(0x2::coin::balance_mut<HK>(arg0), arg1, arg3));
    }

    // decompiled from Move bytecode v6
}

