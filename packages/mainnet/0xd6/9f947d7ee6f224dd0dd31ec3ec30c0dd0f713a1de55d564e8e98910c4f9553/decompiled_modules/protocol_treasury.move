module 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::protocol_treasury {
    struct ProtocolTreasury has store {
        treasury_cap: 0x2::coin::TreasuryCap<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>,
        stake_subsidy_distribution_counter: u64,
        stake_subsidy_rate: u16,
        stake_subsidy_amount_per_distribution: u64,
        stake_subsidy_period_length: u64,
        total_supply_at_period_start: u64,
        extra_fields: 0x2::bag::Bag,
    }

    public(friend) fun claim_metadata_cap(arg0: &mut ProtocolTreasury, arg1: &mut 0x2::coin_registry::Currency<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::bag::contains<vector<u8>>(&arg0.extra_fields, b"ika_metadata_cap")) {
            0x2::coin_registry::set_treasury_cap_id<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(arg1, &arg0.treasury_cap);
            0x2::bag::add<vector<u8>, 0x2::coin_registry::MetadataCap<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>>(&mut arg0.extra_fields, b"ika_metadata_cap", 0x2::coin_registry::claim_metadata_cap<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(arg1, &arg0.treasury_cap, arg2));
        };
    }

    fun calculate_stake_subsidy_amount_per_distribution(arg0: u64, arg1: u16, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000 / (arg2 as u128)) as u64)
    }

    public(friend) fun create(arg0: 0x2::coin::TreasuryCap<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg1: u16, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : ProtocolTreasury {
        assert!(arg1 <= (10000 as u16), 0);
        let v0 = 0x2::coin::total_supply<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&arg0);
        ProtocolTreasury{
            treasury_cap                          : arg0,
            stake_subsidy_distribution_counter    : 0,
            stake_subsidy_rate                    : arg1,
            stake_subsidy_amount_per_distribution : calculate_stake_subsidy_amount_per_distribution(v0, arg1, arg2),
            stake_subsidy_period_length           : arg2,
            total_supply_at_period_start          : v0,
            extra_fields                          : 0x2::bag::new(arg3),
        }
    }

    public(friend) fun get_stake_subsidy_distribution_counter(arg0: &ProtocolTreasury) : u64 {
        arg0.stake_subsidy_distribution_counter
    }

    public(friend) fun set_stake_subsidy_period_length(arg0: &mut ProtocolTreasury, arg1: u64) {
        arg0.stake_subsidy_period_length = arg1;
        arg0.stake_subsidy_amount_per_distribution = calculate_stake_subsidy_amount_per_distribution(arg0.total_supply_at_period_start, arg0.stake_subsidy_rate, arg1);
    }

    public(friend) fun set_stake_subsidy_rate(arg0: &mut ProtocolTreasury, arg1: u16) {
        assert!(arg1 <= (10000 as u16), 0);
        arg0.stake_subsidy_rate = arg1;
        arg0.stake_subsidy_amount_per_distribution = calculate_stake_subsidy_amount_per_distribution(arg0.total_supply_at_period_start, arg1, arg0.stake_subsidy_period_length);
    }

    public fun stake_subsidy_amount_per_distribution(arg0: &ProtocolTreasury) : u64 {
        arg0.stake_subsidy_amount_per_distribution
    }

    public(friend) fun stake_subsidy_for_distribution(arg0: &mut ProtocolTreasury, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA> {
        arg0.stake_subsidy_distribution_counter = arg0.stake_subsidy_distribution_counter + 1;
        if (arg0.stake_subsidy_distribution_counter % arg0.stake_subsidy_period_length == 0) {
            let v0 = 0x2::coin::total_supply<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&arg0.treasury_cap);
            arg0.stake_subsidy_amount_per_distribution = calculate_stake_subsidy_amount_per_distribution(v0, arg0.stake_subsidy_rate, arg0.stake_subsidy_period_length);
            arg0.total_supply_at_period_start = v0;
        };
        0x2::coin::into_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(0x2::coin::mint<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.treasury_cap, arg0.stake_subsidy_amount_per_distribution, arg1))
    }

    // decompiled from Move bytecode v6
}

