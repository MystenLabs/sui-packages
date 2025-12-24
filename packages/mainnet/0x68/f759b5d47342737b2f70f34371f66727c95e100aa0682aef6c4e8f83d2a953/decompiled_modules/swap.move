module 0x68f759b5d47342737b2f70f34371f66727c95e100aa0682aef6c4e8f83d2a953::swap {
    struct CetusFlashSwapA2BReceipt<phantom T0, phantom T1> {
        receipt: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>,
        pay_amount: u64,
    }

    struct CetusFlashSwapB2AReceipt<phantom T0, phantom T1> {
        receipt: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>,
        pay_amount: u64,
    }

    struct BluefinFlashSwapA2BReceipt<phantom T0, phantom T1> {
        receipt: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>,
        pay_amount: u64,
    }

    struct BluefinFlashSwapB2AReceipt<phantom T0, phantom T1> {
        receipt: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>,
        pay_amount: u64,
    }

    struct DeepBookFlashLoanBaseReceipt<phantom T0, phantom T1> {
        loan: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan,
        borrow_amount: u64,
    }

    struct DeepBookFlashLoanQuoteReceipt<phantom T0, phantom T1> {
        loan: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan,
        borrow_amount: u64,
    }

    public fun aftermath_swap_a2b<T0, T1, T2>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(0x2::coin::value<T1>(&arg6) > 0, 101);
        0x68f759b5d47342737b2f70f34371f66727c95e100aa0682aef6c4e8f83d2a953::swap_aftermath::swap_a2b<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun aftermath_swap_b2a<T0, T1, T2>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T2>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::coin::value<T2>(&arg6) > 0, 101);
        0x68f759b5d47342737b2f70f34371f66727c95e100aa0682aef6c4e8f83d2a953::swap_aftermath::swap_b2a<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun bluefin_flash_swap_a2b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, BluefinFlashSwapA2BReceipt<T0, T1>) {
        assert!(arg2 > 0, 101);
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg0, arg1, true, true, arg2, arg3);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let v4 = BluefinFlashSwapA2BReceipt<T0, T1>{
            receipt    : v3,
            pay_amount : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v3),
        };
        (0x2::coin::from_balance<T1>(v1, arg5), v4)
    }

    public fun bluefin_flash_swap_b2a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, BluefinFlashSwapB2AReceipt<T0, T1>) {
        assert!(arg2 > 0, 101);
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg0, arg1, false, true, arg2, arg3);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let v4 = BluefinFlashSwapB2AReceipt<T0, T1>{
            receipt    : v3,
            pay_amount : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v3),
        };
        (0x2::coin::from_balance<T0>(v0, arg5), v4)
    }

    public fun bluefin_repay_flash_swap_a2b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: BluefinFlashSwapA2BReceipt<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let BluefinFlashSwapA2BReceipt {
            receipt    : v0,
            pay_amount : v1,
        } = arg3;
        assert!(0x2::coin::value<T0>(&arg2) >= v1, 104);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v1, arg4)), 0x2::balance::zero<T1>(), v0);
        arg2
    }

    public fun bluefin_repay_flash_swap_b2a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: BluefinFlashSwapB2AReceipt<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let BluefinFlashSwapB2AReceipt {
            receipt    : v0,
            pay_amount : v1,
        } = arg3;
        assert!(0x2::coin::value<T1>(&arg2) >= v1, 104);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v1, arg4)), v0);
        arg2
    }

    public fun bluefin_swap_a2b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        assert!(0x2::coin::value<T0>(&arg2) > 0, 101);
        let (v0, v1) = 0x68f759b5d47342737b2f70f34371f66727c95e100aa0682aef6c4e8f83d2a953::bluefin::swap_a2b<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = v0;
        assert!(0x2::coin::value<T1>(&v2) > 0, 102);
        (v2, v1)
    }

    public fun bluefin_swap_b2a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T1>(&arg2) > 0, 101);
        let (v0, v1) = 0x68f759b5d47342737b2f70f34371f66727c95e100aa0682aef6c4e8f83d2a953::bluefin::swap_b2a<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = v0;
        assert!(0x2::coin::value<T0>(&v2) > 0, 102);
        (v2, v1)
    }

    public fun bluemove_swap_a2b<T0, T1>(arg0: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 101);
        let v0 = 0x68f759b5d47342737b2f70f34371f66727c95e100aa0682aef6c4e8f83d2a953::bluemove::swap_a2b<T0, T1>(arg0, arg1, arg3);
        let v1 = 0x2::coin::value<T1>(&v0);
        assert!(v1 > 0, 102);
        assert!(v1 >= arg2, 103);
        v0
    }

    public fun bluemove_swap_b2a<T0, T1>(arg0: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T1>(&arg1) > 0, 101);
        let v0 = 0x68f759b5d47342737b2f70f34371f66727c95e100aa0682aef6c4e8f83d2a953::bluemove::swap_b2a<T0, T1>(arg0, arg1, arg3);
        let v1 = 0x2::coin::value<T0>(&v0);
        assert!(v1 > 0, 102);
        assert!(v1 >= arg2, 103);
        v0
    }

    public fun cetus_flash_swap_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, CetusFlashSwapA2BReceipt<T0, T1>) {
        assert!(arg2 > 0, 101);
        let (v0, v1, v2) = 0x68f759b5d47342737b2f70f34371f66727c95e100aa0682aef6c4e8f83d2a953::swap_cetus::flash_swap_a2b<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v3 = CetusFlashSwapA2BReceipt<T0, T1>{
            receipt    : v1,
            pay_amount : v2,
        };
        (v0, v3)
    }

    public fun cetus_flash_swap_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, CetusFlashSwapB2AReceipt<T0, T1>) {
        assert!(arg2 > 0, 101);
        let (v0, v1, v2) = 0x68f759b5d47342737b2f70f34371f66727c95e100aa0682aef6c4e8f83d2a953::swap_cetus::flash_swap_b2a<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v3 = CetusFlashSwapB2AReceipt<T0, T1>{
            receipt    : v1,
            pay_amount : v2,
        };
        (v0, v3)
    }

    public fun cetus_repay_flash_swap_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: CetusFlashSwapA2BReceipt<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let CetusFlashSwapA2BReceipt {
            receipt    : v0,
            pay_amount : v1,
        } = arg3;
        assert!(0x2::coin::value<T0>(&arg2) >= v1, 104);
        0x68f759b5d47342737b2f70f34371f66727c95e100aa0682aef6c4e8f83d2a953::swap_cetus::repay_flash_swap_a2b<T0, T1>(arg0, arg1, arg2, v0, v1, arg4)
    }

    public fun cetus_repay_flash_swap_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: CetusFlashSwapB2AReceipt<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let CetusFlashSwapB2AReceipt {
            receipt    : v0,
            pay_amount : v1,
        } = arg3;
        assert!(0x2::coin::value<T1>(&arg2) >= v1, 104);
        0x68f759b5d47342737b2f70f34371f66727c95e100aa0682aef6c4e8f83d2a953::swap_cetus::repay_flash_swap_b2a<T0, T1>(arg0, arg1, arg2, v0, v1, arg4)
    }

    public fun cetus_swap_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 101);
        let (v1, v2, v3) = 0x68f759b5d47342737b2f70f34371f66727c95e100aa0682aef6c4e8f83d2a953::swap_cetus::flash_swap_a2b<T0, T1>(arg0, arg1, v0, arg4, arg5, arg6);
        let v4 = v1;
        assert!(v0 >= v3, 104);
        let v5 = 0x2::coin::value<T1>(&v4);
        assert!(v5 > 0, 102);
        assert!(v5 >= arg3, 103);
        (v4, 0x68f759b5d47342737b2f70f34371f66727c95e100aa0682aef6c4e8f83d2a953::swap_cetus::repay_flash_swap_a2b<T0, T1>(arg0, arg1, arg2, v2, v3, arg6))
    }

    public fun cetus_swap_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0, 101);
        let (v1, v2, v3) = 0x68f759b5d47342737b2f70f34371f66727c95e100aa0682aef6c4e8f83d2a953::swap_cetus::flash_swap_b2a<T0, T1>(arg0, arg1, v0, arg4, arg5, arg6);
        let v4 = v1;
        assert!(v0 >= v3, 104);
        let v5 = 0x2::coin::value<T0>(&v4);
        assert!(v5 > 0, 102);
        assert!(v5 >= arg3, 103);
        (v4, 0x68f759b5d47342737b2f70f34371f66727c95e100aa0682aef6c4e8f83d2a953::swap_cetus::repay_flash_swap_b2a<T0, T1>(arg0, arg1, arg2, v2, v3, arg6))
    }

    public fun deepbook_flash_loan_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, DeepBookFlashLoanBaseReceipt<T0, T1>) {
        assert!(arg1 > 0, 101);
        let (v0, v1) = 0x68f759b5d47342737b2f70f34371f66727c95e100aa0682aef6c4e8f83d2a953::swap_deepbook::flash_loan_base<T0, T1>(arg0, arg1, arg2);
        let v2 = DeepBookFlashLoanBaseReceipt<T0, T1>{
            loan          : v1,
            borrow_amount : arg1,
        };
        (v0, v2)
    }

    public fun deepbook_flash_loan_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, DeepBookFlashLoanQuoteReceipt<T0, T1>) {
        assert!(arg1 > 0, 101);
        let (v0, v1) = 0x68f759b5d47342737b2f70f34371f66727c95e100aa0682aef6c4e8f83d2a953::swap_deepbook::flash_loan_quote<T0, T1>(arg0, arg1, arg2);
        let v2 = DeepBookFlashLoanQuoteReceipt<T0, T1>{
            loan          : v1,
            borrow_amount : arg1,
        };
        (v0, v2)
    }

    public fun deepbook_repay_flash_loan_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: DeepBookFlashLoanBaseReceipt<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let DeepBookFlashLoanBaseReceipt {
            loan          : v0,
            borrow_amount : v1,
        } = arg2;
        assert!(0x2::coin::value<T0>(&arg1) >= v1, 104);
        0x68f759b5d47342737b2f70f34371f66727c95e100aa0682aef6c4e8f83d2a953::swap_deepbook::repay_flash_loan_base<T0, T1>(arg0, arg1, v0, v1, arg3)
    }

    public fun deepbook_repay_flash_loan_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: DeepBookFlashLoanQuoteReceipt<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let DeepBookFlashLoanQuoteReceipt {
            loan          : v0,
            borrow_amount : v1,
        } = arg2;
        assert!(0x2::coin::value<T1>(&arg1) >= v1, 104);
        0x68f759b5d47342737b2f70f34371f66727c95e100aa0682aef6c4e8f83d2a953::swap_deepbook::repay_flash_loan_quote<T0, T1>(arg0, arg1, v0, v1, arg3)
    }

    public fun deepbook_swap_base2quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 101);
        let (v0, v1, v2) = 0x68f759b5d47342737b2f70f34371f66727c95e100aa0682aef6c4e8f83d2a953::swap_deepbook::swap_base2quote<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        let v3 = v1;
        let v4 = 0x2::coin::value<T1>(&v3);
        assert!(v4 > 0, 102);
        assert!(v4 >= arg3, 103);
        (v3, v0, v2)
    }

    public fun deepbook_swap_quote2base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        assert!(0x2::coin::value<T1>(&arg1) > 0, 101);
        let (v0, v1, v2) = 0x68f759b5d47342737b2f70f34371f66727c95e100aa0682aef6c4e8f83d2a953::swap_deepbook::swap_quote2base<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        let v3 = v0;
        let v4 = 0x2::coin::value<T0>(&v3);
        assert!(v4 > 0, 102);
        assert!(v4 >= arg3, 103);
        (v3, v1, v2)
    }

    fun link_amm_math() {
        let v0 = vector[];
        let v1 = vector[];
        0x712579292f80c11a0c9de4ff553d6e5c4757105e83a8a3129823d2b39e65d062::stable_calculations::calc_invariant(&v0, &v1, 0);
    }

    fun link_bridge() {
        0xb::chain_ids::sui_mainnet();
    }

    fun link_sui_system(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &0x2::object::ID) : address {
        0x3::sui_system::validator_address_by_pool_id(arg0, arg1)
    }

    public fun transfer_or_destroy<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun transfer_to_sender<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

