module 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6 {
    struct H0128d has store, key {
        id: 0x2::object::UID,
        ha7ab7: address,
        h1f669: 0x1::option::Option<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>,
        h70b17: 0x1::option::Option<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>,
        h81bbe: 0x1::option::Option<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>,
    }

    struct H27770 has copy, drop, store {
        h275b0: u64,
    }

    public fun h0fddb(arg0: &mut H0128d, arg1: &mut 0x2::tx_context::TxContext) : &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap {
        assert!(arg0.ha7ab7 == 0x2::tx_context::sender(arg1), 301);
        assert!(0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&arg0.h81bbe), 308);
        0x1::option::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&arg0.h81bbe)
    }

    public fun h1a4e6(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut H0128d, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg0);
        if (v0 < arg3) {
            let v1 = arg3 * 2 - v0;
            if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg2) < v1) {
                abort 310
            };
            let v2 = hc4901(arg1, arg4);
            let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<0x2::sui::SUI>(arg2, &v2, v1, arg4);
            hd47ee(arg1, v2, arg4);
            0x2::coin::join<0x2::sui::SUI>(arg0, v3);
        };
    }

    fun h275b0(arg0: u64) : H27770 {
        H27770{h275b0: arg0}
    }

    public fun h2bdbf<T0: store + key>(arg0: &H0128d, arg1: u64, arg2: &0x2::tx_context::TxContext) : &T0 {
        assert!(arg0.ha7ab7 == 0x2::tx_context::sender(arg2), 301);
        assert!(hbde8b<T0>(arg0, arg1), 311);
        0x2::dynamic_object_field::borrow<H27770, T0>(&arg0.id, h275b0(arg1))
    }

    public fun h2cb40<T0: store + key>(arg0: &mut H0128d, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(arg0.ha7ab7 == 0x2::tx_context::sender(arg2), 301);
        assert!(hbde8b<T0>(arg0, arg1), 311);
        0x2::dynamic_object_field::remove<H27770, T0>(&mut arg0.id, h275b0(arg1))
    }

    public fun h3fe3c<T0: store + key>(arg0: &H0128d, arg1: u64, arg2: &0x2::tx_context::TxContext) : bool {
        assert!(arg0.ha7ab7 == 0x2::tx_context::sender(arg2), 301);
        hbde8b<T0>(arg0, arg1)
    }

    public fun h50957(arg0: &mut H0128d, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof {
        assert!(arg0.ha7ab7 == 0x2::tx_context::sender(arg2), 301);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(arg1, 0x1::option::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.h1f669), arg2)
    }

    public fun h58978(arg0: &mut H0128d, arg1: &mut 0x2::tx_context::TxContext) : &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap {
        assert!(arg0.ha7ab7 == 0x2::tx_context::sender(arg1), 301);
        assert!(0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.h1f669), 304);
        0x1::option::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.h1f669)
    }

    public fun h58a11<T0>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager) : u64 {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg0)
    }

    public fun h81caf(arg0: &mut H0128d, arg1: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.ha7ab7 == 0x2::tx_context::sender(arg2), 301);
        assert!(0x1::option::is_none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.h1f669), 305);
        0x1::option::fill<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&mut arg0.h1f669, arg1);
    }

    public fun h8d9ea(arg0: &H0128d, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.ha7ab7 == 0x2::tx_context::sender(arg2), 301);
        assert!(!ha39b4(arg0, arg1), 312);
    }

    public fun ha233a(arg0: &H0128d, arg1: u64, arg2: &0x2::tx_context::TxContext) : 0x1::option::Option<0x2::object::ID> {
        assert!(arg0.ha7ab7 == 0x2::tx_context::sender(arg2), 301);
        0x2::dynamic_object_field::id<H27770>(&arg0.id, h275b0(arg1))
    }

    fun ha39b4(arg0: &H0128d, arg1: u64) : bool {
        0x2::dynamic_object_field::exists_<H27770>(&arg0.id, h275b0(arg1))
    }

    public fun ha4cf0<T0: store + key>(arg0: &mut H0128d, arg1: u64, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.ha7ab7 == 0x2::tx_context::sender(arg3), 301);
        assert!(!ha39b4(arg0, arg1), 312);
        0x2::dynamic_object_field::add<H27770, T0>(&mut arg0.id, h275b0(arg1), arg2);
    }

    public fun hb9332<T0: store + key>(arg0: &mut H0128d, arg1: u64, arg2: &0x2::tx_context::TxContext) : &mut T0 {
        assert!(arg0.ha7ab7 == 0x2::tx_context::sender(arg2), 301);
        assert!(hbde8b<T0>(arg0, arg1), 311);
        0x2::dynamic_object_field::borrow_mut<H27770, T0>(&mut arg0.id, h275b0(arg1))
    }

    fun hbde8b<T0: store + key>(arg0: &H0128d, arg1: u64) : bool {
        0x2::dynamic_object_field::exists_with_type<H27770, T0>(&arg0.id, h275b0(arg1))
    }

    public fun hc4901(arg0: &mut H0128d, arg1: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap {
        assert!(arg0.ha7ab7 == 0x2::tx_context::sender(arg1), 301);
        assert!(0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&arg0.h70b17), 306);
        0x1::option::extract<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&mut arg0.h70b17)
    }

    public fun hce93f(arg0: &mut H0128d, arg1: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.ha7ab7 == 0x2::tx_context::sender(arg2), 301);
        assert!(0x1::option::is_none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&arg0.h81bbe), 309);
        0x1::option::fill<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&mut arg0.h81bbe, arg1);
    }

    public fun hd1a02(arg0: &mut 0x2::tx_context::TxContext) : address {
        let v0 = H0128d{
            id     : 0x2::object::new(arg0),
            ha7ab7 : 0x2::tx_context::sender(arg0),
            h1f669 : 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(),
            h70b17 : 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(),
            h81bbe : 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(),
        };
        0x2::transfer::share_object<H0128d>(v0);
        0x2::object::uid_to_address(&v0.id)
    }

    public fun hd47ee(arg0: &mut H0128d, arg1: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.ha7ab7 == 0x2::tx_context::sender(arg2), 301);
        assert!(0x1::option::is_none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&arg0.h70b17), 307);
        0x1::option::fill<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&mut arg0.h70b17, arg1);
    }

    public fun hd6353(arg0: &mut H0128d, arg1: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap {
        assert!(arg0.ha7ab7 == 0x2::tx_context::sender(arg1), 301);
        assert!(0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.h1f669), 304);
        0x1::option::extract<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&mut arg0.h1f669)
    }

    public fun hd6737(arg0: &mut H0128d, arg1: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap {
        assert!(arg0.ha7ab7 == 0x2::tx_context::sender(arg1), 301);
        assert!(0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&arg0.h81bbe), 308);
        0x1::option::extract<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&mut arg0.h81bbe)
    }

    public fun hec8a2<T0>(arg0: &mut H0128d, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.ha7ab7 == 0x2::tx_context::sender(arg3), 301);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<T0>(arg1, 0x1::option::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&arg0.h81bbe), arg2, arg3);
    }

    public fun hecb17(arg0: &H0128d, arg1: u64, arg2: &0x2::tx_context::TxContext) : bool {
        assert!(arg0.ha7ab7 == 0x2::tx_context::sender(arg2), 301);
        ha39b4(arg0, arg1)
    }

    public fun hf6525<T0>(arg0: &mut H0128d, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.ha7ab7 == 0x2::tx_context::sender(arg3), 301);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T0>(arg1, 0x1::option::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&arg0.h70b17), arg2, arg3)
    }

    public fun hf9863(arg0: &mut H0128d, arg1: &mut 0x2::tx_context::TxContext) : &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap {
        assert!(arg0.ha7ab7 == 0x2::tx_context::sender(arg1), 301);
        assert!(0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&arg0.h70b17), 306);
        0x1::option::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&arg0.h70b17)
    }

    // decompiled from Move bytecode v6
}

