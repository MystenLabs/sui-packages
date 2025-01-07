module 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::router {
    public entry fun buy<T0>(arg0: &mut 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::GlobalConfig, arg1: &mut 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::pool::UserIndexer, arg2: &mut 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::pool::Collection<T0>, arg3: &mut 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::pool::Order<T0>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::pool::buy<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun create_collection<T0>(arg0: &0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::GlobalConfig, arg1: &0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::config::GlobalConfig, arg2: &mut 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::pool::Collections, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::pool::create_collection<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun list_order<T0>(arg0: &0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::GlobalConfig, arg1: &mut 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::pool::Collection<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: u128, arg8: u64, arg9: &mut 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::pool::UserIndexer, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::pool::list_order<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun cancel<T0>(arg0: &0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::GlobalConfig, arg1: &mut 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::pool::Collection<T0>, arg2: &mut 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::pool::Order<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::pool::cancel_order_by_seller<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun suirc20_deploy(arg0: &mut 0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::config::GlobalConfig, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::suirc20::deploy(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun suirc20_mint(arg0: &mut 0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::suirc20::SUIRC20Tick, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::suirc20::mint(arg0, arg1, arg2, arg3);
    }

    public entry fun suirc20_transfer(arg0: 0x1::string::String, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::suirc20::transfer(arg0, arg1, arg2, arg3);
    }

    public entry fun suirc20_transfer_from(arg0: 0x1::string::String, arg1: u64, arg2: &0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::config::Account, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::suirc20::transfer_from(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

