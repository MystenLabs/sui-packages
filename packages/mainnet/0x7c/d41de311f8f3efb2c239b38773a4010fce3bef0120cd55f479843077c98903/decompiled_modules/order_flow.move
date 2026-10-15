module 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_flow {
    struct OrderFlow has drop {
        dummy_field: bool,
    }

    public(friend) fun admit_mint(arg0: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Account, arg3: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg4: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg5: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg6: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u8, arg18: u64, arg19: u64, arg20: &0x2::clock::Clock, arg21: &0x2::tx_context::TxContext) : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt {
        let v0 = OrderFlow{dummy_field: false};
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::admit_mint<OrderFlow>(v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21)
    }

    public(friend) fun admit_sell(arg0: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Account, arg3: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt, arg4: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg5: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg6: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg7: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u8, arg14: u64, arg15: u64, arg16: &0x2::clock::Clock, arg17: &0x2::tx_context::TxContext) {
        let v0 = OrderFlow{dummy_field: false};
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::admit_sell<OrderFlow>(v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
    }

    public(friend) fun commit(arg0: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt, arg3: &0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::LazerPrice, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        let v0 = OrderFlow{dummy_field: false};
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::commit<OrderFlow>(v0, arg0, arg1, arg2, arg3, arg4)
    }

    public(friend) fun try_fill(arg0: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt, arg3: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x2::deny_list::DenyList, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : (u8, 0x1::option::Option<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt>, 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, u64, u64, u64, u64, u64, u64, u64) {
        let v0 = OrderFlow{dummy_field: false};
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::try_fill<OrderFlow>(v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    // decompiled from Move bytecode v7
}

