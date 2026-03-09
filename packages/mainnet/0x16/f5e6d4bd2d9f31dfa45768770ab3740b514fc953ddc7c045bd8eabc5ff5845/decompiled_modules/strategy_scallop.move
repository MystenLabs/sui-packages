module 0x4d60167ca198b1264e4d3b95f5227eaf877876058c7cfb970d2e9abde90a6638::strategy_scallop {
    struct ScallopStrategy has key {
        id: 0x2::object::UID,
        cap: 0x4d60167ca198b1264e4d3b95f5227eaf877876058c7cfb970d2e9abde90a6638::aqua::StrategyCap,
    }

    public fun initialize(arg0: 0x4d60167ca198b1264e4d3b95f5227eaf877876058c7cfb970d2e9abde90a6638::aqua::StrategyCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ScallopStrategy{
            id  : 0x2::object::new(arg1),
            cap : arg0,
        };
        0x2::transfer::share_object<ScallopStrategy>(v0);
    }

    public fun rebalance_and_repay<T0>(arg0: &mut 0x4d60167ca198b1264e4d3b95f5227eaf877876058c7cfb970d2e9abde90a6638::aqua::Vault<T0>, arg1: &0x4d60167ca198b1264e4d3b95f5227eaf877876058c7cfb970d2e9abde90a6638::aqua::StrategyCap, arg2: 0x4d60167ca198b1264e4d3b95f5227eaf877876058c7cfb970d2e9abde90a6638::aqua::BorrowReceipt<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x4d60167ca198b1264e4d3b95f5227eaf877876058c7cfb970d2e9abde90a6638::aqua::repay_rebalance<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun withdraw_scoin<T0, T1>(arg0: &mut 0x4d60167ca198b1264e4d3b95f5227eaf877876058c7cfb970d2e9abde90a6638::aqua::Vault<T0>, arg1: &0x4d60167ca198b1264e4d3b95f5227eaf877876058c7cfb970d2e9abde90a6638::aqua::StrategyCap) : 0x2::balance::Balance<T1> {
        0x4d60167ca198b1264e4d3b95f5227eaf877876058c7cfb970d2e9abde90a6638::aqua::take_yield_balance<T0, T1>(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

