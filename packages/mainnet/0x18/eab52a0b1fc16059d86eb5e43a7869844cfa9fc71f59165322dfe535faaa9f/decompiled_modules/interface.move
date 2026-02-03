module 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::interface {
    struct INTERFACE has drop {
        dummy_field: bool,
    }

    public fun add_integrator_config<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::AccountCap<T0>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::Account<T0>, arg2: address, arg3: u256) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::add_integrator_config<T0>(arg0, arg1, arg2, arg3);
    }

    public fun consume_policy_and_share_account<T0>(arg0: 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::Account<T0>, arg1: 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::AccountSharePolicy) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::consume_policy_and_share_account<T0>(arg0, arg1);
    }

    public fun deposit_collateral<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::AccountCap<T0>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::Account<T0>, arg2: 0x2::coin::Coin<T0>) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::deposit_collateral<T0>(arg0, arg1, arg2);
    }

    public fun remove_integrator_config<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::AccountCap<T0>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::Account<T0>, arg2: address) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::remove_integrator_config<T0>(arg0, arg1, arg2);
    }

    public fun withdraw_collateral<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::AccountCap<T0>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::Account<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::withdraw_collateral<T0>(arg0, arg1, arg2, arg3)
    }

    public fun execute_adl<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg2: u64, arg3: vector<u128>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>, arg7: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg8: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg9: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg10: &0x2::clock::Clock) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::adl::execute_adl<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun create_assistant_cap(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ADMIN>, arg1: &mut 0x2::tx_context::TxContext) : 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT> {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::create_assistant_cap(arg1)
    }

    public fun delete_assistant_cap(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ADMIN>, arg1: 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::delete_assistant_cap(arg1);
    }

    public fun accept_position_fees_proposal<T0>(arg0: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg1: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::AccountCap<T0>) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_market_is_not_paused<T0>(arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::accept_position_fees_proposal<T0>(arg0, arg1);
    }

    public fun allocate_collateral<T0>(arg0: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg1: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::AccountCap<T0>, arg2: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::Account<T0>, arg3: u64) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_market_is_not_paused<T0>(arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::check_valid_account_cap<T0>(arg2, arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::allocate_collateral<T0>(arg0, arg2, arg3);
    }

    public fun cancel_orders<T0>(arg0: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg1: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::AccountCap<T0>, arg2: &vector<u128>) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_market_is_not_paused<T0>(arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::cancel_orders<T0>(arg0, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::get_cap_account_id<T0>(arg1), arg2);
    }

    public fun close_market<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg2: u256, arg3: u256) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_market_is_not_closed<T0>(arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::close_market<T0>(arg1, arg2, arg3);
    }

    public fun close_position_at_settlement_prices<T0>(arg0: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg1: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::AccountCap<T0>, arg2: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::Account<T0>, arg3: &vector<u128>) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_market_is_paused<T0>(arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_market_is_closed<T0>(arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::check_valid_account_cap<T0>(arg2, arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::close_position_at_settlement_prices<T0>(arg0, arg2, arg3);
    }

    public fun commit_margin_ratios_proposal<T0>(arg0: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg1: &0x2::clock::Clock) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_market_is_not_paused<T0>(arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::commit_margin_ratios_proposal<T0>(arg0, arg1);
    }

    public fun create_clearing_house<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::orderbook::Orderbook, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &0x2::clock::Clock, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg5: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg6: 0x2::object::ID, arg7: 0x2::object::ID, arg8: u256, arg9: u256, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u256, arg18: u256, arg19: u256, arg20: u256, arg21: u256, arg22: u64, arg23: u64, arg24: &mut 0x2::tx_context::TxContext) : 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0> {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::create_clearing_house<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24)
    }

    public fun create_integrator_vault<T0>(arg0: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg1: &0x2::tx_context::TxContext) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_market_is_not_paused<T0>(arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::create_integrator_vault<T0>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun create_margin_ratios_proposal<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: u256, arg5: u256) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::create_margin_ratios_proposal<T0>(arg1, arg2, arg3, arg4, arg5);
    }

    public fun create_market_position<T0>(arg0: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg1: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::AccountCap<T0>) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_market_is_not_paused<T0>(arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::create_market_position<T0>(arg0, arg1);
    }

    public fun create_position_fees_proposal<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg2: u64, arg3: u256, arg4: u256) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::create_position_fees_proposal<T0>(arg1, arg2, arg3, arg4);
    }

    public fun deallocate_collateral<T0>(arg0: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg1: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::AccountCap<T0>, arg2: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::Account<T0>, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg5: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg6: &0x2::clock::Clock, arg7: u64) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_market_is_not_paused<T0>(arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::check_valid_account_cap<T0>(arg2, arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::deallocate_collateral<T0>(arg0, arg2, arg3, arg4, arg5, arg6, 0x1::option::some<u64>(arg7));
    }

    public fun delete_margin_ratios_proposal<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg2: &0x2::clock::Clock) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::delete_margin_ratios_proposal<T0>(arg1, arg2);
    }

    public fun delete_position_fees_proposal<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg2: u64) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::delete_position_fees_proposal<T0>(arg1, arg2);
    }

    public fun donate_to_insurance_fund<T0>(arg0: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::donate_to_insurance_fund<T0>(arg0, arg1, 0x2::tx_context::sender(arg2));
    }

    public fun end_session<T0>(arg0: 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::SessionHotPotato<T0>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::Account<T0>, arg2: bool, arg3: 0x1::option::Option<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::IntegratorInfo>) : (0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::SessionSummary) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version_in_session<T0>(&arg0);
        assert!(0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::get_account_id_in_session<T0>(&arg0) == 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::get_account_id<T0>(arg1), 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::errors::wrong_account_id_for_allocation());
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::end_session<T0>(arg0, arg1, arg2, arg3)
    }

    public fun liquidate<T0>(arg0: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::SessionHotPotato<T0>, arg1: u64, arg2: &vector<u128>) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version_in_session<T0>(arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::liquidate<T0>(arg0, arg1, arg2);
    }

    public fun pause_market<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_market_is_not_paused<T0>(arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::pause_market<T0>(arg1);
    }

    public fun place_limit_order<T0>(arg0: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::SessionHotPotato<T0>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: 0x1::option::Option<u64>) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version_in_session<T0>(arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::place_limit_order<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun place_market_order<T0>(arg0: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::SessionHotPotato<T0>, arg1: bool, arg2: u64, arg3: bool) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version_in_session<T0>(arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::place_market_order<T0>(arg0, arg1, arg2, arg3);
    }

    public fun place_stop_order_sltp<T0>(arg0: 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg4: &0x2::clock::Clock, arg5: 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::stop_orders::StopOrderTicket<T0>, arg6: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::Account<T0>, arg7: 0x1::option::Option<u64>, arg8: bool, arg9: 0x1::option::Option<u256>, arg10: 0x1::option::Option<u256>, arg11: bool, arg12: u64, arg13: u64, arg14: u64, arg15: vector<u8>, arg16: 0x1::option::Option<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::IntegratorInfo>, arg17: &mut 0x2::tx_context::TxContext) : (0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::SessionSummary, 0x2::coin::Coin<0x2::sui::SUI>, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(&arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_market_is_not_paused<T0>(&arg0);
        let v0 = 0x2::tx_context::sender(arg17);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::stop_orders::assert_valid_ticket_executor<T0>(&arg5, v0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::stop_orders::assert_valid_ticket_account_id<T0>(&arg5, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::get_account_id<T0>(arg6));
        let (v1, v2, v3) = 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::place_stop_order_sltp<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, &arg15, v0, arg16, 0x2::tx_context::gas_price(arg17));
        (v1, 0x2::coin::from_balance<0x2::sui::SUI>(v2, arg17), v3)
    }

    public fun place_stop_order_standalone<T0>(arg0: 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg4: &0x2::clock::Clock, arg5: 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::stop_orders::StopOrderTicket<T0>, arg6: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::Account<T0>, arg7: 0x1::option::Option<u64>, arg8: bool, arg9: u256, arg10: bool, arg11: bool, arg12: u64, arg13: u64, arg14: u64, arg15: bool, arg16: vector<u8>, arg17: 0x1::option::Option<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::IntegratorInfo>, arg18: &mut 0x2::tx_context::TxContext) : (0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::SessionSummary, 0x2::coin::Coin<0x2::sui::SUI>, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(&arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_market_is_not_paused<T0>(&arg0);
        let v0 = 0x2::tx_context::sender(arg18);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::stop_orders::assert_valid_ticket_executor<T0>(&arg5, v0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::stop_orders::assert_valid_ticket_account_id<T0>(&arg5, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::get_account_id<T0>(arg6));
        let (v1, v2, v3) = 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::place_stop_order_standalone<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, &arg16, v0, arg17, 0x2::tx_context::gas_price(arg18));
        (v1, 0x2::coin::from_balance<0x2::sui::SUI>(v2, arg18), v3)
    }

    public fun reject_position_fees_proposal<T0>(arg0: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg1: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::AccountCap<T0>) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_market_is_not_paused<T0>(arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::reject_position_fees_proposal<T0>(arg0, arg1);
    }

    public fun reset_position_fees<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg2: u64) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::reset_position_fees<T0>(arg1, arg2);
    }

    public fun resume_market<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_market_is_not_closed<T0>(arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::resume_market<T0>(arg1);
    }

    public fun share_clearing_house<T0>(arg0: 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::share_clearing_house<T0>(arg0);
    }

    public fun start_session<T0>(arg0: 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg1: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::AccountCap<T0>, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::SessionHotPotato<T0> {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(&arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_market_is_not_paused<T0>(&arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::start_session<T0>(arg0, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::get_cap_account_id<T0>(arg1), arg2, arg3, arg4, arg5, 0x2::tx_context::gas_price(arg6))
    }

    public fun withdraw_fees<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::withdraw_fees<T0>(arg1, arg2)
    }

    public fun withdraw_from_integrator_vault<T0>(arg0: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg0);
        0x2::coin::from_balance<T0>(0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::withdraw_from_integrator_vault<T0>(arg0, 0x2::tx_context::sender(arg1)), arg1)
    }

    public fun withdraw_insurance_fund<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::withdraw_insurance_fund<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun create_account<T0>(arg0: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::registry::Registry, arg1: &mut 0x2::tx_context::TxContext) : 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::AccountCap<T0> {
        let (v0, v1, v2) = 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::registry::create_account<T0>(arg0, arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::consume_policy_and_share_account<T0>(v0, v1);
        v2
    }

    public fun create_and_return_account<T0>(arg0: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::registry::Registry, arg1: &mut 0x2::tx_context::TxContext) : (0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::Account<T0>, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::AccountSharePolicy, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::AccountCap<T0>) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::registry::create_account<T0>(arg0, arg1)
    }

    public fun create_orderbook(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::orderbook::Orderbook {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::orderbook::create_orderbook(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun create_stop_order_ticket<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::AccountCap<T0>, arg1: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::registry::Registry, arg2: vector<address>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) : 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::stop_orders::StopOrderTicket<T0> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::registry::get_stop_order_mist_cost(arg1), 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::errors::not_enough_gas_for_stop_order());
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::stop_orders::create_stop_order_ticket<T0>(0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::get_cap_account_id<T0>(arg0), arg2, 0x2::coin::into_balance<0x2::sui::SUI>(arg3), arg4, arg5, arg6)
    }

    public fun deallocate_free_collateral<T0>(arg0: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg1: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::AccountCap<T0>, arg2: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::Account<T0>, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg5: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg6: &0x2::clock::Clock) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_market_is_not_paused<T0>(arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::check_valid_account_cap<T0>(arg2, arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::deallocate_collateral<T0>(arg0, arg2, arg3, arg4, arg5, arg6, 0x1::option::none<u64>());
    }

    public fun delete_stop_order_ticket<T0>(arg0: 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::stop_orders::StopOrderTicket<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::stop_orders::assert_valid_ticket_executor<T0>(&arg0, v0);
        let (v1, _, _) = 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::stop_orders::delete_stop_order_ticket<T0>(arg0, false, v0);
        0x2::coin::from_balance<0x2::sui::SUI>(v1, arg1)
    }

    public fun edit_stop_order_ticket_details<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::AccountCap<T0>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::stop_orders::StopOrderTicket<T0>, arg2: vector<u8>) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::stop_orders::assert_valid_ticket_account_id<T0>(arg1, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::get_cap_account_id<T0>(arg0));
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::stop_orders::edit_stop_order_ticket_details<T0>(arg1, arg2);
    }

    public fun edit_stop_order_ticket_executors<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::AccountCap<T0>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::stop_orders::StopOrderTicket<T0>, arg2: vector<address>) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::stop_orders::assert_valid_ticket_account_id<T0>(arg1, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::get_cap_account_id<T0>(arg0));
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::stop_orders::edit_stop_order_ticket_executor<T0>(arg1, arg2);
    }

    fun init(arg0: INTERFACE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<INTERFACE>(arg0, arg1);
    }

    public fun register_market<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::registry::Registry, arg2: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg2);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::registry::register_market<T0>(arg1, arg2);
    }

    public fun remove_registered_market<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::registry::Registry, arg2: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg2);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::registry::remove_registered_market<T0>(arg1, arg2);
    }

    public fun set_base_pfs_id<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::registry::Registry, arg2: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg2);
        let v0 = 0x2::object::id<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>>(arg2);
        let v1 = 0x2::object::id<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage>(arg3);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::market::set_base_pfs_id(0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::get_market_params_mut<T0>(arg2), &v0, v1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::registry::update_base_pfs_id<T0>(arg1, v0, v1);
    }

    public fun set_base_pfs_source_id<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::registry::Registry, arg2: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg3: 0x2::object::ID) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg2);
        let v0 = 0x2::object::id<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>>(arg2);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::market::set_base_pfs_source_id(0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::get_market_params_mut<T0>(arg2), &v0, arg3);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::registry::update_base_pfs_source_id<T0>(arg1, v0, arg3);
    }

    public fun set_base_pfs_tolerance<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg2: u64) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg1);
        let v0 = 0x2::object::id<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>>(arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::market::set_base_pfs_tolerance(0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::get_market_params_mut<T0>(arg1), &v0, arg2);
    }

    public fun set_collateral_haircut<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg2: u256) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg1);
        let v0 = 0x2::object::id<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>>(arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::market::set_collateral_haircut(0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::get_market_params_mut<T0>(arg1), &v0, arg2);
    }

    public fun set_collateral_info<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::registry::Registry, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: 0x2::object::ID) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::registry::update_collateral_info<T0>(arg1, 0x2::object::id<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage>(arg2), arg3);
    }

    public fun set_collateral_pfs_id<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::registry::Registry, arg2: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg2);
        let v0 = 0x2::object::id<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>>(arg2);
        let v1 = 0x2::object::id<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage>(arg3);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::market::set_collateral_pfs_id(0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::get_market_params_mut<T0>(arg2), &v0, v1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::registry::update_collateral_pfs_id<T0>(arg1, v0, v1);
    }

    public fun set_collateral_pfs_source_id<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::registry::Registry, arg2: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg3: 0x2::object::ID) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg2);
        let v0 = 0x2::object::id<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>>(arg2);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::market::set_collateral_pfs_source_id(0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::get_market_params_mut<T0>(arg2), &v0, arg3);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::registry::update_collateral_pfs_source_id<T0>(arg1, v0, arg3);
    }

    public fun set_collateral_pfs_tolerance<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg2: u64) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg1);
        let v0 = 0x2::object::id<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>>(arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::market::set_collateral_pfs_tolerance(0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::get_market_params_mut<T0>(arg1), &v0, arg2);
    }

    public fun set_max_bad_debt<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg2: u256) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg1);
        let v0 = 0x2::object::id<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>>(arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::market::set_max_bad_debt(0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::get_market_params_mut<T0>(arg1), &v0, arg2);
    }

    public fun set_max_open_interest<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg2: u256) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg1);
        let v0 = 0x2::object::id<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>>(arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::market::set_max_open_interest(0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::get_market_params_mut<T0>(arg1), &v0, arg2);
    }

    public fun set_max_open_interest_position_params<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg2: u256, arg3: u256) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg1);
        let v0 = 0x2::object::id<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>>(arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::market::set_max_open_interest_position_params(0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::get_market_params_mut<T0>(arg1), &v0, arg2, arg3);
    }

    public fun set_max_pending_orders<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg2: u64) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg1);
        let v0 = 0x2::object::id<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>>(arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::market::set_max_pending_orders(0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::get_market_params_mut<T0>(arg1), &v0, arg2);
    }

    public fun set_max_socialize_losses_mr_decrease<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg2: u256) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg1);
        let v0 = 0x2::object::id<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>>(arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::market::set_max_socialize_losses_mr_decrease(0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::get_market_params_mut<T0>(arg1), &v0, arg2);
    }

    public fun set_min_order_usd_value<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg2: u256) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg1);
        let v0 = 0x2::object::id<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>>(arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::market::set_min_order_usd_value(0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::get_market_params_mut<T0>(arg1), &v0, arg2);
    }

    public fun set_position_initial_margin_ratio<T0>(arg0: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg1: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::AccountCap<T0>, arg2: u256) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_market_is_not_paused<T0>(arg0);
        let (v0, _) = 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::get_market_objects<T0>(arg0);
        let v2 = 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::account::get_cap_account_id<T0>(arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::position::set_initial_margin_ratio(0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::get_position_mut<T0>(arg0, v2), arg2, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::market::get_margin_ratio_initial(v0), 0x2::object::id<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>>(arg0), v2);
    }

    public fun settle_position_funding<T0>(arg0: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg3: u64, arg4: &0x2::clock::Clock) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_market_is_not_paused<T0>(arg0);
        let v0 = 0x2::object::id<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>>(arg0);
        let (v1, v2) = 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::get_market_objects<T0>(arg0);
        let (v3, v4) = 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::market::get_cum_funding_rates(v2);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::position::settle_position_funding(0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::get_position_mut<T0>(arg0, arg3), 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::market::get_collateral_oracle_price(v1, arg1, arg2, arg4), v3, v4, &v0, arg3);
    }

    public fun update_fees<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg1);
        let v0 = 0x2::object::id<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>>(arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::market::update_fees(0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::get_market_params_mut<T0>(arg1), &v0, arg2, arg3, arg4, arg5, arg6);
    }

    public fun update_funding<T0>(arg0: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg3: &0x2::clock::Clock) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_market_is_not_paused<T0>(arg0);
        let v0 = 0x2::object::id<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>>(arg0);
        let (v1, v2) = 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::get_market_objects_mut<T0>(arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::market::try_update_funding(v1, v2, arg1, arg2, arg3, &v0, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::get_book_price<T0>(arg0));
    }

    public fun update_funding_parameters<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg1);
        let v0 = 0x2::object::id<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>>(arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::market::update_funding_parameters(0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::get_market_params_mut<T0>(arg1), &v0, arg2, arg3, arg4, arg5);
    }

    public fun update_market_lot_and_tick<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg2: u64, arg3: u64) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg1);
        let v0 = 0x2::object::id<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>>(arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::market::update_market_lot_and_tick(&v0, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::get_market_params_mut<T0>(arg1), arg2, arg3);
    }

    public fun update_spread_twap_parameters<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg2: u64, arg3: u64) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg1);
        let v0 = 0x2::object::id<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>>(arg1);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::market::update_spread_twap_parameters(0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::get_market_params_mut<T0>(arg1), &v0, arg2, arg3);
    }

    public fun update_stop_order_mist_cost(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::registry::Registry, arg2: u64) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::registry::update_stop_order_mist_cost(arg1, arg2);
    }

    public fun update_twaps<T0>(arg0: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg3: &0x2::clock::Clock) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_ch_version<T0>(arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::check_market_is_not_paused<T0>(arg0);
        let v0 = 0x2::object::id<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>>(arg0);
        let (v1, v2) = 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::get_market_objects_mut<T0>(arg0);
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::market::try_update_twaps(v1, v2, arg1, arg2, arg3, &v0, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::get_book_price<T0>(arg0));
    }

    entry fun upgrade_clearing_house_version<T0>(arg0: &0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::Capability<0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::authority::ASSISTANT>, arg1: &mut 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::ClearingHouse<T0>) {
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::clearing_house::update_clearing_house_version<T0>(arg1);
    }

    // decompiled from Move bytecode v6
}

