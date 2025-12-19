module 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm {
    struct CBM has store, key {
        id: 0x2::object::UID,
        aw: address,
        tc: 0x1::option::Option<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>,
        wc: 0x1::option::Option<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>,
        dc: 0x1::option::Option<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : address {
        let v0 = CBM{
            id : 0x2::object::new(arg0),
            aw : 0x2::tx_context::sender(arg0),
            tc : 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(),
            wc : 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(),
            dc : 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(),
        };
        0x2::transfer::share_object<CBM>(v0);
        0x2::object::uid_to_address(&v0.id)
    }

    public fun bal<T0>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager) : u64 {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg0)
    }

    public fun bdc(arg0: &mut CBM, arg1: &mut 0x2::tx_context::TxContext) : &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap {
        assert!(arg0.aw == 0x2::tx_context::sender(arg1), 301);
        assert!(0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&arg0.dc), 308);
        0x1::option::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&arg0.dc)
    }

    public fun btc(arg0: &mut CBM, arg1: &mut 0x2::tx_context::TxContext) : &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap {
        assert!(arg0.aw == 0x2::tx_context::sender(arg1), 301);
        assert!(0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.tc), 304);
        0x1::option::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.tc)
    }

    public fun bwc(arg0: &mut CBM, arg1: &mut 0x2::tx_context::TxContext) : &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap {
        assert!(arg0.aw == 0x2::tx_context::sender(arg1), 301);
        assert!(0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&arg0.wc), 306);
        0x1::option::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&arg0.wc)
    }

    public fun ddc(arg0: &mut CBM, arg1: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.aw == 0x2::tx_context::sender(arg2), 301);
        assert!(0x1::option::is_none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&arg0.dc), 309);
        0x1::option::fill<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&mut arg0.dc, arg1);
    }

    public fun dp<T0>(arg0: &mut CBM, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.aw == 0x2::tx_context::sender(arg3), 301);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<T0>(arg1, 0x1::option::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&arg0.dc), arg2, arg3);
    }

    public fun dtc(arg0: &mut CBM, arg1: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.aw == 0x2::tx_context::sender(arg2), 301);
        assert!(0x1::option::is_none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.tc), 305);
        0x1::option::fill<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&mut arg0.tc, arg1);
    }

    public fun dwc(arg0: &mut CBM, arg1: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.aw == 0x2::tx_context::sender(arg2), 301);
        assert!(0x1::option::is_none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&arg0.wc), 307);
        0x1::option::fill<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&mut arg0.wc, arg1);
    }

    public fun gdtp(arg0: &mut CBM, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof {
        assert!(arg0.aw == 0x2::tx_context::sender(arg2), 301);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(arg1, 0x1::option::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.tc), arg2)
    }

    public fun tdc(arg0: &mut CBM, arg1: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap {
        assert!(arg0.aw == 0x2::tx_context::sender(arg1), 301);
        assert!(0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&arg0.dc), 308);
        0x1::option::extract<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&mut arg0.dc)
    }

    public fun ttc(arg0: &mut CBM, arg1: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap {
        assert!(arg0.aw == 0x2::tx_context::sender(arg1), 301);
        assert!(0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.tc), 304);
        0x1::option::extract<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&mut arg0.tc)
    }

    public fun twc(arg0: &mut CBM, arg1: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap {
        assert!(arg0.aw == 0x2::tx_context::sender(arg1), 301);
        assert!(0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&arg0.wc), 306);
        0x1::option::extract<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&mut arg0.wc)
    }

    public fun wd<T0>(arg0: &mut CBM, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.aw == 0x2::tx_context::sender(arg3), 301);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T0>(arg1, 0x1::option::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&arg0.wc), arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

