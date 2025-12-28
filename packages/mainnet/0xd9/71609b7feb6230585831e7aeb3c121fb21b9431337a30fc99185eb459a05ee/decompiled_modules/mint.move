module 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::mint {
    struct MintEvent has copy, drop {
        minter: address,
        deposit_asset: 0x1::type_name::TypeName,
        deposit_amount: u64,
        mint_asset: 0x1::type_name::TypeName,
        mint_amount: u64,
        time: u64,
    }

    public fun mint<T0>(arg0: &0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::version::Version, arg1: &mut 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::Market, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::MarketCoin<T0>> {
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::version::assert_current_version(arg0);
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::assert_whitelist_access(arg1, arg4);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::is_base_asset_active(arg1, v0), 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::error::base_asset_not_active_error());
        assert!(0x2::coin::value<T0>(&arg2) > 0, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::error::mint_with_zero_amount_error());
        let v1 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v2 = 0x2::coin::value<T0>(&arg2);
        let (v3, v4, v5, _) = 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::BalanceSheet>(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::balance_sheets(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::vault(arg1)), v0));
        assert!(v3 + v4 - v5 + v2 <= *0x2::dynamic_field::borrow<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market_dynamic_keys::SupplyLimitKey, u64>(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::uid(arg1), 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market_dynamic_keys::supply_limit_key(v0)), 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::error::supply_limit_reached());
        let v7 = 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::handle_mint<T0>(arg1, 0x2::coin::into_balance<T0>(arg2), v1);
        let v8 = MintEvent{
            minter         : 0x2::tx_context::sender(arg4),
            deposit_asset  : v0,
            deposit_amount : v2,
            mint_asset     : 0x1::type_name::get<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::MarketCoin<T0>>(),
            mint_amount    : 0x2::balance::value<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::MarketCoin<T0>>(&v7),
            time           : v1,
        };
        0x2::event::emit<MintEvent>(v8);
        0x2::coin::from_balance<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::MarketCoin<T0>>(v7, arg4)
    }

    public entry fun mint_entry<T0>(arg0: &0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::version::Version, arg1: &mut 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::Market, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = mint<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::MarketCoin<T0>>>(v0, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

