module 0xacfc1acfe42fbce6b17e129412e79752b348c965f7cd056fea89b80cf9271840::userdeposit {
    struct UsdcTreasury<phantom T0> has store, key {
        id: 0x2::object::UID,
        usdc_amount: 0x2::balance::Balance<T0>,
    }

    struct UsdcFeeTreasury<phantom T0> has store, key {
        id: 0x2::object::UID,
        usdc_amount: 0x2::balance::Balance<T0>,
    }

    public fun depositUSDCAdmin<T0>(arg0: &mut UsdcTreasury<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::tx_context::sender(arg2) == @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2, 100);
        0x2::balance::join<T0>(&mut arg0.usdc_amount, 0x2::coin::into_balance<T0>(arg1))
    }

    public fun depositUSDCUser<T0>(arg0: &mut UsdcTreasury<T0>, arg1: &mut UsdcFeeTreasury<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = v0 * 25 / 10000;
        0x2::balance::join<T0>(&mut arg1.usdc_amount, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v1, arg3)));
        0x2::balance::join<T0>(&mut arg0.usdc_amount, 0x2::coin::into_balance<T0>(arg2));
        v0 - v1
    }

    public fun initializeUsdcAndFeeObject<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2, 100);
        let v0 = UsdcTreasury<T0>{
            id          : 0x2::object::new(arg0),
            usdc_amount : 0x2::balance::zero<T0>(),
        };
        let v1 = UsdcFeeTreasury<T0>{
            id          : 0x2::object::new(arg0),
            usdc_amount : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<UsdcTreasury<T0>>(v0);
        0x2::transfer::share_object<UsdcFeeTreasury<T0>>(v1);
    }

    public fun withdrawFees<T0>(arg0: &mut UsdcFeeTreasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2, 100);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.usdc_amount, arg1), arg2), @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2);
    }

    public fun withdrawUSDC<T0>(arg0: &mut UsdcTreasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2, 100);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.usdc_amount, arg1), arg2), @0xa9705076ed9589b0103a30a50b549eb731e14a903790c68eb983442b8b61bfb2);
    }

    // decompiled from Move bytecode v6
}

