module 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::incentive {
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
        creator: address,
        owners: 0x2::table::Table<u256, bool>,
        admins: 0x2::table::Table<u256, bool>,
        pools: 0x2::table::Table<u8, PoolInfo>,
        assets: vector<u8>,
    }

    struct PoolOwnerSetting has copy, drop {
        sender: address,
        owner: u256,
        value: bool,
    }

    struct PoolAdminSetting has copy, drop {
        sender: address,
        admin: u256,
        value: bool,
    }

    struct IncentiveOwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct IncentiveAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun add_pool<T0>(arg0: &mut Incentive, arg1: &0x2::clock::Clock, arg2: u8, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun admin_withdraw_incentive_bal<T0>(arg0: &0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::OwnerCap, arg1: &0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg2: &mut IncentiveBal<T0>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun claim_reward<T0>(arg0: &mut Incentive, arg1: &mut IncentiveBal<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun claim_reward_non_entry<T0>(arg0: &mut Incentive, arg1: &mut IncentiveBal<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        abort 0
    }

    public fun claim_reward_with_account_cap<T0>(arg0: &mut Incentive, arg1: &mut IncentiveBal<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg4: &0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::account::AccountCap) : 0x2::balance::Balance<T0> {
        abort 0
    }

    public fun create_and_transfer_ownership(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun earned(arg0: &Incentive, arg1: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg2: &0x2::clock::Clock, arg3: u8, arg4: address) : (vector<0x1::ascii::String>, vector<u256>, vector<u8>) {
        abort 0
    }

    public fun get_pool_count(arg0: &Incentive, arg1: u8) : u64 {
        abort 0
    }

    public fun get_pool_info(arg0: &Incentive, arg1: u8, arg2: u64) : (u64, u64, u256, u8) {
        abort 0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Incentive{
            id      : 0x2::object::new(arg0),
            creator : 0x2::tx_context::sender(arg0),
            owners  : 0x2::table::new<u256, bool>(arg0),
            admins  : 0x2::table::new<u256, bool>(arg0),
            pools   : 0x2::table::new<u8, PoolInfo>(arg0),
            assets  : 0x1::vector::empty<u8>(),
        };
        0x2::transfer::share_object<Incentive>(v0);
    }

    public fun set_admin(arg0: &mut Incentive, arg1: u256, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun set_owner(arg0: &mut Incentive, arg1: u256, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    // decompiled from Move bytecode v7
}

