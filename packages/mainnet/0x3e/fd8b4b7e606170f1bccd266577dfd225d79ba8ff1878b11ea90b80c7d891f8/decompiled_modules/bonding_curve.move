module 0x3efd8b4b7e606170f1bccd266577dfd225d79ba8ff1878b11ea90b80c7d891f8::bonding_curve {
    struct Curve<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        admin: address,
        token_reserve: 0x2::balance::Balance<T0>,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        virt_sui: u128,
        virt_token: u128,
        tokens_sold: u64,
        target_tokens_sold: u64,
        graduation_sui: u64,
        decimals: u8,
        is_graduated: bool,
    }

    struct CurveCreated has copy, drop {
        curve_id: 0x2::object::ID,
        creator: address,
        virt_sui: u128,
        virt_token: u128,
        target_tokens_sold: u64,
        graduation_sui: u64,
    }

    struct Bought has copy, drop {
        curve_id: 0x2::object::ID,
        buyer: address,
        sui_in: u64,
        tokens_out: u64,
        tokens_sold: u64,
        timestamp: u64,
    }

    struct Sold has copy, drop {
        curve_id: 0x2::object::ID,
        seller: address,
        tokens_in: u64,
        sui_out: u64,
        tokens_sold: u64,
        timestamp: u64,
    }

    struct Graduated has copy, drop {
        curve_id: 0x2::object::ID,
        final_sui: u64,
        final_tokens_sold: u64,
        timestamp: u64,
    }

    public fun new<T0>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u128, arg4: u128, arg5: u64, arg6: u64, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = Curve<T0>{
            id                 : 0x2::object::new(arg8),
            creator            : arg0,
            admin              : arg1,
            token_reserve      : 0x2::coin::into_balance<T0>(arg2),
            sui_reserve        : 0x2::balance::zero<0x2::sui::SUI>(),
            virt_sui           : arg3,
            virt_token         : arg4,
            tokens_sold        : 0,
            target_tokens_sold : arg5,
            graduation_sui     : arg6,
            decimals           : arg7,
            is_graduated       : false,
        };
        let v1 = CurveCreated{
            curve_id           : 0x2::object::id<Curve<T0>>(&v0),
            creator            : arg0,
            virt_sui           : arg3,
            virt_token         : arg4,
            target_tokens_sold : arg5,
            graduation_sui     : arg6,
        };
        0x2::event::emit<CurveCreated>(v1);
        0x2::transfer::share_object<Curve<T0>>(v0);
    }

    public entry fun buy<T0>(arg0: &mut Curve<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_graduated, 0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 4);
        let v1 = arg0.target_tokens_sold - arg0.tokens_sold;
        assert!(v1 > 0, 5);
        let v2 = arg0.virt_sui;
        let v3 = arg0.virt_token;
        let v4 = (((v3 as u256) * (v0 as u256) / ((v2 as u256) + (v0 as u256))) as u128);
        let v5 = false;
        let (v6, v7) = if ((v4 as u64) >= v1) {
            let v8 = ((((v2 as u256) * (v1 as u256) / ((v3 as u256) - (v1 as u256))) as u128) as u64);
            let v9 = if (v8 > v0) {
                v0
            } else {
                v8
            };
            v5 = true;
            (v9, v1)
        } else {
            (v0, (v4 as u64))
        };
        assert!(v7 >= arg2, 3);
        assert!(v7 > 0, 4);
        arg0.virt_sui = v2 + (v6 as u128);
        arg0.virt_token = v3 - (v7 as u128);
        arg0.tokens_sold = arg0.tokens_sold + v7;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v6, arg3)));
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.token_reserve, v7, arg3), 0x2::tx_context::sender(arg3));
        let v10 = Bought{
            curve_id    : 0x2::object::id<Curve<T0>>(arg0),
            buyer       : 0x2::tx_context::sender(arg3),
            sui_in      : v6,
            tokens_out  : v7,
            tokens_sold : arg0.tokens_sold,
            timestamp   : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<Bought>(v10);
        let v11 = if (v5) {
            true
        } else if (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) >= arg0.graduation_sui) {
            true
        } else {
            arg0.tokens_sold >= arg0.target_tokens_sold
        };
        if (v11) {
            arg0.is_graduated = true;
            let v12 = Graduated{
                curve_id          : 0x2::object::id<Curve<T0>>(arg0),
                final_sui         : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve),
                final_tokens_sold : arg0.tokens_sold,
                timestamp         : 0x2::tx_context::epoch_timestamp_ms(arg3),
            };
            0x2::event::emit<Graduated>(v12);
        };
    }

    public entry fun graduate_withdraw<T0>(arg0: &mut Curve<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 2);
        assert!(arg0.is_graduated, 1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_reserve, v0, arg1), arg0.admin);
        };
        let v1 = 0x2::balance::value<T0>(&arg0.token_reserve);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.token_reserve, v1, arg1), arg0.admin);
        };
    }

    public fun quote_buy<T0>(arg0: &Curve<T0>, arg1: u64) : u64 {
        (((arg0.virt_token as u256) * (arg1 as u256) / ((arg0.virt_sui as u256) + (arg1 as u256))) as u64)
    }

    public fun quote_sell<T0>(arg0: &Curve<T0>, arg1: u64) : u64 {
        (((arg0.virt_sui as u256) * (arg1 as u256) / ((arg0.virt_token as u256) + (arg1 as u256))) as u64)
    }

    public fun reserves<T0>(arg0: &Curve<T0>) : (u64, u64, u128, u128) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), 0x2::balance::value<T0>(&arg0.token_reserve), arg0.virt_sui, arg0.virt_token)
    }

    public entry fun sell<T0>(arg0: &mut Curve<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_graduated, 0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 4);
        let v1 = arg0.virt_sui;
        let v2 = arg0.virt_token;
        let v3 = (((v1 as u256) * (v0 as u256) / ((v2 as u256) + (v0 as u256))) as u64);
        assert!(v3 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), 3);
        assert!(v3 >= arg2, 3);
        arg0.virt_sui = v1 - (v3 as u128);
        arg0.virt_token = v2 + (v0 as u128);
        let v4 = if (v0 >= arg0.tokens_sold) {
            0
        } else {
            arg0.tokens_sold - v0
        };
        arg0.tokens_sold = v4;
        0x2::balance::join<T0>(&mut arg0.token_reserve, 0x2::coin::into_balance<T0>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_reserve, v3, arg3), 0x2::tx_context::sender(arg3));
        let v5 = Sold{
            curve_id    : 0x2::object::id<Curve<T0>>(arg0),
            seller      : 0x2::tx_context::sender(arg3),
            tokens_in   : v0,
            sui_out     : v3,
            tokens_sold : arg0.tokens_sold,
            timestamp   : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<Sold>(v5);
    }

    public entry fun set_admin<T0>(arg0: &mut Curve<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        arg0.admin = arg1;
    }

    public fun status<T0>(arg0: &Curve<T0>) : (u64, u64, u64, bool) {
        (arg0.tokens_sold, arg0.target_tokens_sold, arg0.graduation_sui, arg0.is_graduated)
    }

    // decompiled from Move bytecode v7
}

