module 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge_interface {
    public fun destroy_empty<T0>(arg0: 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::user_deposit::UserDeposit<T0>) {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::user_deposit::destroy_empty<T0>(arg0);
    }

    public fun swap<T0, T1>(arg0: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_id(arg0), 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_version());
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::swap<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun add_bridge(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap, arg1: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge, arg2: u8, arg3: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32, arg4: &mut 0x2::tx_context::TxContext) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_id(arg1), 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_version());
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::add_bridge(arg1, arg2, arg3, arg4);
    }

    public fun add_bridge_token(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap, arg1: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge, arg2: u8, arg3: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_id(arg1), 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_version());
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::add_bridge_token(arg1, arg2, arg3);
    }

    public fun add_pool<T0>(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap, arg1: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge, arg2: 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::Pool<T0>) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_id(arg1), 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_version());
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::add_pool<T0>(arg1, arg2);
    }

    public fun admin_fee_share_bp<T0>(arg0: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge) : u64 {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::admin_fee_share_bp<T0>(arg0)
    }

    public fun can_swap(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge) : bool {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::can_swap(arg0)
    }

    public fun deposit_fee<T0>(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap, arg1: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge, arg2: 0x2::coin::Coin<T0>) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_id(arg1), 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_version());
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::deposit_fee<T0>(arg1, arg2);
    }

    public fun fee_value<T0>(arg0: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge) : u64 {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::fee_value<T0>(arg0)
    }

    public fun gas_usage(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge, arg1: u8) : u64 {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::gas_usage(arg0, arg1)
    }

    public fun get_bridge_allbridge_cost(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge, arg1: &0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::Messenger, arg2: &0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle::GasOracle, arg3: u8) : u64 {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_bridge_allbridge_cost(arg0, arg1, arg2, arg3)
    }

    public fun get_bridge_cost(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge, arg1: &0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle::GasOracle, arg2: u8) : u64 {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_bridge_cost(arg0, arg1, arg2)
    }

    public fun get_bridge_wormhole_cost(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge, arg1: &0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::WormholeMessenger, arg2: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: &0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle::GasOracle, arg4: u8) : u64 {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_bridge_wormhole_cost(arg0, arg1, arg2, arg3, arg4)
    }

    public fun is_processed_message(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge, arg1: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message) : bool {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::is_processed_message(arg0, arg1)
    }

    public fun migrate(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap, arg1: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge) {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::migrate(arg0, arg1);
    }

    public fun pool<T0>(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge) : &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::Pool<T0> {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::pool<T0>(arg0)
    }

    public fun receive_tokens_wormhole<T0>(arg0: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge, arg1: &0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::WormholeMessenger, arg2: u64, arg3: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32, arg4: u8, arg5: u256, arg6: u64, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_id(arg0), 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_version());
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::receive_tokens_wormhole<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun remove_bridge(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap, arg1: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge, arg2: u8) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_id(arg1), 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_version());
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::remove_bridge(arg1, arg2);
    }

    public fun remove_bridge_token(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap, arg1: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge, arg2: u8, arg3: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_id(arg1), 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_version());
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::remove_bridge_token(arg1, arg2, arg3);
    }

    public fun set_gas_usage(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap, arg1: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge, arg2: u8, arg3: u64) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_id(arg1), 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_version());
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::set_gas_usage(arg1, arg2, arg3);
    }

    public fun set_rebalancer(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap, arg1: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge, arg2: address) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_id(arg1), 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_version());
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::set_rebalancer(arg1, arg2);
    }

    public fun start_swap(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap, arg1: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_id(arg1), 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_version());
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::start_swap(arg1);
    }

    public fun stop_swap(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::StopSwapCap, arg1: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_id(arg1), 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_version());
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::stop_swap(arg1);
    }

    public fun swap_and_bridge_wormhole<T0>(arg0: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge, arg1: &mut 0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::WormholeMessenger, arg2: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: &0x2::clock::Clock, arg4: &0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle::GasOracle, arg5: 0x2::coin::Coin<T0>, arg6: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32, arg7: u8, arg8: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32, arg9: u256, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: 0x2::coin::Coin<T0>, arg12: &mut 0x2::tx_context::TxContext) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_id(arg0), 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_version());
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::swap_and_bridge_wormhole<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun withdraw_fee<T0>(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap, arg1: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_id(arg1), 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_version());
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::withdraw_fee<T0>(arg1, arg2, arg3)
    }

    public fun adjust_total_lp_amount<T0>(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::AdminCap, arg1: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge, arg2: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::user_deposit::UserDeposit<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_id(arg1), 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_version());
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::adjust_total_lp_amount<T0>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::pool_mut<T0>(arg1), arg2, arg3)
    }

    public fun can_deposit<T0>(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge) : bool {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::can_deposit<T0>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::pool<T0>(arg0))
    }

    public fun can_withdraw<T0>(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge) : bool {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::can_withdraw<T0>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::pool<T0>(arg0))
    }

    public fun claim_admin_fee<T0>(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::AdminCap, arg1: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_id(arg1), 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_version());
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::claim_admin_fee<T0>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::pool_mut<T0>(arg1), arg2)
    }

    public fun claim_reward<T0>(arg0: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge, arg1: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::user_deposit::UserDeposit<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_id(arg0), 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_version());
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::claim_reward<T0>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::pool_mut<T0>(arg0), arg1, arg2)
    }

    public fun deposit<T0>(arg0: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge, arg1: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::user_deposit::UserDeposit<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_id(arg0), 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_version());
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::deposit<T0>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::pool_mut<T0>(arg0), arg1, arg2, arg3)
    }

    public fun fee_share<T0>(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge) : u64 {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::fee_share<T0>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::pool<T0>(arg0))
    }

    public fun lp_amount<T0>(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::user_deposit::UserDeposit<T0>) : u64 {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::user_deposit::lp_amount<T0>(arg0)
    }

    public fun new_pool<T0>(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::AdminCap, arg1: &0x2::coin::CoinMetadata<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::Pool<T0> {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::new<T0>(arg1, arg2, arg3, arg4)
    }

    public fun new_user_deposit<T0>(arg0: &mut 0x2::tx_context::TxContext) : 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::user_deposit::UserDeposit<T0> {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::user_deposit::new<T0>(arg0)
    }

    public fun pool_a<T0>(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge) : u64 {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::a<T0>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::state<T0>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::pool<T0>(arg0)))
    }

    public fun pool_balance<T0>(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge) : u64 {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::balance<T0>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::pool<T0>(arg0))
    }

    public fun pool_d<T0>(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge) : u64 {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::d<T0>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::state<T0>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::pool<T0>(arg0)))
    }

    public fun pool_decimals<T0>(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge) : u8 {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::decimals<T0>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::pool<T0>(arg0))
    }

    public fun pool_lp_supply<T0>(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge) : u64 {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_rewards::lp_supply<T0>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::rewards<T0>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::pool<T0>(arg0)))
    }

    public fun pool_pending_rewards<T0>(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge, arg1: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::user_deposit::UserDeposit<T0>) : u64 {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_rewards::pending_rewards<T0>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::rewards<T0>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::pool<T0>(arg0)), arg1)
    }

    public fun pool_token_balance<T0>(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge) : u64 {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::token_balance<T0>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::state<T0>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::pool<T0>(arg0)))
    }

    public fun pool_vusd_balance<T0>(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge) : u64 {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::vusd_balance<T0>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::state<T0>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::pool<T0>(arg0)))
    }

    public fun receive_tokens<T0>(arg0: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge, arg1: &0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::Messenger, arg2: u64, arg3: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32, arg4: u8, arg5: u256, arg6: u64, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_id(arg0), 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_version());
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::receive_tokens_allbridge<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun reward_debt<T0>(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::user_deposit::UserDeposit<T0>) : u64 {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::user_deposit::reward_debt<T0>(arg0)
    }

    public fun set_admin_fee_share_bp<T0>(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::AdminCap, arg1: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge, arg2: u64) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_id(arg1), 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_version());
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::set_admin_fee_share_bp<T0>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::pool_mut<T0>(arg1), arg2);
    }

    public fun set_balance_ratio_min_bp<T0>(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::AdminCap, arg1: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge, arg2: u64) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_id(arg1), 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_version());
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::set_balance_ratio_min_bp<T0>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::pool_mut<T0>(arg1), arg2);
    }

    public fun set_fee_share<T0>(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::AdminCap, arg1: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge, arg2: u64) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_id(arg1), 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_version());
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::set_fee_share<T0>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::pool_mut<T0>(arg1), arg2);
    }

    public fun start_deposit<T0>(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::AdminCap, arg1: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_id(arg1), 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_version());
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::start_deposit<T0>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::pool_mut<T0>(arg1));
    }

    public fun start_withdraw<T0>(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::AdminCap, arg1: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_id(arg1), 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_version());
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::start_withdraw<T0>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::pool_mut<T0>(arg1));
    }

    public fun stop_deposit<T0>(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::StopCap, arg1: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_id(arg1), 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_version());
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::stop_deposit<T0>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::pool_mut<T0>(arg1));
    }

    public fun stop_withdraw<T0>(arg0: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::StopCap, arg1: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_id(arg1), 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_version());
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::stop_withdraw<T0>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::pool_mut<T0>(arg1));
    }

    public fun swap_and_bridge<T0>(arg0: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge, arg1: &mut 0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::Messenger, arg2: &0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle::GasOracle, arg3: 0x2::coin::Coin<T0>, arg4: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32, arg5: u8, arg6: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32, arg7: u256, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: 0x2::coin::Coin<T0>, arg10: &mut 0x2::tx_context::TxContext) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_id(arg0), 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_version());
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::swap_and_bridge_allbridge<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun withdraw<T0>(arg0: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::Bridge, arg1: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::user_deposit::UserDeposit<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::AdminCap>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_id(arg0), 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::get_version());
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::withdraw<T0>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge::pool_mut<T0>(arg0), arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

