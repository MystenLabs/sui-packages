module 0xedb3701163db13b5a55d3b3aa29506e16241d93a2d06482487265d96ae70e6f3::km {
    struct CKM has store, key {
        id: 0x2::object::UID,
        era: address,
        abr: 0x1::option::Option<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>,
        eir: 0x1::option::Option<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>,
    }

    public fun ab_abr(arg0: &mut CKM, arg1: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap {
        assert!(arg0.era == 0x2::tx_context::sender(arg1), 901);
        assert!(0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&arg0.abr), 903);
        0x1::option::extract<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&mut arg0.abr)
    }

    public fun ab_dbk<T0>(arg0: &mut CKM, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.era == 0x2::tx_context::sender(arg3), 901);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T0>(arg1, 0x1::option::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&arg0.abr), arg2, arg3)
    }

    public fun ab_eir(arg0: &mut CKM, arg1: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap {
        assert!(arg0.era == 0x2::tx_context::sender(arg1), 901);
        assert!(0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&arg0.eir), 905);
        0x1::option::extract<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&mut arg0.eir)
    }

    public fun ab_stl<T0: store + key>(arg0: &mut CKM, arg1: u64, arg2: &0x2::tx_context::TxContext) : T0 {
        assert!(arg0.era == 0x2::tx_context::sender(arg2), 901);
        0x2::dynamic_object_field::remove<u64, T0>(&mut arg0.id, arg1)
    }

    public fun ez_abr(arg0: &mut CKM, arg1: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.era == 0x2::tx_context::sender(arg2), 901);
        assert!(0x1::option::is_none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&arg0.abr), 904);
        0x1::option::fill<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&mut arg0.abr, arg1);
    }

    public fun ez_dbk<T0>(arg0: &mut CKM, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.era == 0x2::tx_context::sender(arg3), 901);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<T0>(arg1, 0x1::option::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&arg0.eir), arg2, arg3);
    }

    public fun ez_eir(arg0: &mut CKM, arg1: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.era == 0x2::tx_context::sender(arg2), 901);
        assert!(0x1::option::is_none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&arg0.eir), 906);
        0x1::option::fill<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&mut arg0.eir, arg1);
    }

    public fun ez_stl<T0: store + key>(arg0: &mut CKM, arg1: u64, arg2: T0, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.era == 0x2::tx_context::sender(arg3), 901);
        0x2::dynamic_object_field::add<u64, T0>(&mut arg0.id, arg1, arg2);
    }

    public fun ks_dbk<T0>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager) : u64 {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg0)
    }

    public fun n(arg0: &mut 0x2::tx_context::TxContext) : address {
        let v0 = CKM{
            id  : 0x2::object::new(arg0),
            era : 0x2::tx_context::sender(arg0),
            abr : 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(),
            eir : 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(),
        };
        0x2::transfer::share_object<CKM>(v0);
        0x2::object::uid_to_address(&v0.id)
    }

    public fun ub_gut(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut CKM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg0);
        if (v0 < arg3) {
            let v1 = arg3 * 2 - v0;
            if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg2) < v1) {
                abort 902
            };
            let v2 = ab_abr(arg1, arg4);
            let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<0x2::sui::SUI>(arg2, &v2, v1, arg4);
            ez_abr(arg1, v2, arg4);
            0x2::coin::join<0x2::sui::SUI>(arg0, v3);
        };
    }

    public fun ub_stl(arg0: &CKM, arg1: u64, arg2: &0x2::tx_context::TxContext) : bool {
        assert!(arg0.era == 0x2::tx_context::sender(arg2), 901);
        0x2::dynamic_object_field::exists_<u64>(&arg0.id, arg1)
    }

    // decompiled from Move bytecode v6
}

