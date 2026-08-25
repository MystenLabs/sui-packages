module 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::legs {
    struct Leg<phantom T0, phantom T1> {
        a: 0x2::balance::Balance<T0>,
        b: 0x2::balance::Balance<T1>,
        owed: u64,
        receipt: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>,
    }

    struct BfLeg<phantom T0, phantom T1> {
        a: 0x2::balance::Balance<T0>,
        b: 0x2::balance::Balance<T1>,
        owed: u64,
        receipt: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>,
    }

    struct MmLeg<phantom T0, phantom T1> {
        a: 0x2::balance::Balance<T0>,
        b: 0x2::balance::Balance<T1>,
        owed: u64,
        receipt: 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::FlashSwapReceipt,
    }

    struct MkLeg<phantom T0, phantom T1> {
        a: 0x2::balance::Balance<T0>,
        b: 0x2::balance::Balance<T1>,
        owed: u64,
        receipt: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt,
    }

    struct DbLeg<phantom T0, phantom T1> {
        loan: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan,
        owed: u64,
    }

    public fun bluefin_repay_a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: BfLeg<T0, T1>, arg3: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        let BfLeg {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg2;
        0x2::balance::destroy_zero<T0>(v0);
        0x2::balance::destroy_zero<T1>(v1);
        assert!(0x2::balance::value<T0>(&arg3) >= v2, 30);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg3, v2), 0x2::balance::zero<T1>(), v3);
        arg3
    }

    public fun bluefin_repay_b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: BfLeg<T0, T1>, arg3: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T1> {
        let BfLeg {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg2;
        0x2::balance::destroy_zero<T0>(v0);
        0x2::balance::destroy_zero<T1>(v1);
        assert!(0x2::balance::value<T1>(&arg3) >= v2, 30);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, v2), v3);
        arg3
    }

    public fun bluefin_start<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) : BfLeg<T0, T1> {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg0, arg1, arg2, true, arg3, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(arg2));
        let v3 = v2;
        BfLeg<T0, T1>{
            a       : v0,
            b       : v1,
            owed    : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v3),
            receipt : v3,
        }
    }

    public fun bluefin_swap_ab<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg0, arg1, true, true, 0x2::balance::value<T0>(&arg2), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(true));
        0x2::balance::destroy_zero<T0>(v0);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, arg2, 0x2::balance::zero<T1>(), v2);
        v1
    }

    public fun bluefin_swap_ba<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg0, arg1, false, true, 0x2::balance::value<T1>(&arg2), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(false));
        0x2::balance::destroy_zero<T1>(v1);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), arg2, v2);
        v0
    }

    public fun bluefin_take_a<T0, T1>(arg0: BfLeg<T0, T1>) : (BfLeg<T0, T1>, 0x2::balance::Balance<T0>) {
        let BfLeg {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg0;
        let v4 = BfLeg<T0, T1>{
            a       : 0x2::balance::zero<T0>(),
            b       : v1,
            owed    : v2,
            receipt : v3,
        };
        (v4, v0)
    }

    public fun bluefin_take_b<T0, T1>(arg0: BfLeg<T0, T1>) : (BfLeg<T0, T1>, 0x2::balance::Balance<T1>) {
        let BfLeg {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg0;
        let v4 = BfLeg<T0, T1>{
            a       : v0,
            b       : 0x2::balance::zero<T1>(),
            owed    : v2,
            receipt : v3,
        };
        (v4, v1)
    }

    public fun cetus_repay_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: Leg<T0, T1>, arg3: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        let Leg {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg2;
        0x2::balance::destroy_zero<T0>(v0);
        0x2::balance::destroy_zero<T1>(v1);
        assert!(0x2::balance::value<T0>(&arg3) >= v2, 30);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg3, v2), 0x2::balance::zero<T1>(), v3);
        arg3
    }

    public fun cetus_repay_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: Leg<T0, T1>, arg3: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T1> {
        let Leg {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg2;
        0x2::balance::destroy_zero<T0>(v0);
        0x2::balance::destroy_zero<T1>(v1);
        assert!(0x2::balance::value<T1>(&arg3) >= v2, 30);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, v2), v3);
        arg3
    }

    public fun cetus_start<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) : Leg<T0, T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg2, true, arg3, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(arg2), arg4);
        let v3 = v2;
        Leg<T0, T1>{
            a       : v0,
            b       : v1,
            owed    : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3),
            receipt : v3,
        }
    }

    public fun cetus_swap_ab<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::balance::value<T0>(&arg2), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(true), arg3);
        0x2::balance::destroy_zero<T0>(v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, arg2, 0x2::balance::zero<T1>(), v2);
        v1
    }

    public fun cetus_swap_ba<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(&arg2), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(false), arg3);
        0x2::balance::destroy_zero<T1>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), arg2, v2);
        v0
    }

    public fun cetus_take_a<T0, T1>(arg0: Leg<T0, T1>) : (Leg<T0, T1>, 0x2::balance::Balance<T0>) {
        let Leg {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg0;
        let v4 = Leg<T0, T1>{
            a       : 0x2::balance::zero<T0>(),
            b       : v1,
            owed    : v2,
            receipt : v3,
        };
        (v4, v0)
    }

    public fun cetus_take_b<T0, T1>(arg0: Leg<T0, T1>) : (Leg<T0, T1>, 0x2::balance::Balance<T1>) {
        let Leg {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg0;
        let v4 = Leg<T0, T1>{
            a       : v0,
            b       : 0x2::balance::zero<T1>(),
            owed    : v2,
            receipt : v3,
        };
        (v4, v1)
    }

    public fun db_owed<T0, T1>(arg0: &DbLeg<T0, T1>) : u64 {
        arg0.owed
    }

    public fun deepbook_borrow_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (DbLeg<T0, T1>, 0x2::balance::Balance<T0>) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg0, arg1, arg2);
        let v2 = v0;
        let v3 = DbLeg<T0, T1>{
            loan : v1,
            owed : 0x2::coin::value<T0>(&v2),
        };
        (v3, 0x2::coin::into_balance<T0>(v2))
    }

    public fun deepbook_borrow_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (DbLeg<T0, T1>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg1, arg2);
        let v2 = v0;
        let v3 = DbLeg<T0, T1>{
            loan : v1,
            owed : 0x2::coin::value<T1>(&v2),
        };
        (v3, 0x2::coin::into_balance<T1>(v2))
    }

    public fun deepbook_repay_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: DbLeg<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let DbLeg {
            loan : v0,
            owed : v1,
        } = arg1;
        assert!(0x2::balance::value<T0>(&arg2) >= v1, 30);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2, v1), arg3), v0);
        arg2
    }

    public fun deepbook_repay_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: DbLeg<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let DbLeg {
            loan : v0,
            owed : v1,
        } = arg1;
        assert!(0x2::balance::value<T1>(&arg2) >= v1, 30);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg2, v1), arg3), v0);
        arg2
    }

    public fun deepbook_swap_bq<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg0, 0x2::coin::from_balance<T0>(arg1, arg4), arg2, 0, arg3, arg4);
        let v3 = v0;
        if (0x2::coin::value<T0>(&v3) == 0) {
            0x2::coin::destroy_zero<T0>(v3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg4));
        };
        (0x2::coin::into_balance<T1>(v1), v2)
    }

    public fun deepbook_swap_qb<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, 0x2::coin::from_balance<T1>(arg1, arg4), arg2, 0, arg3, arg4);
        let v3 = v1;
        if (0x2::coin::value<T1>(&v3) == 0) {
            0x2::coin::destroy_zero<T1>(v3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, 0x2::tx_context::sender(arg4));
        };
        (0x2::coin::into_balance<T0>(v0), v2)
    }

    public fun e_short_repay() : u64 {
        30
    }

    public fun momentum_fork_repay_a<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: MkLeg<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let MkLeg {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg2;
        0x2::balance::destroy_zero<T0>(v0);
        0x2::balance::destroy_zero<T1>(v1);
        assert!(0x2::balance::value<T0>(&arg3) >= v2, 30);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v3, 0x2::balance::split<T0>(&mut arg3, v2), 0x2::balance::zero<T1>(), arg0, arg4);
        arg3
    }

    public fun momentum_fork_repay_b<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: MkLeg<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let MkLeg {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg2;
        0x2::balance::destroy_zero<T0>(v0);
        0x2::balance::destroy_zero<T1>(v1);
        assert!(0x2::balance::value<T1>(&arg3) >= v2, 30);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, v2), arg0, arg4);
        arg3
    }

    public fun momentum_fork_start<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : MkLeg<T0, T1> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, arg2, true, arg3, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(arg2), arg4, arg0, arg5);
        let v3 = v2;
        let (v4, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        let v6 = if (arg2) {
            v4
        } else {
            v5
        };
        MkLeg<T0, T1>{
            a       : v0,
            b       : v1,
            owed    : v6,
            receipt : v3,
        }
    }

    public fun momentum_fork_swap_ab<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, true, true, 0x2::balance::value<T0>(&arg2), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(true), arg3, arg0, arg4);
        0x2::balance::destroy_zero<T0>(v0);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v2, arg2, 0x2::balance::zero<T1>(), arg0, arg4);
        v1
    }

    public fun momentum_fork_swap_ba<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, false, true, 0x2::balance::value<T1>(&arg2), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(false), arg3, arg0, arg4);
        0x2::balance::destroy_zero<T1>(v1);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v2, 0x2::balance::zero<T0>(), arg2, arg0, arg4);
        v0
    }

    public fun momentum_fork_take_a<T0, T1>(arg0: MkLeg<T0, T1>) : (MkLeg<T0, T1>, 0x2::balance::Balance<T0>) {
        let MkLeg {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg0;
        let v4 = MkLeg<T0, T1>{
            a       : 0x2::balance::zero<T0>(),
            b       : v1,
            owed    : v2,
            receipt : v3,
        };
        (v4, v0)
    }

    public fun momentum_fork_take_b<T0, T1>(arg0: MkLeg<T0, T1>) : (MkLeg<T0, T1>, 0x2::balance::Balance<T1>) {
        let MkLeg {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg0;
        let v4 = MkLeg<T0, T1>{
            a       : v0,
            b       : 0x2::balance::zero<T1>(),
            owed    : v2,
            receipt : v3,
        };
        (v4, v1)
    }

    public fun momentum_repay_a<T0, T1>(arg0: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg1: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: MmLeg<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let MmLeg {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg2;
        0x2::balance::destroy_zero<T0>(v0);
        0x2::balance::destroy_zero<T1>(v1);
        assert!(0x2::balance::value<T0>(&arg3) >= v2, 30);
        0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::repay_flash_swap<T0, T1>(arg1, v3, 0x2::balance::split<T0>(&mut arg3, v2), 0x2::balance::zero<T1>(), arg0, arg4);
        arg3
    }

    public fun momentum_repay_b<T0, T1>(arg0: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg1: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: MmLeg<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let MmLeg {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg2;
        0x2::balance::destroy_zero<T0>(v0);
        0x2::balance::destroy_zero<T1>(v1);
        assert!(0x2::balance::value<T1>(&arg3) >= v2, 30);
        0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::repay_flash_swap<T0, T1>(arg1, v3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, v2), arg0, arg4);
        arg3
    }

    public fun momentum_start<T0, T1>(arg0: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg1: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : MmLeg<T0, T1> {
        let (v0, v1, v2) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::flash_swap<T0, T1>(arg1, arg2, true, arg3, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(arg2), arg4, arg0, arg5);
        let v3 = v2;
        let (v4, v5) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::swap_receipt_debts(&v3);
        let v6 = if (arg2) {
            v4
        } else {
            v5
        };
        MmLeg<T0, T1>{
            a       : v0,
            b       : v1,
            owed    : v6,
            receipt : v3,
        }
    }

    public fun momentum_swap_ab<T0, T1>(arg0: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg1: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::flash_swap<T0, T1>(arg1, true, true, 0x2::balance::value<T0>(&arg2), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(true), arg3, arg0, arg4);
        0x2::balance::destroy_zero<T0>(v0);
        0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::repay_flash_swap<T0, T1>(arg1, v2, arg2, 0x2::balance::zero<T1>(), arg0, arg4);
        v1
    }

    public fun momentum_swap_ba<T0, T1>(arg0: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg1: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::flash_swap<T0, T1>(arg1, false, true, 0x2::balance::value<T1>(&arg2), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(false), arg3, arg0, arg4);
        0x2::balance::destroy_zero<T1>(v1);
        0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::repay_flash_swap<T0, T1>(arg1, v2, 0x2::balance::zero<T0>(), arg2, arg0, arg4);
        v0
    }

    public fun momentum_take_a<T0, T1>(arg0: MmLeg<T0, T1>) : (MmLeg<T0, T1>, 0x2::balance::Balance<T0>) {
        let MmLeg {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg0;
        let v4 = MmLeg<T0, T1>{
            a       : 0x2::balance::zero<T0>(),
            b       : v1,
            owed    : v2,
            receipt : v3,
        };
        (v4, v0)
    }

    public fun momentum_take_b<T0, T1>(arg0: MmLeg<T0, T1>) : (MmLeg<T0, T1>, 0x2::balance::Balance<T1>) {
        let MmLeg {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg0;
        let v4 = MmLeg<T0, T1>{
            a       : v0,
            b       : 0x2::balance::zero<T1>(),
            owed    : v2,
            receipt : v3,
        };
        (v4, v1)
    }

    public fun obric_swap_xy<T0, T1>(arg0: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::coin::into_balance<T1>(0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::swap_x_to_y<T0, T1>(arg0, arg2, arg3, arg4, arg5, 0x2::coin::from_balance<T0>(arg1, arg6), arg6))
    }

    public fun obric_swap_yx<T0, T1>(arg0: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::swap_y_to_x<T0, T1>(arg0, arg2, arg3, arg4, arg5, 0x2::coin::from_balance<T1>(arg1, arg6), arg6))
    }

    public fun turbos_swap_ab<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, 0x2::coin::from_balance<T0>(arg1, arg4));
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg0, v0, 0x2::balance::value<T0>(&arg1), 0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::turbos_price_limit(true), true, 0x2::tx_context::sender(arg4), 18446744073709551615, arg2, arg3, arg4);
        0x2::coin::destroy_zero<T0>(v2);
        0x2::coin::into_balance<T1>(v1)
    }

    public fun turbos_swap_ba<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v0, 0x2::coin::from_balance<T1>(arg1, arg4));
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg0, v0, 0x2::balance::value<T1>(&arg1), 0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::turbos_price_limit(false), true, 0x2::tx_context::sender(arg4), 18446744073709551615, arg2, arg3, arg4);
        0x2::coin::destroy_zero<T1>(v2);
        0x2::coin::into_balance<T0>(v1)
    }

    // decompiled from Move bytecode v7
}

