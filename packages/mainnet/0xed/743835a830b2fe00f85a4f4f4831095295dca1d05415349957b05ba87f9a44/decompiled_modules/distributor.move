module 0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::distributor {
    struct DistributorCap has store, key {
        id: 0x2::object::UID,
    }

    struct DistributorState has key {
        id: 0x2::object::UID,
        epoch: u64,
        epoch_reward: u64,
        last_halving_ms: u64,
        community_balance: u64,
        community_distributed: u64,
        claimed: 0x2::table::Table<address, u64>,
        referrals: 0x2::table::Table<address, address>,
        referral_count: 0x2::table::Table<address, u64>,
    }

    struct GenesisComplete has copy, drop {
        community: u64,
        developer: u64,
        liquidity: u64,
        reserve: u64,
        marketing: u64,
        timestamp_ms: u64,
    }

    struct RewardClaimed has copy, drop {
        recipient: address,
        amount: u64,
        epoch: u64,
        referred_by: address,
    }

    struct HalvingExecuted has copy, drop {
        epoch: u64,
        old_reward: u64,
        new_reward: u64,
        timestamp_ms: u64,
    }

    struct ReferralRegistered has copy, drop {
        user: address,
        referrer: address,
    }

    public fun claim_reward(arg0: &mut DistributorState, arg1: &mut 0x2::coin::Coin<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, u64>(&arg0.claimed, v0), 1);
        let v1 = arg0.epoch_reward;
        let v2 = if (0x2::table::contains<address, address>(&arg0.referrals, v0)) {
            *0x2::table::borrow<address, address>(&arg0.referrals, v0)
        } else {
            @0x0
        };
        let v3 = if (v2 != @0x0) {
            v1 / 10
        } else {
            0
        };
        let v4 = v1 + v3;
        assert!(arg0.community_balance >= v4, 2);
        assert!(0x2::coin::value<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(arg1) >= v4, 2);
        0x2::table::add<address, u64>(&mut arg0.claimed, v0, v4);
        arg0.community_balance = arg0.community_balance - v4;
        arg0.community_distributed = arg0.community_distributed + v4;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>>(0x2::coin::split<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(arg1, v1, arg2), v0);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>>(0x2::coin::split<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(arg1, v3, arg2), v2);
        };
        let v5 = RewardClaimed{
            recipient   : v0,
            amount      : v4,
            epoch       : arg0.epoch,
            referred_by : v2,
        };
        0x2::event::emit<RewardClaimed>(v5);
    }

    public fun community_remaining(arg0: &DistributorState) : u64 {
        arg0.community_balance
    }

    public fun epoch(arg0: &DistributorState) : u64 {
        arg0.epoch
    }

    public fun epoch_reward(arg0: &DistributorState) : u64 {
        arg0.epoch_reward
    }

    public fun genesis(arg0: &0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::AdminCap, arg1: &mut 0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::TokenConfig, arg2: address, arg3: address, arg4: address, arg5: address, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg7);
        0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::mint(arg0, arg1, 20000000000000000, arg2, arg8);
        0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::mint(arg0, arg1, 15000000000000000, arg3, arg8);
        0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::mint(arg0, arg1, 14000000000000000, arg4, arg8);
        0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::mint(arg0, arg1, 9000000000000000, arg5, arg8);
        0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::mint(arg0, arg1, 42000000000000000, 0x2::tx_context::sender(arg8), arg8);
        let v1 = DistributorState{
            id                    : 0x2::object::new(arg8),
            epoch                 : 1,
            epoch_reward          : arg6,
            last_halving_ms       : v0,
            community_balance     : 42000000000000000,
            community_distributed : 0,
            claimed               : 0x2::table::new<address, u64>(arg8),
            referrals             : 0x2::table::new<address, address>(arg8),
            referral_count        : 0x2::table::new<address, u64>(arg8),
        };
        0x2::transfer::share_object<DistributorState>(v1);
        let v2 = DistributorCap{id: 0x2::object::new(arg8)};
        0x2::transfer::public_transfer<DistributorCap>(v2, 0x2::tx_context::sender(arg8));
        let v3 = GenesisComplete{
            community    : 42000000000000000,
            developer    : 20000000000000000,
            liquidity    : 15000000000000000,
            reserve      : 14000000000000000,
            marketing    : 9000000000000000,
            timestamp_ms : v0,
        };
        0x2::event::emit<GenesisComplete>(v3);
    }

    public fun halve(arg0: &DistributorCap, arg1: &mut DistributorState, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg1.last_halving_ms + 15552000000, 3);
        let v1 = arg1.epoch_reward;
        arg1.epoch_reward = v1 / 2;
        arg1.epoch = arg1.epoch + 1;
        arg1.last_halving_ms = v0;
        let v2 = HalvingExecuted{
            epoch        : arg1.epoch,
            old_reward   : v1,
            new_reward   : arg1.epoch_reward,
            timestamp_ms : v0,
        };
        0x2::event::emit<HalvingExecuted>(v2);
    }

    public fun has_claimed(arg0: &DistributorState, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.claimed, arg1)
    }

    public fun referral_count(arg0: &DistributorState, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.referral_count, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.referral_count, arg1)
        } else {
            0
        }
    }

    public fun register_referral(arg0: &mut DistributorState, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (0x2::table::contains<address, address>(&arg0.referrals, v0)) {
            return
        };
        0x2::table::add<address, address>(&mut arg0.referrals, v0, arg1);
        if (!0x2::table::contains<address, u64>(&arg0.referral_count, arg1)) {
            0x2::table::add<address, u64>(&mut arg0.referral_count, arg1, 1);
        } else {
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.referral_count, arg1);
            *v1 = *v1 + 1;
        };
        let v2 = ReferralRegistered{
            user     : v0,
            referrer : arg1,
        };
        0x2::event::emit<ReferralRegistered>(v2);
    }

    // decompiled from Move bytecode v7
}

