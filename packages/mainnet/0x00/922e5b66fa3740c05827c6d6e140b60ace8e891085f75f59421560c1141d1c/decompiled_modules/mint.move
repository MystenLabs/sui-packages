module 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::mint {
    struct MintEvent has copy, drop {
        minter: address,
        deposit_asset: 0x1::type_name::TypeName,
        deposit_amount: u64,
        mint_asset: 0x1::type_name::TypeName,
        mint_amount: u64,
        time: u64,
    }

    public fun mint<T0>(arg0: &0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::version::Version, arg1: &mut 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::market::Market, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::reserve::MarketCoin<T0>> {
        0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::version::assert_current_version(arg0);
        assert!(0x1318fdc90319ec9c24df1456d960a447521b0a658316155895014a6e39b5482f::whitelist::is_address_allowed(0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::market::uid(arg1), 0x2::tx_context::sender(arg4)), 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::error::whitelist_error());
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::market::is_base_asset_active(arg1, v0), 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::error::base_asset_not_active_error());
        let v1 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v2 = 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::market::handle_mint<T0>(arg1, 0x2::coin::into_balance<T0>(arg2), v1);
        let v3 = MintEvent{
            minter         : 0x2::tx_context::sender(arg4),
            deposit_asset  : v0,
            deposit_amount : 0x2::coin::value<T0>(&arg2),
            mint_asset     : 0x1::type_name::get<0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::reserve::MarketCoin<T0>>(),
            mint_amount    : 0x2::balance::value<0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::reserve::MarketCoin<T0>>(&v2),
            time           : v1,
        };
        0x2::event::emit<MintEvent>(v3);
        0x2::coin::from_balance<0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::reserve::MarketCoin<T0>>(v2, arg4)
    }

    public entry fun mint_entry<T0>(arg0: &0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::version::Version, arg1: &mut 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::market::Market, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = mint<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::reserve::MarketCoin<T0>>>(v0, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

