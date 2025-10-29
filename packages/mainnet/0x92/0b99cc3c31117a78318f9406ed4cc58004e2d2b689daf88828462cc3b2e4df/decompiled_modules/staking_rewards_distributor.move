module 0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::staking_rewards_distributor {
    struct StakingRewardsDistributor has key {
        id: 0x2::object::UID,
        operator: address,
        deusd_balance: 0x2::balance::Balance<0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::deusd::DEUSD>,
    }

    struct RewardsTransferred has copy, drop {
        amount: u64,
    }

    struct OperatorUpdated has copy, drop {
        new_operator: address,
        old_operator: address,
    }

    struct DeUSDDeposited has copy, drop {
        sender: address,
        amount: u64,
    }

    struct DeUSDWithdrawn has copy, drop {
        amount: u64,
        to: address,
    }

    public fun transfer_in_rewards(arg0: &mut StakingRewardsDistributor, arg1: &mut 0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::sdeusd::SdeUSDManagement, arg2: &0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::config::GlobalConfig, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::config::check_package_version(arg2);
        assert!(0x2::tx_context::sender(arg5) == arg0.operator, 1);
        assert!(0x2::balance::value<0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::deusd::DEUSD>(&arg0.deusd_balance) >= arg3, 2);
        0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::sdeusd::transfer_in_rewards(arg1, arg2, 0x2::coin::from_balance<0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::deusd::DEUSD>(0x2::balance::split<0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::deusd::DEUSD>(&mut arg0.deusd_balance, arg3), arg5), arg4, arg5);
        let v0 = RewardsTransferred{amount: arg3};
        0x2::event::emit<RewardsTransferred>(v0);
    }

    public fun deposit_deusd(arg0: &mut StakingRewardsDistributor, arg1: &0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::config::GlobalConfig, arg2: 0x2::coin::Coin<0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::deusd::DEUSD>, arg3: &0x2::tx_context::TxContext) {
        0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::config::check_package_version(arg1);
        0x2::balance::join<0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::deusd::DEUSD>(&mut arg0.deusd_balance, 0x2::coin::into_balance<0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::deusd::DEUSD>(arg2));
        let v0 = DeUSDDeposited{
            sender : 0x2::tx_context::sender(arg3),
            amount : 0x2::coin::value<0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::deusd::DEUSD>(&arg2),
        };
        0x2::event::emit<DeUSDDeposited>(v0);
    }

    public fun get_deusd_balance(arg0: &StakingRewardsDistributor) : u64 {
        0x2::balance::value<0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::deusd::DEUSD>(&arg0.deusd_balance)
    }

    public fun get_operator(arg0: &StakingRewardsDistributor) : address {
        arg0.operator
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingRewardsDistributor{
            id            : 0x2::object::new(arg0),
            operator      : @0x337f3bad574e6338551b71932c449e20c81abb371364811de3ee93b58343eb3c,
            deusd_balance : 0x2::balance::zero<0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::deusd::DEUSD>(),
        };
        0x2::transfer::share_object<StakingRewardsDistributor>(v0);
    }

    public fun set_operator(arg0: &0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::admin_cap::AdminCap, arg1: &mut StakingRewardsDistributor, arg2: &0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::config::GlobalConfig, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::config::check_package_version(arg2);
        arg1.operator = arg3;
        let v0 = OperatorUpdated{
            new_operator : arg3,
            old_operator : arg1.operator,
        };
        0x2::event::emit<OperatorUpdated>(v0);
    }

    public fun withdraw_deusd(arg0: &0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::admin_cap::AdminCap, arg1: &mut StakingRewardsDistributor, arg2: &0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::config::GlobalConfig, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::config::check_package_version(arg2);
        assert!(arg3 > 0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::deusd::DEUSD>>(0x2::coin::from_balance<0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::deusd::DEUSD>(0x2::balance::split<0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::deusd::DEUSD>(&mut arg1.deusd_balance, arg3), arg5), arg4);
        let v0 = DeUSDWithdrawn{
            amount : arg3,
            to     : arg4,
        };
        0x2::event::emit<DeUSDWithdrawn>(v0);
    }

    // decompiled from Move bytecode v6
}

