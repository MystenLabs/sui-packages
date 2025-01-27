module 0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge_interface {
    public fun bridge<T0: drop>(arg0: &mut 0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::CctpBridge, arg1: &0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle::GasOracle, arg2: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg3: &mut 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg4: &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<T0>, arg5: &0x2::deny_list::DenyList, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: 0x2::coin::Coin<T0>, arg9: u8, arg10: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32, arg11: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32, arg12: &mut 0x2::tx_context::TxContext) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::AdminCap>(0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::get_id(arg0), 0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::get_version());
        0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::bridge<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun change_recipient<T0: drop>(arg0: &0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::CctpBridge, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32, arg4: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg5: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg6: &mut 0x2::tx_context::TxContext) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::AdminCap>(0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::get_id(arg0), 0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::get_version());
        0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::change_recipient<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun fee_value<T0>(arg0: &mut 0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::CctpBridge) : u64 {
        0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::fee_value<T0>(arg0)
    }

    public fun gas_usage(arg0: &0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::CctpBridge, arg1: u8) : u64 {
        0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::gas_usage(arg0, arg1)
    }

    public fun get_bridging_cost_in_tokens(arg0: &0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::CctpBridge, arg1: &0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle::GasOracle, arg2: u8) : u64 {
        0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::get_bridging_cost_in_tokens(arg0, arg1, arg2)
    }

    public fun get_domain_by_chain_id(arg0: &0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::CctpBridge, arg1: u8) : u32 {
        0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::get_domain_by_chain_id(arg0, arg1)
    }

    public fun get_transaction_cost(arg0: &0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::CctpBridge, arg1: &0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle::GasOracle, arg2: u8) : u64 {
        0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::get_transaction_cost(arg0, arg1, arg2)
    }

    public fun is_message_processed(arg0: &0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::CctpBridge, arg1: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg2: u8, arg3: u64) : bool {
        0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::is_message_processed(arg0, arg1, arg2, arg3)
    }

    entry fun migrate(arg0: &0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::AdminCap, arg1: &mut 0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::CctpBridge) {
        0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::migrate(arg0, arg1);
    }

    public fun receive_tokens<T0: drop>(arg0: &mut 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg1: &mut 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg2: &0x2::deny_list::DenyList, arg3: &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<T0>, arg4: address, arg5: vector<u8>, arg6: vector<u8>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::receive_tokens<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun register_bridge_destination(arg0: &0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::AdminCap, arg1: &mut 0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::CctpBridge, arg2: u8, arg3: u32) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::AdminCap>(0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::get_id(arg1), 0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::get_version());
        0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::register_bridge_destination(arg1, arg2, arg3);
    }

    public fun set_admin_fee_share(arg0: &0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::AdminCap, arg1: &mut 0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::CctpBridge, arg2: u64) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::AdminCap>(0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::get_id(arg1), 0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::get_version());
        0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::set_admin_fee_share(arg1, arg2);
    }

    public fun set_gas_usage(arg0: &0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::AdminCap, arg1: &mut 0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::CctpBridge, arg2: u8, arg3: u64) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::AdminCap>(0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::get_id(arg1), 0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::get_version());
        0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::set_gas_usage(arg1, arg2, arg3);
    }

    public fun unregister_bridge_destination(arg0: &0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::AdminCap, arg1: &mut 0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::CctpBridge, arg2: u8) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::AdminCap>(0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::get_id(arg1), 0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::get_version());
        0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::unregister_bridge_destination(arg1, arg2);
    }

    public fun withdraw_fee<T0>(arg0: &0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::AdminCap, arg1: &mut 0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::CctpBridge, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::AdminCap>(0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::get_id(arg1), 0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::get_version());
        0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::cctp_bridge::withdraw_fee<T0>(arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

