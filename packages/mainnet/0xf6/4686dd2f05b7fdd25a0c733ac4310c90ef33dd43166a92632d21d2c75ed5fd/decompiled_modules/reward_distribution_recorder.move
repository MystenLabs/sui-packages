module 0x7f03332ce10d85053a14cc198ec4437312b2b880abd6550cae1757f192100f91::reward_distribution_recorder {
    struct RewardDistributionConfig has store, key {
        id: 0x2::object::UID,
        records: 0x2::table::Table<address, RewardDistributionRecord>,
    }

    struct RewardDistributionRecord has copy, drop, store {
        distribution_end_timestamp: u64,
        last_distributed_timestamp: u64,
        min_distribution_interval: u64,
        max_distribution_amount_per_interval: u64,
        already_distributed_amount: u64,
    }

    struct RewardDistributionRecorded has copy, drop {
        vault_id: address,
        timestamp: u64,
        amount: u64,
    }

    struct RewardDistributionRecordSet has copy, drop {
        end_timestamp: u64,
        min_interval: u64,
        max_amount_per_interval: u64,
    }

    public fun create_reward_distribution_config(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardDistributionConfig{
            id      : 0x2::object::new(arg0),
            records : 0x2::table::new<address, RewardDistributionRecord>(arg0),
        };
        0x2::transfer::public_share_object<RewardDistributionConfig>(v0);
    }

    public fun current_available_distribution_amount(arg0: &RewardDistributionConfig, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::table::borrow<address, RewardDistributionRecord>(&arg0.records, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (v1 > v0.distribution_end_timestamp) {
            return 0
        };
        if (v1 >= v0.last_distributed_timestamp + v0.min_distribution_interval) {
            v0.max_distribution_amount_per_interval
        } else {
            v0.max_distribution_amount_per_interval - v0.already_distributed_amount
        }
    }

    public fun record_reward_distribution(arg0: &mut RewardDistributionConfig, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::table::borrow_mut<address, RewardDistributionRecord>(&mut arg0.records, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 <= v0.distribution_end_timestamp, 2);
        assert!(v1 - v0.last_distributed_timestamp >= v0.min_distribution_interval, 3);
        if (v1 >= v0.last_distributed_timestamp + v0.min_distribution_interval) {
            v0.already_distributed_amount = 0;
        };
        assert!(arg2 <= v0.max_distribution_amount_per_interval - v0.already_distributed_amount, 1);
        v0.already_distributed_amount = v0.already_distributed_amount + arg2;
        v0.last_distributed_timestamp = v1;
        let v2 = RewardDistributionRecorded{
            vault_id  : arg1,
            timestamp : v1,
            amount    : arg2,
        };
        0x2::event::emit<RewardDistributionRecorded>(v2);
    }

    public fun set_reward_distribution_config(arg0: &mut RewardDistributionConfig, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        if (!0x2::table::contains<address, RewardDistributionRecord>(&arg0.records, arg1)) {
            let v0 = RewardDistributionRecord{
                distribution_end_timestamp           : arg2,
                last_distributed_timestamp           : 0,
                min_distribution_interval            : arg3,
                max_distribution_amount_per_interval : arg4,
                already_distributed_amount           : 0,
            };
            0x2::table::add<address, RewardDistributionRecord>(&mut arg0.records, arg1, v0);
        } else {
            let v1 = 0x2::table::borrow_mut<address, RewardDistributionRecord>(&mut arg0.records, arg1);
            v1.distribution_end_timestamp = arg2;
            v1.min_distribution_interval = arg3;
            v1.max_distribution_amount_per_interval = arg4;
            v1.already_distributed_amount = 0;
        };
        let v2 = RewardDistributionRecordSet{
            end_timestamp           : arg2,
            min_interval            : arg3,
            max_amount_per_interval : arg4,
        };
        0x2::event::emit<RewardDistributionRecordSet>(v2);
    }

    // decompiled from Move bytecode v6
}

