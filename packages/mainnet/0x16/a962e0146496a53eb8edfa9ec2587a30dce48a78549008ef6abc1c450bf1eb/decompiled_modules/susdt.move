module 0x16a962e0146496a53eb8edfa9ec2587a30dce48a78549008ef6abc1c450bf1eb::susdt {
    struct SUSDT has drop {
        dummy_field: bool,
    }

    struct UsdcTreasury<phantom T0> has store, key {
        id: 0x2::object::UID,
        usdc_amount: 0x2::balance::Balance<T0>,
    }

    public fun mint<T0>(arg0: &mut UsdcTreasury<T0>, arg1: &mut 0x2::coin::TreasuryCap<SUSDT>, arg2: 0x2::coin::Coin<T0>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUSDT>>(0x2::coin::mint<SUSDT>(arg1, 0x2::balance::join<T0>(&mut arg0.usdc_amount, 0x2::coin::into_balance<T0>(arg2)), arg4), arg3);
    }

    fun init(arg0: SUSDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSDT>(arg0, 6, b"SUSDT", b"SUSDT", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUSDT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSDT>>(v0, @0xa5241d2ebbc9e93d5a9041dde288a6bfc46fccaf1c15ad0b85fd80806010e4c6);
    }

    public fun withdrawUSDC<T0>(arg0: &mut UsdcTreasury<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0xa5241d2ebbc9e93d5a9041dde288a6bfc46fccaf1c15ad0b85fd80806010e4c6, 100);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.usdc_amount, arg2), arg3), arg1);
    }

    // decompiled from Move bytecode v6
}

