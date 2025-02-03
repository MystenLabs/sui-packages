module 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::mint {
    struct MintEvent has copy, drop {
        minter: address,
        deposit_asset: 0x1::type_name::TypeName,
        deposit_amount: u64,
        mint_asset: 0x1::type_name::TypeName,
        mint_amount: u64,
        time: u64,
    }

    public fun mint<T0>(arg0: &mut 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::Market, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::reserve::MarketCoin<T0>> {
        assert!(0x4168e1c807a2d1f4cf301e9ce5fbd6e58f54a86751b02df176d89672489ceea8::whitelist::is_address_allowed(0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::uid(arg0), 0x2::tx_context::sender(arg3)), 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::error::whitelist_error());
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v1 = 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::handle_mint<T0>(arg0, 0x2::coin::into_balance<T0>(arg1), v0);
        let v2 = MintEvent{
            minter         : 0x2::tx_context::sender(arg3),
            deposit_asset  : 0x1::type_name::get<T0>(),
            deposit_amount : 0x2::coin::value<T0>(&arg1),
            mint_asset     : 0x1::type_name::get<0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::reserve::MarketCoin<T0>>(),
            mint_amount    : 0x2::balance::value<0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::reserve::MarketCoin<T0>>(&v1),
            time           : v0,
        };
        0x2::event::emit<MintEvent>(v2);
        0x2::coin::from_balance<0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::reserve::MarketCoin<T0>>(v1, arg3)
    }

    public fun mint_entry<T0>(arg0: &mut 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::Market, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = mint<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::reserve::MarketCoin<T0>>>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

