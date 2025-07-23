module 0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations {
    struct ScallopMarketCoin<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        market_id: 0x2::object::ID,
    }

    struct BucketTankReceipt has store {
        tank_share: u64,
        deposit_epoch: u64,
    }

    struct SuilendCToken<phantom T0> has store {
        shares: u64,
        pool_id: 0x2::object::ID,
    }

    struct DeFiDepositReceipt has store {
        protocol: u8,
        scallop_receipt: 0x1::option::Option<ScallopMarketCoin<0x2::sui::SUI>>,
        bucket_receipt: 0x1::option::Option<BucketTankReceipt>,
        suilend_receipt: 0x1::option::Option<SuilendCToken<0x2::sui::SUI>>,
        deposited_amount: u64,
    }

    public fun deposit_to_bucket_tank(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : DeFiDepositReceipt {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        let v1 = BucketTankReceipt{
            tank_share    : v0,
            deposit_epoch : 1,
        };
        DeFiDepositReceipt{
            protocol         : 2,
            scallop_receipt  : 0x1::option::none<ScallopMarketCoin<0x2::sui::SUI>>(),
            bucket_receipt   : 0x1::option::some<BucketTankReceipt>(v1),
            suilend_receipt  : 0x1::option::none<SuilendCToken<0x2::sui::SUI>>(),
            deposited_amount : v0,
        }
    }

    public fun deposit_to_scallop(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : DeFiDepositReceipt {
        let v0 = ScallopMarketCoin<0x2::sui::SUI>{
            balance   : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            market_id : 0x2::object::id_from_address(@0xa757975255146dc9686aa823b7838b507f315d704f428cbadad2f4ea061939d9),
        };
        DeFiDepositReceipt{
            protocol         : 1,
            scallop_receipt  : 0x1::option::some<ScallopMarketCoin<0x2::sui::SUI>>(v0),
            bucket_receipt   : 0x1::option::none<BucketTankReceipt>(),
            suilend_receipt  : 0x1::option::none<SuilendCToken<0x2::sui::SUI>>(),
            deposited_amount : 0x2::coin::value<0x2::sui::SUI>(&arg0),
        }
    }

    public fun deposit_to_suilend(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : DeFiDepositReceipt {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        let v1 = SuilendCToken<0x2::sui::SUI>{
            shares  : v0,
            pool_id : 0x2::object::id_from_address(@0x1),
        };
        DeFiDepositReceipt{
            protocol         : 3,
            scallop_receipt  : 0x1::option::none<ScallopMarketCoin<0x2::sui::SUI>>(),
            bucket_receipt   : 0x1::option::none<BucketTankReceipt>(),
            suilend_receipt  : 0x1::option::some<SuilendCToken<0x2::sui::SUI>>(v1),
            deposited_amount : v0,
        }
    }

    public fun destroy_empty_receipt(arg0: DeFiDepositReceipt) {
        let DeFiDepositReceipt {
            protocol         : _,
            scallop_receipt  : v1,
            bucket_receipt   : v2,
            suilend_receipt  : v3,
            deposited_amount : v4,
        } = arg0;
        assert!(v4 == 0, 3);
        0x1::option::destroy_none<ScallopMarketCoin<0x2::sui::SUI>>(v1);
        0x1::option::destroy_none<BucketTankReceipt>(v2);
        0x1::option::destroy_none<SuilendCToken<0x2::sui::SUI>>(v3);
    }

    public fun get_deposited_amount(arg0: &DeFiDepositReceipt) : u64 {
        arg0.deposited_amount
    }

    public fun get_protocol(arg0: &DeFiDepositReceipt) : u8 {
        arg0.protocol
    }

    public fun withdraw_from_bucket_tank(arg0: &mut DeFiDepositReceipt, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.protocol == 2, 0);
        assert!(arg1 <= arg0.deposited_amount, 1);
        assert!(0x1::option::is_some<BucketTankReceipt>(&arg0.bucket_receipt), 2);
        let v0 = 0x1::option::borrow_mut<BucketTankReceipt>(&mut arg0.bucket_receipt);
        v0.tank_share = v0.tank_share - arg1;
        arg0.deposited_amount = arg0.deposited_amount - arg1;
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg3)
    }

    public fun withdraw_from_scallop(arg0: &mut DeFiDepositReceipt, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.protocol == 1, 0);
        assert!(arg1 <= arg0.deposited_amount, 1);
        assert!(0x1::option::is_some<ScallopMarketCoin<0x2::sui::SUI>>(&arg0.scallop_receipt), 2);
        arg0.deposited_amount = arg0.deposited_amount - arg1;
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut 0x1::option::borrow_mut<ScallopMarketCoin<0x2::sui::SUI>>(&mut arg0.scallop_receipt).balance, arg1), arg3)
    }

    public fun withdraw_from_suilend(arg0: &mut DeFiDepositReceipt, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.protocol == 3, 0);
        assert!(arg1 <= arg0.deposited_amount, 1);
        assert!(0x1::option::is_some<SuilendCToken<0x2::sui::SUI>>(&arg0.suilend_receipt), 2);
        let v0 = 0x1::option::borrow_mut<SuilendCToken<0x2::sui::SUI>>(&mut arg0.suilend_receipt);
        v0.shares = v0.shares - arg1;
        arg0.deposited_amount = arg0.deposited_amount - arg1;
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg3)
    }

    // decompiled from Move bytecode v6
}

