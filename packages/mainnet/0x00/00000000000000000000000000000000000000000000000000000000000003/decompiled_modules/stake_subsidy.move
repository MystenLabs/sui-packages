module 0x3::stake_subsidy {
    struct StakeSubsidy has store {
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        distribution_counter: u64,
        current_distribution_amount: u64,
        stake_subsidy_period_length: u64,
        stake_subsidy_decrease_rate: u16,
        extra_fields: 0x2::bag::Bag,
    }

    public(friend) fun advance_epoch(arg0: &mut StakeSubsidy) : 0x2::balance::Balance<0x2::sui::SUI> {
        arg0.distribution_counter = arg0.distribution_counter + 1;
        if (arg0.distribution_counter % arg0.stake_subsidy_period_length == 0) {
            arg0.current_distribution_amount = arg0.current_distribution_amount - (((arg0.current_distribution_amount as u128) * (arg0.stake_subsidy_decrease_rate as u128) / 10000) as u64);
        };
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, 0x1::u64::min(arg0.current_distribution_amount, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance)))
    }

    public(friend) fun create(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: u16, arg4: &mut 0x2::tx_context::TxContext) : StakeSubsidy {
        assert!(arg3 <= (10000 as u16), 0);
        StakeSubsidy{
            balance                     : arg0,
            distribution_counter        : 0,
            current_distribution_amount : arg1,
            stake_subsidy_period_length : arg2,
            stake_subsidy_decrease_rate : arg3,
            extra_fields                : 0x2::bag::new(arg4),
        }
    }

    public fun current_epoch_subsidy_amount(arg0: &StakeSubsidy) : u64 {
        0x1::u64::min(arg0.current_distribution_amount, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance))
    }

    public(friend) fun get_distribution_counter(arg0: &StakeSubsidy) : u64 {
        arg0.distribution_counter
    }

    // decompiled from Move bytecode v6
}

