module 0x8602b7d91ff3ef2fba949fd430bff66598e57591e7436be6356dff7b4a50d89f::waye_purchaser {
    struct TokenPurchaser<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        admin: address,
        tokens_for_sale: 0x2::balance::Balance<T0>,
        raised_funds: 0x2::balance::Balance<T1>,
        price_per_token: u64,
        token_for_sale_decimals: u8,
        payment_token_decimals: u8,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct TokensPurchased has copy, drop {
        amount_purchased: u64,
        payment_amount: u64,
        buyer: address,
    }

    public fun add_tokens_for_sale<T0, T1>(arg0: &mut TokenPurchaser<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.tokens_for_sale, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun available_tokens<T0, T1>(arg0: &TokenPurchaser<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.tokens_for_sale)
    }

    fun calculate_output(arg0: u64, arg1: u64, arg2: u8, arg3: u8) : u64 {
        let v0 = if (arg2 >= arg3) {
            ((arg2 - arg3) as u8)
        } else {
            ((arg3 - arg2) as u8)
        };
        let v1 = if (arg2 >= arg3) {
            (arg0 as u128) * (1000000000 as u128) * 0x1::u128::pow(10, v0)
        } else {
            (arg0 as u128) * (1000000000 as u128) / 0x1::u128::pow(10, v0)
        };
        let v2 = v1 / (arg1 as u128);
        assert!(v2 <= 18446744073709551615, 3);
        (v2 as u64)
    }

    fun calculate_payment(arg0: u64, arg1: u64, arg2: u8, arg3: u8) : u64 {
        let v0 = if (arg2 >= arg3) {
            ((arg2 - arg3) as u8)
        } else {
            ((arg3 - arg2) as u8)
        };
        let v1 = if (arg2 >= arg3) {
            (arg0 as u128) * (arg1 as u128) / 0x1::u128::pow(10, v0)
        } else {
            (arg0 as u128) * (arg1 as u128) * 0x1::u128::pow(10, v0)
        };
        let v2 = v1 / (1000000000 as u128);
        assert!(v2 <= 18446744073709551615, 3);
        (v2 as u64)
    }

    public fun create_token_purchaser<T0, T1>(arg0: u64, arg1: u8, arg2: u8, arg3: &AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenPurchaser<T0, T1>{
            id                      : 0x2::object::new(arg4),
            admin                   : 0x2::tx_context::sender(arg4),
            tokens_for_sale         : 0x2::balance::zero<T0>(),
            raised_funds            : 0x2::balance::zero<T1>(),
            price_per_token         : arg0,
            token_for_sale_decimals : arg1,
            payment_token_decimals  : arg2,
        };
        0x2::transfer::share_object<TokenPurchaser<T0, T1>>(v0);
    }

    public fun get_price<T0, T1>(arg0: &TokenPurchaser<T0, T1>) : u64 {
        arg0.price_per_token
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun purchase_tokens<T0, T1>(arg0: &mut TokenPurchaser<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        let v1 = calculate_output(v0, arg0.price_per_token, arg0.token_for_sale_decimals, arg0.payment_token_decimals);
        assert!(v0 >= calculate_payment(arg2, arg0.price_per_token, arg0.token_for_sale_decimals, arg0.payment_token_decimals), 2);
        assert!(0x2::balance::value<T0>(&arg0.tokens_for_sale) >= v1, 1);
        assert!(v1 >= arg2, 4);
        0x2::balance::join<T1>(&mut arg0.raised_funds, 0x2::coin::into_balance<T1>(arg1));
        let v2 = TokensPurchased{
            amount_purchased : v1,
            payment_amount   : v0,
            buyer            : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<TokensPurchased>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.tokens_for_sale, v1), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun raised_funds<T0, T1>(arg0: &TokenPurchaser<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.raised_funds)
    }

    public fun update_price<T0, T1>(arg0: &mut TokenPurchaser<T0, T1>, arg1: u64, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.price_per_token = arg1;
    }

    public fun withdraw_raised_funds<T0, T1>(arg0: &mut TokenPurchaser<T0, T1>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.raised_funds, 0x2::balance::value<T1>(&arg0.raised_funds)), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun withdraw_tokens_for_sale<T0, T1>(arg0: &mut TokenPurchaser<T0, T1>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.tokens_for_sale, 0x2::balance::value<T0>(&arg0.tokens_for_sale)), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

