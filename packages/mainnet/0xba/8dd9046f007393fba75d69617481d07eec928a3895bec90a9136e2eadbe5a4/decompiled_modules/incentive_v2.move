module 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::incentive_v2 {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct Incentive has store, key {
        id: 0x2::object::UID,
        version: u64,
        pool_objs: vector<address>,
        inactive_objs: vector<address>,
        pools: 0x2::table::Table<address, IncentivePool>,
        funds: 0x2::table::Table<address, IncentiveFundsPoolInfo>,
    }

    struct IncentivePool has store, key {
        id: 0x2::object::UID,
        phase: u64,
        funds: address,
        start_at: u64,
        end_at: u64,
        closed_at: u64,
        total_supply: u64,
        option: u8,
        asset_id: u8,
        factor: u256,
        last_update_at: u64,
        distributed: u64,
        index_reward: u256,
        index_rewards_paids: 0x2::table::Table<address, u256>,
        total_rewards_of_users: 0x2::table::Table<address, u256>,
        total_claimed_of_users: 0x2::table::Table<address, u256>,
    }

    struct IncentiveFundsPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        oracle_id: u8,
        balance: 0x2::balance::Balance<T0>,
        coin_type: 0x1::type_name::TypeName,
    }

    struct IncentiveFundsPoolInfo has store, key {
        id: 0x2::object::UID,
        oracle_id: u8,
        coin_type: 0x1::type_name::TypeName,
    }

    struct CreateFundsPool has copy, drop {
        sender: address,
        coin_type: 0x1::type_name::TypeName,
        oracle_id: u8,
        force: bool,
    }

    struct IncreasedFunds has copy, drop {
        sender: address,
        balance_before: u64,
        balance_after: u64,
    }

    struct WithdrawFunds has copy, drop {
        sender: address,
        value: u64,
    }

    struct CreateIncentive has copy, drop {
        sender: address,
        incentive_pool_pro: address,
    }

    struct CreateIncentivePool has copy, drop {
        sender: address,
        pool: address,
    }

    struct RewardsClaimed has copy, drop {
        sender: address,
        pool: address,
        amount: u64,
    }

    public fun borrow<T0>(arg0: &0x2::clock::Clock, arg1: &0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle::PriceOracle, arg2: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg3: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut Incentive, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        abort 0
    }

    public fun add_funds<T0>(arg0: &OwnerCap, arg1: &mut IncentiveFundsPool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun borrow_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle::PriceOracle, arg2: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg3: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut Incentive, arg7: &0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::account::AccountCap) : 0x2::balance::Balance<T0> {
        abort 0
    }

    public fun calculate_one_from_pool(arg0: &Incentive, arg1: address, arg2: u64, arg3: u256, arg4: address, arg5: u256) : (u256, u256) {
        abort 0
    }

    public fun calculate_release_rate(arg0: &IncentivePool) : u256 {
        abort 0
    }

    public fun calculate_user_effective_amount(arg0: u8, arg1: u256, arg2: u256, arg3: u256) : u256 {
        abort 0
    }

    public entry fun claim_reward<T0>(arg0: &0x2::clock::Clock, arg1: &mut Incentive, arg2: &mut IncentiveFundsPool<T0>, arg3: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg4: u8, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun claim_reward_non_entry<T0>(arg0: &0x2::clock::Clock, arg1: &mut Incentive, arg2: &mut IncentiveFundsPool<T0>, arg3: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg4: u8, arg5: u8, arg6: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        abort 0
    }

    public fun claim_reward_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &mut Incentive, arg2: &mut IncentiveFundsPool<T0>, arg3: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg4: u8, arg5: u8, arg6: &0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::account::AccountCap) : 0x2::balance::Balance<T0> {
        abort 0
    }

    public fun create_and_transfer_owner(arg0: &0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::OwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun create_funds_pool<T0>(arg0: &OwnerCap, arg1: &mut Incentive, arg2: u8, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun create_incentive(arg0: &OwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun create_incentive_pool<T0>(arg0: &OwnerCap, arg1: &mut Incentive, arg2: &IncentiveFundsPool<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u8, arg9: u8, arg10: u256, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun deposit_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg2: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::incentive::Incentive, arg6: &mut Incentive, arg7: &0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::account::AccountCap) {
        abort 0
    }

    public entry fun entry_borrow<T0>(arg0: &0x2::clock::Clock, arg1: &0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle::PriceOracle, arg2: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg3: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut Incentive, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun entry_deposit<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg2: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::incentive::Incentive, arg7: &mut Incentive, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun entry_deposit_on_behalf_of_user<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg2: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: address, arg7: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::incentive::Incentive, arg8: &mut Incentive, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun entry_liquidation<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle::PriceOracle, arg2: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg3: u8, arg4: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::pool::Pool<T0>, arg5: 0x2::coin::Coin<T0>, arg6: u8, arg7: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::pool::Pool<T1>, arg8: address, arg9: u64, arg10: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::incentive::Incentive, arg11: &mut Incentive, arg12: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun entry_repay<T0>(arg0: &0x2::clock::Clock, arg1: &0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle::PriceOracle, arg2: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg3: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut Incentive, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun entry_repay_on_behalf_of_user<T0>(arg0: &0x2::clock::Clock, arg1: &0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle::PriceOracle, arg2: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg3: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: address, arg8: &mut Incentive, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun entry_withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle::PriceOracle, arg2: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg3: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::incentive::Incentive, arg7: &mut Incentive, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun freeze_incentive_pool(arg0: &OwnerCap, arg1: &mut Incentive, arg2: u64) {
        abort 0
    }

    public fun get_active_pools(arg0: &Incentive, arg1: u8, arg2: u8, arg3: u64) : vector<address> {
        abort 0
    }

    public fun get_funds_info(arg0: &Incentive, arg1: address) : (address, u8, 0x1::type_name::TypeName) {
        abort 0
    }

    public fun get_funds_value<T0>(arg0: &IncentiveFundsPool<T0>) : u64 {
        abort 0
    }

    public fun get_inactive_pool_objects(arg0: &Incentive) : vector<address> {
        abort 0
    }

    public fun get_pool_from_asset_and_option(arg0: &Incentive, arg1: u8, arg2: u8) : (vector<address>, vector<address>, vector<address>) {
        abort 0
    }

    public fun get_pool_from_funds_pool<T0>(arg0: &Incentive, arg1: &IncentiveFundsPool<T0>, arg2: u8, arg3: u8) : vector<address> {
        abort 0
    }

    public fun get_pool_info(arg0: &Incentive, arg1: address) : (address, u64, address, u64, u64, u64, u64, u8, u8, u256, u64, u64, u256) {
        abort 0
    }

    public fun get_pool_length(arg0: &Incentive) : u64 {
        abort 0
    }

    public fun get_pool_objects(arg0: &Incentive) : vector<address> {
        abort 0
    }

    public fun get_total_claimed_from_user(arg0: &Incentive, arg1: address, arg2: address) : u256 {
        abort 0
    }

    public fun liquidation<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle::PriceOracle, arg2: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg3: u8, arg4: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::pool::Pool<T0>, arg5: 0x2::balance::Balance<T0>, arg6: u8, arg7: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::pool::Pool<T1>, arg8: address, arg9: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::incentive::Incentive, arg10: &mut Incentive, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        abort 0
    }

    public fun option_borrow() : u8 {
        abort 0
    }

    public fun option_repay() : u8 {
        abort 0
    }

    public fun option_supply() : u8 {
        abort 0
    }

    public fun option_withdraw() : u8 {
        abort 0
    }

    public fun repay<T0>(arg0: &0x2::clock::Clock, arg1: &0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle::PriceOracle, arg2: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg3: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut Incentive, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        abort 0
    }

    public fun repay_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle::PriceOracle, arg2: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg3: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: &mut Incentive, arg7: &0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::account::AccountCap) : 0x2::balance::Balance<T0> {
        abort 0
    }

    public fun version_migrate(arg0: &OwnerCap, arg1: &mut Incentive) {
        abort 0
    }

    public fun version_verification(arg0: &Incentive) {
        abort 0
    }

    public fun withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle::PriceOracle, arg2: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg3: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::incentive::Incentive, arg7: &mut Incentive, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        abort 0
    }

    public fun withdraw_funds<T0>(arg0: &OwnerCap, arg1: &mut IncentiveFundsPool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun withdraw_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle::PriceOracle, arg2: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg3: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::incentive::Incentive, arg7: &mut Incentive, arg8: &0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::account::AccountCap) : 0x2::balance::Balance<T0> {
        abort 0
    }

    // decompiled from Move bytecode v7
}

