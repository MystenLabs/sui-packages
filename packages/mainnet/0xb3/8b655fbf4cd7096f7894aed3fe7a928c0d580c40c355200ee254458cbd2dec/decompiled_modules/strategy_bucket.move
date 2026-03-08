module 0x4d60167ca198b1264e4d3b95f5227eaf877876058c7cfb970d2e9abde90a6638::strategy_bucket {
    struct BucketPositionReceipt<phantom T0> has store, key {
        id: 0x2::object::UID,
        amount: u64,
    }

    public fun balance_to_coin<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(arg0, arg1)
    }

    public fun commit_bucket_strategy<T0>(arg0: &mut 0x4d60167ca198b1264e4d3b95f5227eaf877876058c7cfb970d2e9abde90a6638::aqua::Vault<T0>, arg1: &0x4d60167ca198b1264e4d3b95f5227eaf877876058c7cfb970d2e9abde90a6638::aqua::StrategyCap, arg2: 0x4d60167ca198b1264e4d3b95f5227eaf877876058c7cfb970d2e9abde90a6638::aqua::BorrowReceipt<T0>, arg3: BucketPositionReceipt<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x4d60167ca198b1264e4d3b95f5227eaf877876058c7cfb970d2e9abde90a6638::aqua::commit_strategy<T0, T0>(arg0, arg2, 0x2::balance::zero<T0>());
        0x2::transfer::public_transfer<BucketPositionReceipt<T0>>(arg3, 0x2::tx_context::sender(arg4));
    }

    public fun issue_deposit_receipt<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : BucketPositionReceipt<T0> {
        BucketPositionReceipt<T0>{
            id     : 0x2::object::new(arg1),
            amount : arg0,
        }
    }

    public fun rebalance_and_repay<T0>(arg0: &mut 0x4d60167ca198b1264e4d3b95f5227eaf877876058c7cfb970d2e9abde90a6638::aqua::Vault<T0>, arg1: &0x4d60167ca198b1264e4d3b95f5227eaf877876058c7cfb970d2e9abde90a6638::aqua::StrategyCap, arg2: 0x4d60167ca198b1264e4d3b95f5227eaf877876058c7cfb970d2e9abde90a6638::aqua::BorrowReceipt<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: BucketPositionReceipt<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        let BucketPositionReceipt {
            id     : v0,
            amount : _,
        } = arg5;
        0x2::object::delete(v0);
        0x4d60167ca198b1264e4d3b95f5227eaf877876058c7cfb970d2e9abde90a6638::aqua::repay_rebalance<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

