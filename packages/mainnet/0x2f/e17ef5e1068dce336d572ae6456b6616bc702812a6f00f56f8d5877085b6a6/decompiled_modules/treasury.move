module 0x2fe17ef5e1068dce336d572ae6456b6616bc702812a6f00f56f8d5877085b6a6::treasury {
    struct SuiTreasury has key {
        id: 0x2::object::UID,
        sui_amount: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct UsdcTreasury<phantom T0> has key {
        id: 0x2::object::UID,
        usdc_amount: 0x2::balance::Balance<T0>,
    }

    struct WethTreasury<phantom T0> has key {
        id: 0x2::object::UID,
        weth_amount: 0x2::balance::Balance<T0>,
    }

    public fun depositSUI(arg0: &mut SuiTreasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>) : u64 {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_amount, 0x2::coin::into_balance<0x2::sui::SUI>(arg1))
    }

    public fun depositUSDC<T0>(arg0: &mut UsdcTreasury<T0>, arg1: 0x2::coin::Coin<T0>) : u64 {
        0x2::balance::join<T0>(&mut arg0.usdc_amount, 0x2::coin::into_balance<T0>(arg1))
    }

    public fun depositWETH<T0>(arg0: &mut WethTreasury<T0>, arg1: 0x2::coin::Coin<T0>) : u64 {
        0x2::balance::join<T0>(&mut arg0.weth_amount, 0x2::coin::into_balance<T0>(arg1))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SuiTreasury{
            id         : 0x2::object::new(arg0),
            sui_amount : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<SuiTreasury>(v0);
    }

    public fun initializeUsdcObject<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UsdcTreasury<T0>{
            id          : 0x2::object::new(arg0),
            usdc_amount : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<UsdcTreasury<T0>>(v0);
    }

    public fun initializeWethObject<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = WethTreasury<T0>{
            id          : 0x2::object::new(arg0),
            weth_amount : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<WethTreasury<T0>>(v0);
    }

    public fun withdrawSUI(arg0: &mut SuiTreasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_amount, arg1), arg2), @0xb6b8d57026badb25d4b6d434c2bb26fa2eaaa7da8c4e35a2b67b26767acf9c65);
    }

    public fun withdrawUSDC<T0>(arg0: &mut UsdcTreasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.usdc_amount, arg1), arg2), @0xb6b8d57026badb25d4b6d434c2bb26fa2eaaa7da8c4e35a2b67b26767acf9c65);
    }

    public fun withdrawWETH<T0>(arg0: &mut WethTreasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.weth_amount, arg1), arg2), @0xb6b8d57026badb25d4b6d434c2bb26fa2eaaa7da8c4e35a2b67b26767acf9c65);
    }

    // decompiled from Move bytecode v6
}

