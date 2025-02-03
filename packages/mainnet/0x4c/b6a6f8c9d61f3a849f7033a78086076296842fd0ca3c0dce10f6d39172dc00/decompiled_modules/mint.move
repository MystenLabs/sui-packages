module 0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::mint {
    struct MintEvent has copy, drop {
        minter: address,
        deposit_asset: 0x1::type_name::TypeName,
        deposit_amount: u64,
        mint_asset: 0x1::type_name::TypeName,
        mint_amount: u64,
        time: u64,
    }

    public fun mint<T0>(arg0: &0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::version::Version, arg1: &mut 0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::market::Market, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::reserve::MarketCoin<T0>> {
        0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::version::assert_current_version(arg0);
        assert!(0x59baf2f4eab98d6f8b9c5982aab0b6ac7213c96a8e7b08118b6c931b862adef9::whitelist::is_address_allowed(0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::market::uid(arg1), 0x2::tx_context::sender(arg4)), 0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::error::whitelist_error());
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::market::is_base_asset_active(arg1, v0), 0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::error::base_asset_not_active_error());
        let v1 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v2 = 0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::market::handle_mint<T0>(arg1, 0x2::coin::into_balance<T0>(arg2), v1);
        let v3 = MintEvent{
            minter         : 0x2::tx_context::sender(arg4),
            deposit_asset  : v0,
            deposit_amount : 0x2::coin::value<T0>(&arg2),
            mint_asset     : 0x1::type_name::get<0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::reserve::MarketCoin<T0>>(),
            mint_amount    : 0x2::balance::value<0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::reserve::MarketCoin<T0>>(&v2),
            time           : v1,
        };
        0x2::event::emit<MintEvent>(v3);
        0x2::coin::from_balance<0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::reserve::MarketCoin<T0>>(v2, arg4)
    }

    public entry fun mint_entry<T0>(arg0: &0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::version::Version, arg1: &mut 0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::market::Market, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = mint<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::reserve::MarketCoin<T0>>>(v0, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

