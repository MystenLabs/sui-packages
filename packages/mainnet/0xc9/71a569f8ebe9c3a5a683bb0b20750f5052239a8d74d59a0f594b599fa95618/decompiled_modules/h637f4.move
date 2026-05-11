module 0xc971a569f8ebe9c3a5a683bb0b20750f5052239a8d74d59a0f594b599fa95618::h637f4 {
    struct H8e2ee has store, key {
        id: 0x2::object::UID,
        ha339f: address,
        h948f0: 0x1::option::Option<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>,
        h4b8ac: 0x1::option::Option<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>,
        hd49b8: 0x1::option::Option<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>,
    }

    public fun h09e38(arg0: &mut H8e2ee, arg1: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.ha339f == 0x2::tx_context::sender(arg2), 301);
        assert!(0x1::option::is_none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.h948f0), 305);
        0x1::option::fill<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&mut arg0.h948f0, arg1);
    }

    public fun h0abe4(arg0: &mut H8e2ee, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof {
        assert!(arg0.ha339f == 0x2::tx_context::sender(arg2), 301);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(arg1, 0x1::option::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.h948f0), arg2)
    }

    public fun h1313c<T0>(arg0: &mut H8e2ee, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.ha339f == 0x2::tx_context::sender(arg3), 301);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T0>(arg1, 0x1::option::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&arg0.h4b8ac), arg2, arg3)
    }

    public fun h1e014(arg0: &mut H8e2ee, arg1: &mut 0x2::tx_context::TxContext) : &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap {
        assert!(arg0.ha339f == 0x2::tx_context::sender(arg1), 301);
        assert!(0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&arg0.h4b8ac), 306);
        0x1::option::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&arg0.h4b8ac)
    }

    public fun h2684f(arg0: &mut H8e2ee, arg1: &mut 0x2::tx_context::TxContext) : &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap {
        assert!(arg0.ha339f == 0x2::tx_context::sender(arg1), 301);
        assert!(0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&arg0.hd49b8), 308);
        0x1::option::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&arg0.hd49b8)
    }

    public fun h3ab73<T0>(arg0: &mut H8e2ee, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.ha339f == 0x2::tx_context::sender(arg3), 301);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<T0>(arg1, 0x1::option::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&arg0.hd49b8), arg2, arg3);
    }

    public fun h450fd<T0>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager) : u64 {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg0)
    }

    public fun h4a4fe(arg0: &mut H8e2ee, arg1: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap {
        assert!(arg0.ha339f == 0x2::tx_context::sender(arg1), 301);
        assert!(0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&arg0.h4b8ac), 306);
        0x1::option::extract<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&mut arg0.h4b8ac)
    }

    public fun h4ae37(arg0: &mut 0x2::tx_context::TxContext) : address {
        let v0 = H8e2ee{
            id     : 0x2::object::new(arg0),
            ha339f : 0x2::tx_context::sender(arg0),
            h948f0 : 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(),
            h4b8ac : 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(),
            hd49b8 : 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(),
        };
        0x2::transfer::share_object<H8e2ee>(v0);
        0x2::object::uid_to_address(&v0.id)
    }

    public fun h661eb(arg0: &mut H8e2ee, arg1: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.ha339f == 0x2::tx_context::sender(arg2), 301);
        assert!(0x1::option::is_none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&arg0.h4b8ac), 307);
        0x1::option::fill<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&mut arg0.h4b8ac, arg1);
    }

    public fun h66927(arg0: &mut H8e2ee, arg1: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap {
        assert!(arg0.ha339f == 0x2::tx_context::sender(arg1), 301);
        assert!(0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.h948f0), 304);
        0x1::option::extract<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&mut arg0.h948f0)
    }

    public fun h73017(arg0: &mut H8e2ee, arg1: &mut 0x2::tx_context::TxContext) : &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap {
        assert!(arg0.ha339f == 0x2::tx_context::sender(arg1), 301);
        assert!(0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.h948f0), 304);
        0x1::option::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.h948f0)
    }

    public fun h89a90(arg0: &mut H8e2ee, arg1: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.ha339f == 0x2::tx_context::sender(arg2), 301);
        assert!(0x1::option::is_none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&arg0.hd49b8), 309);
        0x1::option::fill<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&mut arg0.hd49b8, arg1);
    }

    public fun hdabb8(arg0: &mut H8e2ee, arg1: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap {
        assert!(arg0.ha339f == 0x2::tx_context::sender(arg1), 301);
        assert!(0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&arg0.hd49b8), 308);
        0x1::option::extract<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&mut arg0.hd49b8)
    }

    // decompiled from Move bytecode v6
}

