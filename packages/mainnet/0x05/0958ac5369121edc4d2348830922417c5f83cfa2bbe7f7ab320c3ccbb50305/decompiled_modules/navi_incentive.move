module 0xdb5cfa5ad07fec2fbaf60f8006bd8f72ea3c5fc88b57b222f139060b88156ec9::navi_incentive {
    struct IncentiveBal<phantom T0> has store, key {
        id: 0x2::object::UID,
        asset: u8,
        current_idx: u64,
        distributed_amount: u256,
        balance: 0x2::balance::Balance<T0>,
    }

    struct PoolInfo has store {
        id: u8,
        last_update_time: u64,
        coin_types: vector<0x1::ascii::String>,
        start_times: vector<u64>,
        end_times: vector<u64>,
        total_supplys: vector<u256>,
        rates: vector<u256>,
        index_rewards: vector<u256>,
        index_rewards_paids: vector<0x2::table::Table<address, u256>>,
        user_acc_rewards: vector<0x2::table::Table<address, u256>>,
        user_acc_rewards_paids: vector<0x2::table::Table<address, u256>>,
        oracle_ids: vector<u8>,
    }

    struct Incentive has store, key {
        id: 0x2::object::UID,
        pause: bool,
        assets: vector<u8>,
        pools: 0x2::table::Table<u8, PoolInfo>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public(friend) fun update_reward(arg0: &mut Incentive, arg1: &0x2::clock::Clock, arg2: &mut 0xdb5cfa5ad07fec2fbaf60f8006bd8f72ea3c5fc88b57b222f139060b88156ec9::storage::Storage, arg3: u8, arg4: address) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

