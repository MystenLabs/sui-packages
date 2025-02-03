module 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::mint {
    struct MintEvent has copy, drop {
        minter: address,
        deposit_asset: 0x1::type_name::TypeName,
        deposit_amount: u64,
        mint_asset: 0x1::type_name::TypeName,
        mint_amount: u64,
        time: u64,
    }

    public fun mint<T0>(arg0: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::version::Version, arg1: &mut 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market::Market, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::reserve::MarketCoin<T0>> {
        0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::version::assert_current_version(arg0);
        assert!(0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::whitelist::is_address_allowed(0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market::uid(arg1), 0x2::tx_context::sender(arg4)), 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::error::whitelist_error());
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market::is_base_asset_active(arg1, v0), 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::error::base_asset_not_active_error());
        let v1 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v2 = 0x2::coin::value<T0>(&arg2);
        let (v3, v4, v5, _) = 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::reserve::balance_sheet(0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::wit_table::borrow<0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::reserve::BalanceSheets, 0x1::type_name::TypeName, 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::reserve::BalanceSheet>(0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::reserve::balance_sheets(0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market::vault(arg1)), v0));
        assert!(v3 + v4 - v5 + v2 <= *0x2::dynamic_field::borrow<0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market_dynamic_keys::SupplyLimitKey, u64>(0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market::uid(arg1), 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market_dynamic_keys::supply_limit_key(v0)), 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::error::supply_limit_reached());
        let v7 = 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market::handle_mint<T0>(arg1, 0x2::coin::into_balance<T0>(arg2), v1);
        let v8 = MintEvent{
            minter         : 0x2::tx_context::sender(arg4),
            deposit_asset  : v0,
            deposit_amount : v2,
            mint_asset     : 0x1::type_name::get<0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::reserve::MarketCoin<T0>>(),
            mint_amount    : 0x2::balance::value<0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::reserve::MarketCoin<T0>>(&v7),
            time           : v1,
        };
        0x2::event::emit<MintEvent>(v8);
        0x2::coin::from_balance<0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::reserve::MarketCoin<T0>>(v7, arg4)
    }

    public entry fun mint_entry<T0>(arg0: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::version::Version, arg1: &mut 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market::Market, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = mint<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::reserve::MarketCoin<T0>>>(v0, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

