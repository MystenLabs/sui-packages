module 0x8d5447b7b7d8372c16907a0b94c5e70a167665f488feaad9cceef69d41a29870::scallop {
    struct Deposited has copy, drop {
        protocol: 0x1::string::String,
        fund: 0x2::object::ID,
        input_type: 0x1::type_name::TypeName,
        in_amount: u64,
        output_type: 0x1::type_name::TypeName,
        output_amount: u64,
    }

    struct Withdrawed has copy, drop {
        protocol: 0x1::string::String,
        fund: 0x2::object::ID,
        input_type: 0x1::type_name::TypeName,
        in_amount: u64,
        output_type: 0x1::type_name::TypeName,
        output_amount: u64,
    }

    public fun deposit<T0>(arg0: &mut 0x8d5447b7b7d8372c16907a0b94c5e70a167665f488feaad9cceef69d41a29870::fund::Take_1_Liquidity_For_1_Liquidity_Request<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg1: 0x2::coin::Coin<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>> {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg2, arg3, arg1, arg4, arg5);
        0x8d5447b7b7d8372c16907a0b94c5e70a167665f488feaad9cceef69d41a29870::fund::supported_defi_confirm_1l_for_1l<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg0, 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v0));
        let v1 = Deposited{
            protocol      : 0x1::string::utf8(b"Scallop"),
            fund          : 0x8d5447b7b7d8372c16907a0b94c5e70a167665f488feaad9cceef69d41a29870::fund::fund_id_of_1l_for_1l_req<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg0),
            input_type    : 0x1::type_name::get<T0>(),
            in_amount     : 0x2::coin::value<T0>(&arg1),
            output_type   : 0x1::type_name::get<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(),
            output_amount : 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v0),
        };
        0x2::event::emit<Deposited>(v1);
        v0
    }

    public fun withdraw<T0>(arg0: &mut 0x8d5447b7b7d8372c16907a0b94c5e70a167665f488feaad9cceef69d41a29870::fund::Take_1_Liquidity_For_1_Liquidity_Request<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, T0>, arg1: 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg2, arg3, arg1, arg4, arg5);
        0x8d5447b7b7d8372c16907a0b94c5e70a167665f488feaad9cceef69d41a29870::fund::supported_defi_confirm_1l_for_1l<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, T0>(arg0, 0x2::coin::value<T0>(&v0));
        let v1 = Withdrawed{
            protocol      : 0x1::string::utf8(b"Scallop"),
            fund          : 0x8d5447b7b7d8372c16907a0b94c5e70a167665f488feaad9cceef69d41a29870::fund::fund_id_of_1l_for_1l_req<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, T0>(arg0),
            input_type    : 0x1::type_name::get<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(),
            in_amount     : 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg1),
            output_type   : 0x1::type_name::get<T0>(),
            output_amount : 0x2::coin::value<T0>(&v0),
        };
        0x2::event::emit<Withdrawed>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

