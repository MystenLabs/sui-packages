module 0x86a49ea50f3f7fb32c083bcf4e0de706d769657e25b687f7bb1867ad75e37417::fee_collector {
    struct FeeCollector has key {
        id: 0x2::object::UID,
        platform_treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        fee_share_bps: u64,
    }

    struct FeesDistributed has copy, drop {
        total_amount: u64,
        platform_share: u64,
        creator_share: u64,
        creator_address: address,
        contract_source: address,
    }

    struct PlatformFeesWithdrawn has copy, drop {
        amount: u64,
        withdrawn_to: address,
    }

    public fun collect_and_distribute_fees(arg0: &mut FeeCollector, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        if (v0 < 100) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg3), arg2);
            let v2 = FeesDistributed{
                total_amount    : v0,
                platform_share  : 0,
                creator_share   : v0,
                creator_address : arg2,
                contract_source : 0x2::tx_context::sender(arg3),
            };
            0x2::event::emit<FeesDistributed>(v2);
            return
        };
        let v3 = v0 * (10000 - arg0.fee_share_bps) / 10000;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.platform_treasury, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v3));
        if (0x2::balance::value<0x2::sui::SUI>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg3), arg2);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        };
        let v4 = FeesDistributed{
            total_amount    : v0,
            platform_share  : v3,
            creator_share   : v0 - v3,
            creator_address : arg2,
            contract_source : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<FeesDistributed>(v4);
    }

    public fun get_fee_share_bps(arg0: &FeeCollector) : u64 {
        arg0.fee_share_bps
    }

    public fun get_platform_treasury_balance(arg0: &FeeCollector) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.platform_treasury)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeCollector{
            id                : 0x2::object::new(arg0),
            platform_treasury : 0x2::balance::zero<0x2::sui::SUI>(),
            fee_share_bps     : 5000,
        };
        0x2::transfer::share_object<FeeCollector>(v0);
    }

    public fun update_fee_share(arg0: &mut FeeCollector, arg1: &0x86a49ea50f3f7fb32c083bcf4e0de706d769657e25b687f7bb1867ad75e37417::admin::DropkitAdminCap, arg2: u64) {
        assert!(arg2 <= 10000, 3);
        arg0.fee_share_bps = arg2;
    }

    public fun withdraw_platform_fees(arg0: &mut FeeCollector, arg1: &0x86a49ea50f3f7fb32c083bcf4e0de706d769657e25b687f7bb1867ad75e37417::admin::DropkitAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.platform_treasury) >= arg2, 1);
        let v0 = PlatformFeesWithdrawn{
            amount       : arg2,
            withdrawn_to : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<PlatformFeesWithdrawn>(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.platform_treasury, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

