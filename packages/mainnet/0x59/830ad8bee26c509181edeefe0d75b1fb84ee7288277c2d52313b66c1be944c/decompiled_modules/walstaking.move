module 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking {
    struct Staking has key {
        id: 0x2::object::UID,
        version: u64,
        config: 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::config::StakingConfig,
        wal_vault: 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::vault::Vault<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>,
        protocol_wal_vault: 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::vault::Vault<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>,
        hawal_treasury_cap: 0x2::coin::TreasuryCap<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL>,
        total_staked: u64,
        total_unstaked: u64,
        total_rewards: u64,
        unclaimed_wal_amount: u64,
        collected_protocol_fees: u64,
        collected_protocol_fees_pending: u64,
        uncollected_protocol_fees: u64,
        hawal_supply: u64,
        pause_stake: bool,
        pause_unstake: bool,
        active_validators: vector<0x2::object::ID>,
        validators: vector<0x2::object::ID>,
        pools: 0x2::table::Table<0x2::object::ID, PoolInfo>,
        rewards_last_updated_epoch: u64,
    }

    struct PoolInfo has store {
        staked: 0x2::vec_map::VecMap<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>,
        withdrawing: 0x2::vec_map::VecMap<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>,
        total_staked: u64,
        rewards: u64,
    }

    struct UnstakeTicket has key {
        id: 0x2::object::UID,
        unstake_timestamp_ms: u64,
        hawal_amount: u64,
        wal_amount: u64,
        claim_epoch: u32,
        claim_timestamp_ms: u64,
    }

    struct UserStaked has copy, drop {
        owner: address,
        wal_amount: u64,
        hawal_amount: u64,
        validator: 0x2::object::ID,
    }

    struct UserNormalUnstaked has copy, drop {
        owner: address,
        epoch: u32,
        epoch_timestamp_ms: u64,
        unstake_timestamp_ms: u64,
        wal_amount: u64,
        hawal_amount: u64,
    }

    struct UserClaimed has copy, drop {
        id: 0x2::object::ID,
        owner: address,
        wal_amount: u64,
    }

    struct SystemStaked has copy, drop {
        staked_wal_id: 0x2::object::ID,
        epoch: u64,
        wal_amount: u64,
        validator: 0x2::object::ID,
    }

    struct WalRewardsUpdated has copy, drop {
        old: u64,
        new: u64,
        fee: u64,
    }

    struct RequestRewardsFeeCollected has copy, drop {
        owner: address,
        epoch: u32,
        wal_amount: u64,
    }

    struct RewardsFeeCollected has copy, drop {
        owner: address,
        wal_amount: u64,
    }

    struct PoolSystemUnstaked has copy, drop {
        validator: 0x2::object::ID,
        epoch: u32,
        wal_amount: u64,
    }

    struct PoolSystemClaim has copy, drop {
        validator: 0x2::object::ID,
        epoch: u32,
        wal_amount: u64,
    }

    struct VersionUpdated has copy, drop {
        old: u64,
        new: u64,
    }

    struct ExchangeRateUpdated has copy, drop {
        old: u64,
        new: u64,
    }

    struct UserInstantUnstaked has copy, drop {
        owner: address,
        wal_amount: u64,
        hawal_amount: u64,
    }

    struct UpdateValidatorOffline has copy, drop {
        validator: 0x2::object::ID,
        new_validator: 0x2::object::ID,
        total_staked: u64,
        total_withdrawing: u64,
    }

    struct WALSTAKING has drop {
        dummy_field: bool,
    }

    public fun assert_version(arg0: &Staking) {
        assert!(arg0.version == 0, 1);
    }

    fun calculate_staked_wal_rewards(arg0: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal, arg2: u32) : u64 {
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::calculate_rewards(arg0, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::node_id(arg1), 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::value(arg1), 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::activation_epoch(arg1), arg2)
    }

    fun calculate_validator_pool_rewards_increase(arg0: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg1: &mut PoolInfo, arg2: u32) : u64 {
        let v0 = 0;
        let v1 = 0x2::vec_map::keys<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&arg1.staked);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u32>(&v1)) {
            let v3 = *0x1::vector::borrow<u32>(&v1, v2);
            v0 = v0 + calculate_staked_wal_rewards(arg0, 0x2::vec_map::get<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&arg1.staked, &v3), arg2);
            v2 = v2 + 1;
        };
        let v4 = 0x2::vec_map::keys<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&arg1.withdrawing);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u32>(&v4)) {
            let v6 = *0x1::vector::borrow<u32>(&v4, v5);
            let v7 = 0x2::vec_map::get<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&arg1.withdrawing, &v6);
            let v8 = if (0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::withdraw_epoch(v7) < arg2) {
                0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::withdraw_epoch(v7)
            } else {
                arg2
            };
            v0 = v0 + calculate_staked_wal_rewards(arg0, v7, v8);
            v5 = v5 + 1;
        };
        let v9 = 0;
        if (v0 > arg1.rewards) {
            v9 = v0 - arg1.rewards;
            arg1.rewards = v0;
        };
        v9
    }

    public(friend) fun claim_collect_protocol_fee(arg0: &mut Staking, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::vault::vault_amount<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.protocol_wal_vault) > 0, 13906838190137802751);
        let v0 = 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::vault::withdraw_all<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.protocol_wal_vault);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v0, arg2), arg1);
        let v1 = RewardsFeeCollected{
            owner      : arg1,
            wal_amount : 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v0),
        };
        0x2::event::emit<RewardsFeeCollected>(v1);
    }

    public(friend) fun claim_collect_rewards_fee(arg0: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: &mut Staking, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::vault::withdraw_max<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg2.wal_vault, arg2.uncollected_protocol_fees);
        let v2 = v0;
        let (v3, v4) = do_unstake_instant(arg0, arg1, arg2, v1, arg4);
        if (v4 > 0) {
            arg2.uncollected_protocol_fees = v4;
        } else {
            arg2.uncollected_protocol_fees = 0;
        };
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut v2, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v2, arg4), arg3);
        let v5 = RewardsFeeCollected{
            owner      : arg3,
            wal_amount : 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v2),
        };
        0x2::event::emit<RewardsFeeCollected>(v5);
    }

    fun combine_epochs(arg0: u32, arg1: u32) : u32 {
        let v0 = 65535;
        (arg0 & v0) << 16 | arg1 & v0
    }

    fun do_unstake_instant(arg0: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: &mut Staking, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, u64) {
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg0);
        let v1 = arg2.validators;
        let v2 = 0;
        let v3 = 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>();
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1) && arg3 > 0) {
            let v4 = *0x1::vector::borrow<0x2::object::ID>(&v1, v2);
            v2 = v2 + 1;
            if (!0x2::table::contains<0x2::object::ID, PoolInfo>(&arg2.pools, v4)) {
                continue
            };
            let v5 = 0;
            let v6 = 0x2::table::borrow_mut<0x2::object::ID, PoolInfo>(&mut arg2.pools, v4);
            let v7 = 0x2::vec_map::keys<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&v6.staked);
            let v8 = 0;
            while (v8 < 0x1::vector::length<u32>(&v7)) {
                let v9 = *0x1::vector::borrow<u32>(&v7, v8);
                let v10 = 0x2::vec_map::get_mut<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&mut v6.staked, &v9);
                if (0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::can_withdraw_staked_wal_early(arg1, v10)) {
                    let (v11, v12) = get_split_wal_amount(arg1, v10, arg3, v0);
                    let v13 = if (v11 > 0) {
                        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::split(v10, v12, arg4)
                    } else {
                        let (_, v15) = 0x2::vec_map::remove<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&mut v6.staked, &v9);
                        v15
                    };
                    let v16 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::withdraw_stake(arg1, v13, arg4);
                    let v17 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v16);
                    v5 = v5 + v17;
                    if (v17 <= arg3) {
                        arg3 = arg3 - v17;
                        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut v3, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v16));
                    } else {
                        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut v3, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::coin::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut v16, arg3, arg4)));
                        0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::vault::deposit<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg2.wal_vault, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v16));
                        arg3 = 0;
                    };
                };
                v8 = v8 + 1;
            };
            if (arg3 != arg3) {
                let v18 = PoolSystemUnstaked{
                    validator  : v4,
                    epoch      : v0,
                    wal_amount : v5,
                };
                0x2::event::emit<PoolSystemUnstaked>(v18);
            };
        };
        (v3, arg3)
    }

    public(friend) fun do_validator_offline(arg0: &mut Staking, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<0x2::object::ID, PoolInfo>(&arg0.pools, arg3)) {
            return
        };
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg0.active_validators, &arg3);
        if (v0) {
            0x1::vector::remove<0x2::object::ID>(&mut arg0.active_validators, v1);
        };
        let v2 = get_min_total_validator(arg0);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg1);
        let v3 = 0x2::table::borrow_mut<0x2::object::ID, PoolInfo>(&mut arg0.pools, arg3);
        let v4 = 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>();
        let v5 = 0x2::vec_map::keys<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&v3.staked);
        let v6 = 0;
        while (v6 < 0x1::vector::length<u32>(&v5)) {
            let v7 = *0x1::vector::borrow<u32>(&v5, v6);
            let (_, v9) = 0x2::vec_map::remove<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&mut v3.staked, &v7);
            0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut v4, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::withdraw_stake(arg2, v9, arg4)));
            v6 = v6 + 1;
        };
        let v10 = 0;
        let v11 = 0x2::vec_map::keys<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&v3.withdrawing);
        let v12 = 0;
        while (v12 < 0x1::vector::length<u32>(&v11)) {
            let v13 = *0x1::vector::borrow<u32>(&v11, v12);
            let (_, v15) = 0x2::vec_map::remove<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&mut v3.withdrawing, &v13);
            let v16 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::withdraw_stake(arg2, v15, arg4);
            v10 = v10 + 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v16);
            0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::vault::deposit<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.wal_vault, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v16));
            v12 = v12 + 1;
        };
        let (_, v18) = 0x1::vector::index_of<0x2::object::ID>(&arg0.validators, &arg3);
        0x1::vector::remove<0x2::object::ID>(&mut arg0.validators, v18);
        let PoolInfo {
            staked       : v19,
            withdrawing  : v20,
            total_staked : _,
            rewards      : _,
        } = 0x2::table::remove<0x2::object::ID, PoolInfo>(&mut arg0.pools, arg3);
        0x2::vec_map::destroy_empty<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(v19);
        0x2::vec_map::destroy_empty<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(v20);
        let v23 = 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v4);
        if (v23 > 0) {
            stake_to_validator(v4, arg0, arg2, v2, arg4);
        } else {
            0x2::balance::destroy_zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v4);
        };
        let v24 = UpdateValidatorOffline{
            validator         : arg3,
            new_validator     : v2,
            total_staked      : v23,
            total_withdrawing : v10,
        };
        0x2::event::emit<UpdateValidatorOffline>(v24);
    }

    fun do_validator_request_withdraw(arg0: &mut Staking, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: 0x2::object::ID, arg3: u64, arg4: u32, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        if (!0x2::table::contains<0x2::object::ID, PoolInfo>(&arg0.pools, arg2)) {
            return arg3
        };
        let v0 = 0;
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, PoolInfo>(&mut arg0.pools, arg2);
        let v2 = 0x2::vec_map::keys<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&v1.staked);
        let v3 = 0;
        while (arg3 > 0 && v3 < 0x1::vector::length<u32>(&v2)) {
            let v4 = *0x1::vector::borrow<u32>(&v2, v3);
            if (v4 <= arg4) {
                let v5 = 0x2::vec_map::get_mut<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&mut v1.staked, &v4);
                let (v6, v7) = get_split_wal_amount(arg1, v5, arg3, arg4);
                let v8 = if (v6 > 0) {
                    0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::split(v5, v7, arg5)
                } else {
                    let (_, v10) = 0x2::vec_map::remove<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&mut v1.staked, &v4);
                    v10
                };
                let v11 = v8;
                let v12 = 0;
                if (0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::can_withdraw_staked_wal_early(arg1, &v11)) {
                    0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::vault::deposit<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.wal_vault, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::withdraw_stake(arg1, v11, arg5)));
                } else {
                    0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::request_withdraw_stake(arg1, &mut v11, arg5);
                    let v13 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::withdraw_epoch(&v11);
                    v12 = calculate_staked_wal_rewards(arg1, &v11, v13);
                    let v14 = combine_epochs(v13, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::activation_epoch(&v11));
                    if (0x2::vec_map::contains<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&v1.withdrawing, &v13)) {
                        let v15 = 0x2::vec_map::get_mut<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&mut v1.withdrawing, &v13);
                        if (is_same_epochs(v15, &v11)) {
                            0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::join(v15, v11);
                        } else if (0x2::vec_map::contains<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&v1.withdrawing, &v14)) {
                            0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::join(0x2::vec_map::get_mut<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&mut v1.withdrawing, &v14), v11);
                        } else {
                            0x2::vec_map::insert<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&mut v1.withdrawing, v14, v11);
                        };
                    } else if (0x2::vec_map::contains<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&v1.withdrawing, &v14)) {
                        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::join(0x2::vec_map::get_mut<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&mut v1.withdrawing, &v14), v11);
                    } else {
                        0x2::vec_map::insert<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&mut v1.withdrawing, v14, v11);
                    };
                };
                let v16 = v0 + v7;
                v0 = v16 + v12;
                if (v7 + v12 <= arg3) {
                    let v17 = arg3 - v7;
                    arg3 = v17 - v12;
                } else {
                    arg3 = 0;
                };
            };
            v3 = v3 + 1;
        };
        if (arg3 != arg3) {
            let v18 = PoolSystemUnstaked{
                validator  : arg2,
                epoch      : arg4,
                wal_amount : v0,
            };
            0x2::event::emit<PoolSystemUnstaked>(v18);
        };
        arg3
    }

    fun do_validator_withdraw(arg0: &mut Staking, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: &mut 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg3: 0x2::object::ID, arg4: u64, arg5: u32, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        if (!0x2::table::contains<0x2::object::ID, PoolInfo>(&arg0.pools, arg3)) {
            return arg4
        };
        let v0 = 0;
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, PoolInfo>(&mut arg0.pools, arg3);
        let v2 = 0x2::vec_map::keys<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&v1.withdrawing);
        let v3 = 0;
        while (arg4 > 0 && v3 < 0x1::vector::length<u32>(&v2)) {
            let v4 = *0x1::vector::borrow<u32>(&v2, v3);
            let v5 = 0x2::vec_map::get_mut<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&mut v1.withdrawing, &v4);
            let v6 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::withdraw_epoch(v5);
            if (0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::is_withdrawing(v5) && v6 <= arg5) {
                let v7 = if (arg4 > 1000000000 && arg4 + 1000000000 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::value(v5)) {
                    0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::split(v5, arg4, arg6)
                } else {
                    let (_, v9) = 0x2::vec_map::remove<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&mut v1.withdrawing, &v4);
                    v9
                };
                let v10 = v7;
                let v11 = calculate_staked_wal_rewards(arg1, &v10, v6);
                let v12 = 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::withdraw_stake(arg1, v10, arg6));
                v1.total_staked = v1.total_staked - 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::value(&v10);
                if (v1.rewards >= v11) {
                    v1.rewards = v1.rewards - v11;
                } else {
                    v1.rewards = 0;
                };
                let v13 = 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v12);
                0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg2, v12);
                v0 = v0 + v13;
                if (v13 <= arg4) {
                    arg4 = arg4 - v13;
                    v3 = v3 + 1;
                } else {
                    arg4 = 0;
                    break
                };
            } else {
                break
            };
        };
        if (arg4 != arg4) {
            let v14 = PoolSystemClaim{
                validator  : arg3,
                epoch      : arg5,
                wal_amount : v0,
            };
            0x2::event::emit<PoolSystemClaim>(v14);
        };
        arg4
    }

    public fun get_collected_protocol_fees(arg0: &Staking) : u64 {
        arg0.collected_protocol_fees
    }

    public fun get_config_mut(arg0: &mut Staking) : &mut 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::config::StakingConfig {
        assert_version(arg0);
        &mut arg0.config
    }

    fun get_epoch_time_info(arg0: &mut Staking, arg1: u32) : (u64, u64, u64, u64) {
        assert!(arg1 > 0, 9);
        let v0 = get_config_mut(arg0);
        let v1 = 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::config::get_walrus_start_epoch(v0);
        let v2 = 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::config::get_walrus_start_timestamp_ms(v0);
        let v3 = 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::config::get_walrus_epoch_duration(v0);
        assert!(v2 > 0 && v3 > 0, 9);
        assert!(arg1 >= v1, 9);
        let v4 = v2 + ((arg1 - v1) as u64) * v3;
        (v4, v4 + v3 / 2, v4 + v3, v3)
    }

    public fun get_epoch_time_ms_and_epoch(arg0: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg1: &mut Staking) : (u64, u64, u64, u64, u32) {
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg0);
        let (v1, v2, v3, v4) = get_epoch_time_info(arg1, v0);
        (v1, v2, v3, v4, v0)
    }

    public fun get_exchange_rate(arg0: &Staking) : u64 {
        let v0 = get_total_wal(arg0);
        if (v0 == 0 || arg0.hawal_supply == 0) {
            return 1000000
        };
        (((v0 as u128) * (1000000 as u128) / (arg0.hawal_supply as u128)) as u64)
    }

    public fun get_hawal_by_wal(arg0: &Staking, arg1: u64) : u64 {
        let v0 = get_total_wal(arg0);
        if (v0 == 0 || arg0.hawal_supply == 0) {
            return arg1
        };
        (((arg0.hawal_supply as u128) * (arg1 as u128) / (v0 as u128)) as u64)
    }

    public fun get_hawal_supply(arg0: &Staking) : u64 {
        arg0.hawal_supply
    }

    fun get_min_total_validator(arg0: &Staking) : 0x2::object::ID {
        let v0 = arg0.active_validators;
        let v1 = 0x1::vector::length<0x2::object::ID>(&v0);
        assert!(v1 > 0, 15);
        let v2 = 0;
        let v3 = *0x1::vector::borrow<0x2::object::ID>(&v0, 0);
        let v4 = false;
        while (v2 < v1) {
            let v5 = *0x1::vector::borrow<0x2::object::ID>(&v0, v2);
            if (!0x2::table::contains<0x2::object::ID, PoolInfo>(&arg0.pools, v5)) {
                v3 = v5;
                v4 = true;
                break
            };
            v2 = v2 + 1;
        };
        if (!v4) {
            let v6 = 1;
            let v7 = 0x2::table::borrow<0x2::object::ID, PoolInfo>(&arg0.pools, *0x1::vector::borrow<0x2::object::ID>(&v0, 0)).total_staked;
            v3 = *0x1::vector::borrow<0x2::object::ID>(&v0, 0);
            while (v6 < v1) {
                let v8 = *0x1::vector::borrow<0x2::object::ID>(&v0, v6);
                let v9 = 0x2::table::borrow<0x2::object::ID, PoolInfo>(&arg0.pools, v8);
                if (v9.total_staked < v7) {
                    v3 = v8;
                    v7 = v9.total_staked;
                };
                v6 = v6 + 1;
            };
        };
        v3
    }

    public fun get_protocol_wal_vault_amount(arg0: &Staking) : u64 {
        0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::vault::vault_amount<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.protocol_wal_vault)
    }

    fun get_split_wal_amount(arg0: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal, arg2: u64, arg3: u32) : (u64, u64) {
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::value(arg1);
        let v1 = v0 + calculate_staked_wal_rewards(arg0, arg1, arg3);
        if (v1 <= arg2) {
            (0, v0)
        } else {
            let v4 = mul_div(arg2, v0, v1) + 1;
            let v5 = v4;
            let v6 = if (v0 >= v4) {
                v0 - v4
            } else {
                v5 = v0;
                0
            };
            if (v5 >= 1000000000) {
                if (v6 >= 1000000000) {
                    (v6, v5)
                } else {
                    (0, v0)
                }
            } else if (v0 >= 2 * 1000000000) {
                (v0 - 1000000000, 1000000000)
            } else {
                (0, v0)
            }
        }
    }

    public fun get_staked_pools(arg0: &mut Staking, arg1: 0x2::object::ID) : &mut PoolInfo {
        assert!(0x2::table::contains<0x2::object::ID, PoolInfo>(&arg0.pools, arg1), 13906839719146160127);
        0x2::table::borrow_mut<0x2::object::ID, PoolInfo>(&mut arg0.pools, arg1)
    }

    public fun get_staked_validator(arg0: &Staking, arg1: 0x2::object::ID) : bool {
        0x1::vector::contains<0x2::object::ID>(&arg0.validators, &arg1)
    }

    public fun get_staked_validators(arg0: &Staking) : vector<0x2::object::ID> {
        arg0.validators
    }

    public fun get_total_instant_unstake_wal(arg0: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: &Staking) : u64 {
        let v0 = 0;
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg0);
        let v1 = arg2.validators;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&v1, v2);
            v2 = v2 + 1;
            if (!0x2::table::contains<0x2::object::ID, PoolInfo>(&arg2.pools, v3)) {
                continue
            };
            let v4 = 0x2::table::borrow<0x2::object::ID, PoolInfo>(&arg2.pools, v3);
            let v5 = 0x2::vec_map::keys<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&v4.staked);
            let v6 = 0;
            while (v6 < 0x1::vector::length<u32>(&v5)) {
                let v7 = *0x1::vector::borrow<u32>(&v5, v6);
                let v8 = 0x2::vec_map::get<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&v4.staked, &v7);
                if (0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::can_withdraw_staked_wal_early(arg1, v8)) {
                    v0 = v0 + 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::value(v8);
                };
                v6 = v6 + 1;
            };
        };
        v0
    }

    public fun get_total_rewards(arg0: &Staking) : u64 {
        arg0.total_rewards
    }

    public fun get_total_staked(arg0: &Staking) : u64 {
        arg0.total_staked
    }

    public fun get_total_unstaked(arg0: &Staking) : u64 {
        arg0.total_unstaked
    }

    public fun get_total_wal(arg0: &Staking) : u64 {
        arg0.total_staked + arg0.total_rewards - arg0.collected_protocol_fees - arg0.uncollected_protocol_fees - arg0.total_unstaked
    }

    public fun get_total_wal_cap(arg0: &Staking) : u64 {
        get_total_wal(arg0) + arg0.unclaimed_wal_amount
    }

    public fun get_unclaimed_wal_amount(arg0: &Staking) : u64 {
        arg0.unclaimed_wal_amount
    }

    public fun get_uncollected_protocol_fees(arg0: &Staking) : u64 {
        arg0.uncollected_protocol_fees
    }

    public fun get_version(arg0: &Staking) : u64 {
        arg0.version
    }

    public fun get_wal_by_hawal(arg0: &Staking, arg1: u64) : u64 {
        let v0 = get_total_wal(arg0);
        if (v0 == 0 || arg0.hawal_supply == 0) {
            return arg1
        };
        (((v0 as u128) * (arg1 as u128) / (arg0.hawal_supply as u128)) as u64)
    }

    public fun get_wal_vault_amount(arg0: &Staking) : u64 {
        0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::vault::vault_amount<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.wal_vault)
    }

    fun init(arg0: WALSTAKING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<WALSTAKING>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Hawal-UnstakeTicket"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://assets.haedal.xyz/logos/hawal.svg"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"To Claim your WAL"));
        let v5 = 0x2::display::new_with_fields<UnstakeTicket>(&v0, v1, v3, arg1);
        0x2::display::update_version<UnstakeTicket>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<UnstakeTicket>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun initialize(arg0: 0x2::coin::TreasuryCap<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Staking{
            id                              : 0x2::object::new(arg1),
            version                         : 0,
            config                          : 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::config::new(0, 600000, 0, 900000, 72000000, 10, 1, 1742914804744, 1209600000),
            wal_vault                       : 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::vault::new<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg1),
            protocol_wal_vault              : 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::vault::new<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg1),
            hawal_treasury_cap              : arg0,
            total_staked                    : 0,
            total_unstaked                  : 0,
            total_rewards                   : 0,
            unclaimed_wal_amount            : 0,
            collected_protocol_fees         : 0,
            collected_protocol_fees_pending : 0,
            uncollected_protocol_fees       : 0,
            hawal_supply                    : 0,
            pause_stake                     : false,
            pause_unstake                   : false,
            active_validators               : 0x1::vector::empty<0x2::object::ID>(),
            validators                      : 0x1::vector::empty<0x2::object::ID>(),
            pools                           : 0x2::table::new<0x2::object::ID, PoolInfo>(arg1),
            rewards_last_updated_epoch      : 0,
        };
        0x2::transfer::share_object<Staking>(v0);
    }

    fun is_same_epochs(arg0: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal) : bool {
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::withdraw_epoch(arg0) == 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::withdraw_epoch(arg1) && 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::activation_epoch(arg0) == 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::activation_epoch(arg1)
    }

    public(friend) fun migrate(arg0: &mut Staking) {
        assert!(arg0.version < 0, 1);
        let v0 = VersionUpdated{
            old : arg0.version,
            new : 0,
        };
        0x2::event::emit<VersionUpdated>(v0);
        arg0.version = 0;
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun query_pause_claim(arg0: &Staking) : bool {
        if (0x2::dynamic_field::exists_with_type<vector<u8>, bool>(&arg0.id, b"pause_claim_key")) {
            return *0x2::dynamic_field::borrow<vector<u8>, bool>(&arg0.id, b"pause_claim_key")
        };
        false
    }

    public fun request_stake_coin(arg0: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg1: &mut Staking, arg2: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL> {
        assert_version(arg1);
        assert!(!arg1.pause_stake, 7);
        let v0 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg2);
        assert!(v0 >= 1000000000, 2);
        assert!(0x1::vector::length<0x2::object::ID>(&arg1.active_validators) > 0, 13);
        let v1 = get_hawal_by_wal(arg1, v0);
        assert!(v1 > 0, 3);
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = 0x2::coin::mint<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL>(&mut arg1.hawal_treasury_cap, v1, arg4);
        if (arg3 == 0x2::object::id_from_address(@0x0)) {
            let v4 = get_min_total_validator(arg1);
            stake_to_validator(0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg2), arg1, arg0, v4, arg4);
        } else {
            stake_to_validator(0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg2), arg1, arg0, arg3, arg4);
        };
        arg1.total_staked = arg1.total_staked + v0;
        arg1.hawal_supply = 0x2::coin::total_supply<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL>(&arg1.hawal_treasury_cap);
        let v5 = UserStaked{
            owner        : v2,
            wal_amount   : v0,
            hawal_amount : v1,
            validator    : arg3,
        };
        0x2::event::emit<UserStaked>(v5);
        v3
    }

    public fun request_unstake_instant(arg0: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: &mut Staking, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL> {
        assert_version(arg2);
        assert!(!arg2.pause_unstake, 8);
        let v0 = 0x2::coin::value<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL>(&arg4);
        assert!(v0 > 0, 6);
        let v1 = get_wal_by_hawal(arg2, v0);
        assert!(v1 >= 1000000000, 16);
        assert!(v1 <= get_total_wal(arg2), 5);
        let (v2, v3) = do_unstake_instant(arg0, arg1, arg2, v1, arg5);
        let v4 = v2;
        assert!(v3 == 0, 9);
        let v5 = (((v1 as u128) * (0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::config::get_service_fee(&arg2.config) as u128) / (10000000 as u128)) as u64);
        if (v5 > 0) {
            0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::vault::deposit<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg2.protocol_wal_vault, 0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut v4, v5));
        };
        0x2::coin::burn<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL>(&mut arg2.hawal_treasury_cap, arg4);
        let v6 = UserInstantUnstaked{
            owner        : 0x2::tx_context::sender(arg5),
            wal_amount   : v1,
            hawal_amount : v0,
        };
        0x2::event::emit<UserInstantUnstaked>(v6);
        arg2.total_unstaked = arg2.total_unstaked + v1;
        arg2.hawal_supply = 0x2::coin::total_supply<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL>(&arg2.hawal_treasury_cap);
        0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v4, arg5)
    }

    public fun request_withdraw_stake(arg0: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: &mut Staking, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL>, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg2);
        assert!(!arg2.pause_unstake, 8);
        let v0 = 0x2::coin::value<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL>(&arg4);
        assert!(v0 > 0, 6);
        let v1 = get_wal_by_hawal(arg2, v0);
        assert!(v1 >= 1000000000, 16);
        assert!(v1 <= get_total_wal(arg2), 5);
        let v2 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg0);
        let v3 = 0x2::clock::timestamp_ms(arg3);
        let (v4, v5, v6, v7) = get_epoch_time_info(arg2, v2);
        assert!(v3 >= v4 && v3 <= v6, 14);
        let v8 = v2 + 1;
        let v9 = v8;
        let v10 = v4 + v7;
        let v11 = v10;
        if (v3 > v5) {
            v9 = v8 + 1;
            v11 = v10 + v7;
        };
        let v12 = UnstakeTicket{
            id                   : 0x2::object::new(arg5),
            unstake_timestamp_ms : v3,
            hawal_amount         : v0,
            wal_amount           : v1,
            claim_epoch          : v9,
            claim_timestamp_ms   : v11,
        };
        let v13 = 0x2::tx_context::sender(arg5);
        0x2::transfer::transfer<UnstakeTicket>(v12, v13);
        0x2::coin::burn<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL>(&mut arg2.hawal_treasury_cap, arg4);
        let v14 = UserNormalUnstaked{
            owner                : v13,
            epoch                : v9,
            epoch_timestamp_ms   : v11,
            unstake_timestamp_ms : v3,
            wal_amount           : v1,
            hawal_amount         : v0,
        };
        0x2::event::emit<UserNormalUnstaked>(v14);
        arg2.total_unstaked = arg2.total_unstaked + v1;
        arg2.hawal_supply = 0x2::coin::total_supply<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL>(&arg2.hawal_treasury_cap);
        arg2.unclaimed_wal_amount = arg2.unclaimed_wal_amount + v1;
        let v15 = arg2.validators;
        let v16 = v1;
        let v17 = 0;
        while (v17 < 0x1::vector::length<0x2::object::ID>(&v15) && v16 > 0) {
            v16 = do_validator_request_withdraw(arg2, arg1, *0x1::vector::borrow<0x2::object::ID>(&v15, v17), v16, v9, arg5);
            v17 = v17 + 1;
        };
        assert!(v16 == 0, 9);
    }

    public(friend) fun set_active_validators(arg0: &mut Staking, arg1: vector<0x2::object::ID>) {
        arg0.active_validators = arg1;
    }

    public(friend) fun sort_validators(arg0: &mut Staking, arg1: vector<0x2::object::ID>) {
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg0.validators);
        assert!(0x1::vector::length<0x2::object::ID>(&arg1) == v0, 11);
        let v1 = 0;
        while (v1 < v0) {
            assert!(0x1::vector::contains<0x2::object::ID>(&arg1, 0x1::vector::borrow<0x2::object::ID>(&arg0.validators, v1)), 12);
            v1 = v1 + 1;
        };
        arg0.validators = arg1;
    }

    fun stake_to_validator(arg0: 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg1: &mut Staking, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<0x2::object::ID, PoolInfo>(&arg1.pools, arg3)) {
            let v0 = PoolInfo{
                staked       : 0x2::vec_map::empty<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(),
                withdrawing  : 0x2::vec_map::empty<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(),
                total_staked : 0,
                rewards      : 0,
            };
            0x2::table::add<0x2::object::ID, PoolInfo>(&mut arg1.pools, arg3, v0);
            0x1::vector::push_back<0x2::object::ID>(&mut arg1.validators, arg3);
        };
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, PoolInfo>(&mut arg1.pools, arg3);
        let v2 = 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0);
        v1.total_staked = v1.total_staked + v2;
        let v3 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::stake_with_pool(arg2, 0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg0, arg4), arg3, arg4);
        let v4 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::activation_epoch(&v3);
        if (0x2::vec_map::contains<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&v1.staked, &v4)) {
            0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::join(0x2::vec_map::get_mut<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&mut v1.staked, &v4), v3);
        } else {
            0x2::vec_map::insert<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&mut v1.staked, v4, v3);
        };
        let v5 = SystemStaked{
            staked_wal_id : 0x2::object::id<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&v3),
            epoch         : 0x2::tx_context::epoch(arg4),
            wal_amount    : v2,
            validator     : arg3,
        };
        0x2::event::emit<SystemStaked>(v5);
    }

    public fun ticket_claim_epoch(arg0: &UnstakeTicket) : u32 {
        arg0.claim_epoch
    }

    public fun ticket_claim_timestamp_ms(arg0: &UnstakeTicket) : u64 {
        arg0.claim_timestamp_ms
    }

    public fun ticket_hawal_amount(arg0: &UnstakeTicket) : u64 {
        arg0.hawal_amount
    }

    public fun ticket_unstake_timestamp_ms(arg0: &UnstakeTicket) : u64 {
        arg0.unstake_timestamp_ms
    }

    public fun ticket_wal_amount(arg0: &UnstakeTicket) : u64 {
        arg0.wal_amount
    }

    public(friend) fun toggle_claim(arg0: &mut Staking, arg1: bool) {
        if (!0x2::dynamic_field::exists_with_type<vector<u8>, bool>(&arg0.id, b"pause_claim_key")) {
            0x2::dynamic_field::add<vector<u8>, bool>(&mut arg0.id, b"pause_claim_key", arg1);
        } else {
            *0x2::dynamic_field::borrow_mut<vector<u8>, bool>(&mut arg0.id, b"pause_claim_key") = arg1;
        };
    }

    public(friend) fun toggle_stake(arg0: &mut Staking, arg1: bool) {
        arg0.pause_stake = arg1;
    }

    public(friend) fun toggle_unstake(arg0: &mut Staking, arg1: bool) {
        arg0.pause_unstake = arg1;
    }

    public(friend) fun update_validator_rewards(arg0: &mut Staking, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<0x2::object::ID, PoolInfo>(&arg0.pools, arg3)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, PoolInfo>(&mut arg0.pools, arg3);
        let v1 = 0 + calculate_validator_pool_rewards_increase(arg2, v0, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg1));
        let v2 = (((v1 as u128) * (0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::config::get_reward_fee(&arg0.config) as u128) / (10000000 as u128)) as u64);
        arg0.uncollected_protocol_fees = arg0.uncollected_protocol_fees + v2;
        arg0.total_rewards = arg0.total_rewards + v1;
        let v3 = WalRewardsUpdated{
            old : arg0.total_rewards,
            new : arg0.total_rewards,
            fee : v2,
        };
        0x2::event::emit<WalRewardsUpdated>(v3);
        let v4 = ExchangeRateUpdated{
            old : get_exchange_rate(arg0),
            new : get_exchange_rate(arg0),
        };
        0x2::event::emit<ExchangeRateUpdated>(v4);
    }

    public fun withdraw_stake(arg0: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: &mut Staking, arg3: &0x2::clock::Clock, arg4: UnstakeTicket, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL> {
        assert_version(arg2);
        assert!(!query_pause_claim(arg2), 10);
        let UnstakeTicket {
            id                   : v0,
            unstake_timestamp_ms : _,
            hawal_amount         : _,
            wal_amount           : v3,
            claim_epoch          : v4,
            claim_timestamp_ms   : v5,
        } = arg4;
        let v6 = v0;
        0x2::object::delete(v6);
        assert!(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg0) >= v4, 4);
        assert!(0x2::clock::timestamp_ms(arg3) >= v5, 4);
        let v7 = withdraw_wal_bal(arg0, arg1, arg2, v3, arg5);
        arg2.unclaimed_wal_amount = arg2.unclaimed_wal_amount - v3;
        let v8 = UserClaimed{
            id         : 0x2::object::uid_to_inner(&v6),
            owner      : 0x2::tx_context::sender(arg5),
            wal_amount : v3,
        };
        0x2::event::emit<UserClaimed>(v8);
        0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v7, arg5)
    }

    fun withdraw_wal_bal(arg0: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: &mut Staking, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL> {
        let (v0, v1) = 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::vault::withdraw_max<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg2.wal_vault, arg3);
        let v2 = v0;
        arg3 = v1;
        if (v1 > 0) {
            let v3 = 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>();
            let v4 = arg2.validators;
            let v5 = 0;
            while (v5 < 0x1::vector::length<0x2::object::ID>(&v4) && arg3 > 0) {
                let v6 = &mut v3;
                arg3 = do_validator_withdraw(arg2, arg1, v6, *0x1::vector::borrow<0x2::object::ID>(&v4, v5), arg3, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg0), arg4);
                v5 = v5 + 1;
            };
            assert!(arg3 == 0, 9);
            0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut v2, 0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut v3, v1));
            0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::vault::deposit<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg2.wal_vault, v3);
        };
        v2
    }

    // decompiled from Move bytecode v6
}

