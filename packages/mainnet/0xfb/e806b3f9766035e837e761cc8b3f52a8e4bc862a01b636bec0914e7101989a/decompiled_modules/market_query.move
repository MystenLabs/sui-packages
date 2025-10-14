module 0xfbe806b3f9766035e837e761cc8b3f52a8e4bc862a01b636bec0914e7101989a::market_query {
    struct AssetData has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        interest_model: 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::interest::InterestModel,
        utilization_rate: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal,
        borrow_paused: bool,
        deposit_paused: bool,
        withdraw_paused: bool,
        liquidation_paused: bool,
        flash_loan_paused: bool,
        reserve: u64,
        asset_setting: 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::asset::AssetConfig,
        deposit_usage: 0xfbe806b3f9766035e837e761cc8b3f52a8e4bc862a01b636bec0914e7101989a::types::AssetDeposit,
        borrow_usage: 0xfbe806b3f9766035e837e761cc8b3f52a8e4bc862a01b636bec0914e7101989a::types::AssetBorrow,
    }

    public fun get_asset_detail<T0>(arg0: &0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::Market<T0>, arg1: 0x1::type_name::TypeName, arg2: &0x4abb202e193c18f6d5b418ef03418fd5e77f40d57a19355fececf8079fa1db98::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x5060fa94bc49945536eae3d46583d1d85dd3b1c549e5b83b48b0dfe9833ff404::x_oracle::XOracle, arg4: &0x2::clock::Clock) : AssetData {
        get_asset_detail_inner<T0>(arg0, arg1, arg2, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::value::get_price(arg3, arg1, arg4), arg4)
    }

    fun get_asset_detail_inner<T0>(arg0: &0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::Market<T0>, arg1: 0x1::type_name::TypeName, arg2: &0x4abb202e193c18f6d5b418ef03418fd5e77f40d57a19355fececf8079fa1db98::coin_decimals_registry::CoinDecimalsRegistry, arg3: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal, arg4: &0x2::clock::Clock) : AssetData {
        let v0 = 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::asset_by_type<T0>(arg0, arg1);
        let v1 = 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::reserve_by_type<T0>(arg0, arg1);
        let v2 = 0x4abb202e193c18f6d5b418ef03418fd5e77f40d57a19355fececf8079fa1db98::coin_decimals_registry::decimals(arg2, arg1);
        AssetData{
            coin_type          : arg1,
            interest_model     : *0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::asset::interest_model<T0>(v0),
            utilization_rate   : 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::reserve::util_rate<T0>(v1),
            borrow_paused      : 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::asset::borrow_paused<T0>(v0),
            deposit_paused     : 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::asset::deposit_paused<T0>(v0),
            withdraw_paused    : 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::asset::withdraw_paused<T0>(v0),
            liquidation_paused : 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::asset::liquidation_paused<T0>(v0),
            flash_loan_paused  : 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::asset::flash_loan_paused<T0>(v0),
            reserve            : 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::reserve::protocol_reserve<T0>(v1),
            asset_setting      : *0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::asset::asset_config<T0>(v0),
            deposit_usage      : 0xfbe806b3f9766035e837e761cc8b3f52a8e4bc862a01b636bec0914e7101989a::types::new_asset_deposit(arg1, false, 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::floor(0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::reserve::cash_plus_borrows_minus_reserves<T0>(v1)), arg3, v2, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::reserve::exchange_rate<T0>(v1)),
            borrow_usage       : 0xfbe806b3f9766035e837e761cc8b3f52a8e4bc862a01b636bec0914e7101989a::types::new_asset_borrow(arg1, 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::floor(*0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::reserve::debt<T0>(v1)), arg3, v2, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::reserve::calculate_borrow_index<T0>(v1, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::interest::calc_interest(0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::asset::interest_model<T0>(v0), 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::reserve::util_rate<T0>(v1)), 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::value::clock_now(arg4))),
        }
    }

    public fun get_asset_detail_no_price<T0>(arg0: &0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::Market<T0>, arg1: 0x1::type_name::TypeName, arg2: &0x4abb202e193c18f6d5b418ef03418fd5e77f40d57a19355fececf8079fa1db98::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2::clock::Clock) : AssetData {
        get_asset_detail_inner<T0>(arg0, arg1, arg2, 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::zero(), arg3)
    }

    // decompiled from Move bytecode v6
}

