module 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::market {
    struct Market has store, key {
        id: 0x2::object::UID,
        interest_config: 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::TableKeys<0x1::type_name::TypeName, 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::interest_config::InterestConfig>,
        interest_model: 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::TableKeys<0x1::type_name::TypeName, 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::interest_model::InterestModel>,
        pool: 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::pool::Pool,
    }

    public(friend) fun initialize(arg0: &mut 0x2::tx_context::TxContext) : Market {
        Market{
            id              : 0x2::object::new(arg0),
            interest_config : 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::interest_config::initialize(arg0),
            interest_model  : 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::interest_model::initialize(arg0),
            pool            : 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::pool::initialize(arg0),
        }
    }

    public(friend) fun accrue_interest<T0>(arg0: &mut Market, arg1: u64) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::interest_config::get_coin_updated_at(&arg0.interest_config, v0) == arg1) {
            return
        };
        0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::interest_config::set_coin_factor(&mut arg0.interest_config, v0, arg1);
        0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::pool::increase_pool_debt_amount(&mut arg0.pool, v0, 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::f32::diff(0x1::fixed_point32::create_from_rational(0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::interest_config::get_coin_factor(&arg0.interest_config, v0), 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::interest_config::get_coin_factor(&arg0.interest_config, v0)), 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::f32::convert_from_u64(1)), 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::interest_model::get_accrual_amount_factor(0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::borrow_table<0x1::type_name::TypeName, 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::interest_model::InterestModel>(&arg0.interest_model, v0)));
    }

    public(friend) fun apply_interest<T0>(arg0: &mut Market, arg1: u64) {
        accrue_interest<T0>(arg0, arg1);
        update_rate<T0>(arg0);
    }

    public(friend) fun coin_withdraw_accrued_amount<T0>(arg0: &mut Market, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::pool::withdraw_accrued_amount<T0>(&mut arg0.pool, arg1, arg2)
    }

    public(friend) fun create_pool_lp_coin<T0>(arg0: &mut Market, arg1: u64) {
        let v0 = 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::borrow_table<0x1::type_name::TypeName, 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::interest_model::InterestModel>(&arg0.interest_model, 0x1::type_name::get<T0>());
        0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::pool::create_pool_lp_coin<T0>(&mut arg0.pool);
        0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::interest_config::add_coin_interest_config<T0>(&mut arg0.interest_config, 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::interest_model::get_std_rate_per_sec(v0), 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::interest_model::get_rate_level(v0), arg1);
    }

    public fun get_coin_interest_config<T0>(arg0: &Market) : u64 {
        0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::interest_config::get_coin_factor(&arg0.interest_config, 0x1::type_name::get<T0>())
    }

    public fun get_coin_interest_model<T0>(arg0: &Market) : &0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::interest_model::InterestModel {
        0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::borrow_table<0x1::type_name::TypeName, 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::interest_model::InterestModel>(&arg0.interest_model, 0x1::type_name::get<T0>())
    }

    public fun get_interest_config(arg0: &Market) : &0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::TableKeys<0x1::type_name::TypeName, 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::interest_config::InterestConfig> {
        &arg0.interest_config
    }

    public fun get_interest_model(arg0: &Market) : &0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::TableKeys<0x1::type_name::TypeName, 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::interest_model::InterestModel> {
        &arg0.interest_model
    }

    public fun get_lending_id(arg0: &Market) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun get_mut_interest_model(arg0: &mut Market) : &mut 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::TableKeys<0x1::type_name::TypeName, 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::interest_model::InterestModel> {
        &mut arg0.interest_model
    }

    public fun get_pool(arg0: &Market) : &0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::pool::Pool {
        &arg0.pool
    }

    public(friend) fun handle_borrow<T0>(arg0: &mut Market, arg1: u64, arg2: u64) : 0x2::balance::Balance<T0> {
        accrue_interest<T0>(arg0, arg2);
        let v0 = 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::pool::borrow_from_pool<T0>(&mut arg0.pool, arg1);
        update_rate<T0>(arg0);
        v0
    }

    public(friend) fun handle_deposit<T0>(arg0: &mut Market, arg1: 0x2::balance::Balance<T0>, arg2: u64) : 0x2::balance::Balance<0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::pool::PoolLpCoin<T0>> {
        accrue_interest<T0>(arg0, arg2);
        let v0 = 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::pool::mint_pool_lp_coin<T0>(&mut arg0.pool, arg1);
        update_rate<T0>(arg0);
        v0
    }

    public(friend) fun handle_repay<T0>(arg0: &mut Market, arg1: 0x2::balance::Balance<T0>, arg2: u64) {
        assert!(0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::interest_config::get_coin_updated_at(&arg0.interest_config, 0x1::type_name::get<T0>()) == arg2, 6000);
        0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::pool::repay_pool_debt<T0>(&mut arg0.pool, arg1);
        update_rate<T0>(arg0);
    }

    public(friend) fun handle_withdraw<T0>(arg0: &mut Market, arg1: 0x2::balance::Balance<0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::pool::PoolLpCoin<T0>>, arg2: u64) : 0x2::balance::Balance<T0> {
        accrue_interest<T0>(arg0, arg2);
        let v0 = 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::pool::burn_pool_lp_coin<T0>(&mut arg0.pool, arg1);
        update_rate<T0>(arg0);
        v0
    }

    public(friend) fun update_rate<T0>(arg0: &mut Market) {
        let v0 = 0x1::type_name::get<T0>();
        let (v1, v2) = 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::interest_model::calculate_rate(0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::borrow_table<0x1::type_name::TypeName, 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::interest_model::InterestModel>(&arg0.interest_model, v0), 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::pool::get_pool_utilization_rate(&arg0.pool, v0));
        0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::interest_config::set_coin_rate(&mut arg0.interest_config, v0, v1, v2);
    }

    // decompiled from Move bytecode v6
}

