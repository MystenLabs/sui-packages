module 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm_manager_admin {
    struct TakeProtocolAssetEvent has copy, drop {
        recipient: address,
        farm_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        amount: u64,
    }

    struct TakeCompoundingAssetEvent has copy, drop {
        recipient: address,
        farm_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        amount: u64,
    }

    public fun add_balance_to_compounding_asset<T0>(arg0: &0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::global_config::GlobalConfig, arg1: &mut 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::Farm, arg2: 0x2::balance::Balance<T0>) {
        0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::global_config::check_package_version(arg0);
        0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::add_balance_to_compounding_asset<T0>(arg1, arg2);
    }

    public fun add_balance_to_protocol_asset<T0>(arg0: &0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::global_config::GlobalConfig, arg1: &mut 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::Farm, arg2: 0x2::balance::Balance<T0>) {
        0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::global_config::check_package_version(arg0);
        0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::add_balance_to_protocol_asset<T0>(arg1, arg2);
    }

    public fun compound<T0, T1, T2>(arg0: &0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::global_config::GlobalConfig, arg1: &mut 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::Farm, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: &0x2::clock::Clock, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x2::tx_context::TxContext) {
        0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::global_config::check_package_version(arg0);
        0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::compound<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun create_farm<T0, T1, T2>(arg0: &mut 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::permission::AdminCap, arg1: &0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::global_config::GlobalConfig, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: vector<0x2::coin::Coin<T0>>, arg5: vector<0x2::coin::Coin<T1>>, arg6: u32, arg7: bool, arg8: u32, arg9: bool, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg14: &mut 0x2::tx_context::TxContext) {
        0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::global_config::check_package_version(arg1);
        0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::create_farm<T0, T1, T2>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
    }

    public fun destroy_farm<T0, T1, T2>(arg0: &mut 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::permission::AdminCap, arg1: &0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::global_config::GlobalConfig, arg2: 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::Farm, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) {
        0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::global_config::check_package_version(arg1);
        0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::destroy_farm<T0, T1, T2>(arg2, arg3, arg4, arg5);
    }

    public fun rebalance<T0, T1, T2>(arg0: &mut 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::permission::AdminCap, arg1: &0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::global_config::GlobalConfig, arg2: &mut 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::Farm, arg3: u32, arg4: bool, arg5: u32, arg6: bool, arg7: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg8: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg9: &0x2::clock::Clock, arg10: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg11: &mut 0x2::tx_context::TxContext) {
        0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::global_config::check_package_version(arg1);
        0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::rebalance<T0, T1, T2>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun add_coin_to_compounding_asset<T0>(arg0: &0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::global_config::GlobalConfig, arg1: &mut 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::Farm, arg2: 0x2::coin::Coin<T0>) {
        0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::global_config::check_package_version(arg0);
        0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::add_balance_to_compounding_asset<T0>(arg1, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun add_coin_to_protocol_asset<T0>(arg0: &0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::global_config::GlobalConfig, arg1: &mut 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::Farm, arg2: 0x2::coin::Coin<T0>) {
        0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::global_config::check_package_version(arg0);
        0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::add_balance_to_protocol_asset<T0>(arg1, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun collect_fees<T0, T1, T2>(arg0: &0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::global_config::GlobalConfig, arg1: &mut 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::Farm, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: address, arg5: &0x2::clock::Clock, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &mut 0x2::tx_context::TxContext) {
        0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::global_config::check_package_version(arg0);
        let (v0, v1) = 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::collect_fees_with_return<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::do_distribute_fee_or_reward<T0>(arg0, arg1, v0);
        0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::do_distribute_fee_or_reward<T1>(arg0, arg1, v1);
    }

    public fun collect_reward<T0, T1, T2, T3>(arg0: &0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::global_config::GlobalConfig, arg1: &mut 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::Farm, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::PoolRewardVault<T3>, arg5: u64, arg6: address, arg7: &0x2::clock::Clock, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: &mut 0x2::tx_context::TxContext) {
        0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::global_config::check_package_version(arg0);
        0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::do_distribute_fee_or_reward<T3>(arg0, arg1, 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::collect_reward_with_return<T0, T1, T2, T3>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9));
    }

    public fun take_compounding_asset_balance_by_amount_with_return<T0>(arg0: &mut 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::permission::AdminCap, arg1: &0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::global_config::GlobalConfig, arg2: &mut 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::Farm, arg3: u64) : 0x2::balance::Balance<T0> {
        abort 0
    }

    public fun take_compounding_asset_balance_by_amount_with_return_v2<T0>(arg0: &mut 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::permission::AdminCap, arg1: &0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::global_config::GlobalConfig, arg2: &mut 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::Farm, arg3: u64, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::global_config::check_package_version(arg1);
        let v0 = TakeCompoundingAssetEvent{
            recipient : 0x2::tx_context::sender(arg4),
            farm_id   : 0x2::object::id<0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::Farm>(arg2),
            coin_type : 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::utils::get_type_name_str<T0>(),
            amount    : arg3,
        };
        0x2::event::emit<TakeCompoundingAssetEvent>(v0);
        0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::do_take_compounding_asset_balance_by_amount<T0>(arg2, arg3)
    }

    public fun take_compounding_asset_balance_with_return<T0>(arg0: &mut 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::permission::AdminCap, arg1: &0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::global_config::GlobalConfig, arg2: &mut 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::Farm) : 0x2::balance::Balance<T0> {
        abort 0
    }

    public fun take_compounding_asset_balance_with_return_v2<T0>(arg0: &mut 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::permission::AdminCap, arg1: &0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::global_config::GlobalConfig, arg2: &mut 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::Farm, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::global_config::check_package_version(arg1);
        let v0 = 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::do_take_compounding_asset_balance<T0>(arg2);
        let v1 = TakeCompoundingAssetEvent{
            recipient : 0x2::tx_context::sender(arg3),
            farm_id   : 0x2::object::id<0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::Farm>(arg2),
            coin_type : 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::utils::get_type_name_str<T0>(),
            amount    : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<TakeCompoundingAssetEvent>(v1);
        v0
    }

    public fun take_protocol_asset_balance<T0>(arg0: &mut 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::permission::AdminCap, arg1: &0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::global_config::GlobalConfig, arg2: &mut 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::Farm, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::global_config::check_package_version(arg1);
        let v0 = 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::do_take_protocol_asset_balance<T0>(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg4), arg3);
        let v1 = TakeProtocolAssetEvent{
            recipient : 0x2::tx_context::sender(arg4),
            farm_id   : 0x2::object::id<0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::Farm>(arg2),
            coin_type : 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::utils::get_type_name_str<T0>(),
            amount    : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<TakeProtocolAssetEvent>(v1);
    }

    public fun take_protocol_asset_balance_by_amount<T0>(arg0: &mut 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::permission::AdminCap, arg1: &0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::global_config::GlobalConfig, arg2: &mut 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::Farm, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::global_config::check_package_version(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::do_take_protocol_asset_balance_by_amount<T0>(arg2, arg4), arg5), arg3);
        let v0 = TakeProtocolAssetEvent{
            recipient : 0x2::tx_context::sender(arg5),
            farm_id   : 0x2::object::id<0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::farm::Farm>(arg2),
            coin_type : 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::utils::get_type_name_str<T0>(),
            amount    : arg4,
        };
        0x2::event::emit<TakeProtocolAssetEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

