module 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::events {
    struct NewBankEvent has copy, drop {
        id: address,
    }

    struct MintEvent has copy, drop {
        coin_pool_id: address,
        staked_coin_type: 0x1::ascii::String,
        input_amount: u64,
        amount_minted: u64,
        supply_increased_by: u64,
    }

    struct RewardsCalculationEvent has copy, drop {
        coin_types: vector<0x1::ascii::String>,
        per_amount: u64,
        rewards_now: vector<u64>,
        rewards_in_hour: vector<u64>,
    }

    struct StakedEvent has copy, drop {
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct BurnedEvent has copy, drop {
        burned_pending: u64,
        sent_to_burn: u64,
        still_to_burn: u64,
    }

    struct UnstakedEvent has copy, drop {
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    public(friend) fun emit_burned_event(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = BurnedEvent{
            burned_pending : arg0,
            sent_to_burn   : arg1,
            still_to_burn  : arg2,
        };
        0x2::event::emit<BurnedEvent>(v0);
    }

    public(friend) fun emit_mint_event(arg0: &0x2::object::ID, arg1: 0x1::ascii::String, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = MintEvent{
            coin_pool_id        : 0x2::object::id_to_address(arg0),
            staked_coin_type    : arg1,
            input_amount        : arg2,
            amount_minted       : arg3,
            supply_increased_by : arg4,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public(friend) fun emit_new_bank_event(arg0: &0x2::object::ID) {
        let v0 = NewBankEvent{id: 0x2::object::id_to_address(arg0)};
        0x2::event::emit<NewBankEvent>(v0);
    }

    public(friend) fun emit_rewards_calculation_event(arg0: vector<0x1::ascii::String>, arg1: u64, arg2: vector<u64>, arg3: vector<u64>) {
        let v0 = RewardsCalculationEvent{
            coin_types      : arg0,
            per_amount      : arg1,
            rewards_now     : arg2,
            rewards_in_hour : arg3,
        };
        0x2::event::emit<RewardsCalculationEvent>(v0);
    }

    public(friend) fun emit_staked_event(arg0: 0x1::ascii::String, arg1: u64) {
        let v0 = StakedEvent{
            coin_type : arg0,
            amount    : arg1,
        };
        0x2::event::emit<StakedEvent>(v0);
    }

    public(friend) fun emit_unstaked_event(arg0: 0x1::ascii::String, arg1: u64) {
        let v0 = UnstakedEvent{
            coin_type : arg0,
            amount    : arg1,
        };
        0x2::event::emit<UnstakedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

