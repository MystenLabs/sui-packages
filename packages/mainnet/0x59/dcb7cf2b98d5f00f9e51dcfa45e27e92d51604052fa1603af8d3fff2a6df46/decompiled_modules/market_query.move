module 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market_query {
    struct AssetData has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        interest_model: 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::interest::InterestModel,
        utilization_rate: 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal,
        borrow_paused: bool,
        deposit_paused: bool,
        withdraw_paused: bool,
        liquidation_paused: bool,
        flash_loan_paused: bool,
        reserve: u64,
        asset_setting: 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::asset::AssetConfig,
        deposit_usage: 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::query_types::AssetDeposit,
        borrow_usage: 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::query_types::AssetBorrow,
    }

    public fun get_asset_detail<T0>(arg0: &0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::Market<T0>, arg1: u8, arg2: 0x1::type_name::TypeName, arg3: &0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::x_oracle::XOracle, arg5: &0x2::clock::Clock) : AssetData {
        get_asset_detail_inner<T0>(arg0, arg1, arg2, arg3, 0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::user_oracle::get_price(arg4, arg2, 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::emode::get_oracle_base_token(0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::emode::borrow_emode_group(0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::emode_registry<T0>(arg0), arg1)), arg5), arg5)
    }

    fun get_asset_detail_inner<T0>(arg0: &0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::Market<T0>, arg1: u8, arg2: 0x1::type_name::TypeName, arg3: &0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::coin_decimals_registry::CoinDecimalsRegistry, arg4: 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal, arg5: &0x2::clock::Clock) : AssetData {
        let v0 = 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::asset_by_type<T0>(arg0, arg2);
        let v1 = 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::reserve_by_type<T0>(arg0, arg2);
        let v2 = 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::coin_decimals_registry::decimals(arg3, arg2);
        AssetData{
            coin_type          : arg2,
            interest_model     : *0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::asset::interest_model<T0>(v0),
            utilization_rate   : 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::reserve::util_rate<T0>(v1),
            borrow_paused      : 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::asset::borrow_paused<T0>(v0),
            deposit_paused     : 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::asset::deposit_paused<T0>(v0),
            withdraw_paused    : 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::asset::withdraw_paused<T0>(v0),
            liquidation_paused : 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::asset::liquidation_paused<T0>(v0),
            flash_loan_paused  : 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::asset::flash_loan_paused<T0>(v0),
            reserve            : 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::reserve::protocol_reserve<T0>(v1),
            asset_setting      : *0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::asset::asset_config<T0>(v0),
            deposit_usage      : 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::query_types::new_asset_deposit(arg2, false, 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::floor(0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::reserve::cash_plus_borrows_minus_reserves<T0>(v1)), arg4, v2, 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::reserve::exchange_rate<T0>(v1)),
            borrow_usage       : 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::query_types::new_asset_borrow(arg2, 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::floor(0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::emode::borrow_amount(0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::emode::borrow_emode_group(0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::emode_registry<T0>(arg0), arg1), arg2)), arg4, v2, 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::reserve::calculate_borrow_index<T0>(v1, 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::interest::calc_interest(0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::asset::interest_model<T0>(v0), 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::reserve::util_rate<T0>(v1)), 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::value::clock_now(arg5))),
        }
    }

    public fun get_asset_detail_no_price<T0>(arg0: &0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::Market<T0>, arg1: u8, arg2: 0x1::type_name::TypeName, arg3: &0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x2::clock::Clock) : AssetData {
        get_asset_detail_inner<T0>(arg0, arg1, arg2, arg3, 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::zero(), arg4)
    }

    // decompiled from Move bytecode v6
}

