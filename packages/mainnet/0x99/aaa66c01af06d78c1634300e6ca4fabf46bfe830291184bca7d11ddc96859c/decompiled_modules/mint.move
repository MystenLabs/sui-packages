module 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::mint {
    struct MintEvent has copy, drop {
        minter: address,
        deposit_asset: 0x1::type_name::TypeName,
        deposit_amount: u64,
        mint_asset: 0x1::type_name::TypeName,
        mint_amount: u64,
        time: u64,
    }

    public fun mint<T0>(arg0: &0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::version::Version, arg1: &mut 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::market::Market, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::reserve::MarketCoin<T0>> {
        0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::version::assert_current_version(arg0);
        assert!(0x78334396e159bd9a1393da1185dfe34f6ebfa8bd9e68987220a60393586ddcaf::whitelist::is_address_allowed(0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::market::uid(arg1), 0x2::tx_context::sender(arg4)), 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::error::whitelist_error());
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::market::is_base_asset_active(arg1, v0), 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::error::base_asset_not_active_error());
        let v1 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v2 = 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::market::handle_mint<T0>(arg1, 0x2::coin::into_balance<T0>(arg2), v1);
        let v3 = MintEvent{
            minter         : 0x2::tx_context::sender(arg4),
            deposit_asset  : v0,
            deposit_amount : 0x2::coin::value<T0>(&arg2),
            mint_asset     : 0x1::type_name::get<0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::reserve::MarketCoin<T0>>(),
            mint_amount    : 0x2::balance::value<0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::reserve::MarketCoin<T0>>(&v2),
            time           : v1,
        };
        0x2::event::emit<MintEvent>(v3);
        0x2::coin::from_balance<0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::reserve::MarketCoin<T0>>(v2, arg4)
    }

    public entry fun mint_entry<T0>(arg0: &0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::version::Version, arg1: &mut 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::market::Market, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = mint<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::reserve::MarketCoin<T0>>>(v0, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

