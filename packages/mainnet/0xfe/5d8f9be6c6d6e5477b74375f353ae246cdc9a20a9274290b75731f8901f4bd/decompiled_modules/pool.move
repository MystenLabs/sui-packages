module 0xfe5d8f9be6c6d6e5477b74375f353ae246cdc9a20a9274290b75731f8901f4bd::pool {
    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        pool_number: u64,
        creator: address,
        coin_type: 0x1::type_name::TypeName,
        recipient: address,
        price_mist_per_token: u64,
        coin_decimals: u8,
        initial_deposit: u64,
        timestamp_ms: u64,
    }

    struct ReserveDeposited has copy, drop {
        pool_id: 0x2::object::ID,
        pool_creator: address,
        depositor: address,
        amount: u64,
        new_reserve: u64,
        total_sui_deposited_after: u64,
        timestamp_ms: u64,
    }

    struct Redeemed has copy, drop {
        pool_id: 0x2::object::ID,
        pool_creator: address,
        redeemer: address,
        coin_type: 0x1::type_name::TypeName,
        coin_recipient: address,
        coin_in: u64,
        sui_gross: u64,
        fee: u64,
        sui_out: u64,
        reserve_after: u64,
        total_coin_redeemed_after: u64,
        total_sui_paid_out_after: u64,
        timestamp_ms: u64,
    }

    struct RedeemPool<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        recipient: address,
        price_mist_per_token: u64,
        coin_decimals: u8,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        total_sui_deposited: u64,
        total_sui_paid_out: u64,
        total_coin_redeemed: u64,
        created_at_ms: u64,
    }

    public fun coin_decimals<T0>(arg0: &RedeemPool<T0>) : u8 {
        arg0.coin_decimals
    }

    public fun create_pool<T0>(arg0: &mut 0xfe5d8f9be6c6d6e5477b74375f353ae246cdc9a20a9274290b75731f8901f4bd::platform::RedeemPlatform, arg1: &0x2::coin::CoinMetadata<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xfe5d8f9be6c6d6e5477b74375f353ae246cdc9a20a9274290b75731f8901f4bd::platform::assert_not_paused(arg0);
        assert!(arg3 > 0, 100);
        assert!(arg4 != @0x0, 101);
        let v0 = 0x2::coin::get_decimals<T0>(arg1);
        assert!(v0 <= 38, 102);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = 0x2::tx_context::sender(arg6);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v4 = RedeemPool<T0>{
            id                   : 0x2::object::new(arg6),
            creator              : v2,
            recipient            : arg4,
            price_mist_per_token : arg3,
            coin_decimals        : v0,
            sui_reserve          : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
            total_sui_deposited  : v3,
            total_sui_paid_out   : 0,
            total_coin_redeemed  : 0,
            created_at_ms        : v1,
        };
        let v5 = PoolCreated{
            pool_id              : 0x2::object::id<RedeemPool<T0>>(&v4),
            pool_number          : 0xfe5d8f9be6c6d6e5477b74375f353ae246cdc9a20a9274290b75731f8901f4bd::platform::bump_pool_counter(arg0),
            creator              : v2,
            coin_type            : 0x1::type_name::with_defining_ids<T0>(),
            recipient            : arg4,
            price_mist_per_token : arg3,
            coin_decimals        : v0,
            initial_deposit      : v3,
            timestamp_ms         : v1,
        };
        0x2::event::emit<PoolCreated>(v5);
        0x2::transfer::share_object<RedeemPool<T0>>(v4);
    }

    public fun created_at_ms<T0>(arg0: &RedeemPool<T0>) : u64 {
        arg0.created_at_ms
    }

    public fun creator<T0>(arg0: &RedeemPool<T0>) : address {
        arg0.creator
    }

    public fun deposit_reserve<T0>(arg0: &mut RedeemPool<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 300);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total_sui_deposited = arg0.total_sui_deposited + v0;
        let v1 = ReserveDeposited{
            pool_id                   : 0x2::object::id<RedeemPool<T0>>(arg0),
            pool_creator              : arg0.creator,
            depositor                 : 0x2::tx_context::sender(arg3),
            amount                    : v0,
            new_reserve               : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve),
            total_sui_deposited_after : arg0.total_sui_deposited,
            timestamp_ms              : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ReserveDeposited>(v1);
    }

    public fun max_redeemable_coin<T0>(arg0: &RedeemPool<T0>) : u64 {
        if (arg0.price_mist_per_token == 0) {
            return 0
        };
        let v0 = (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) as u128) * pow10_u128(arg0.coin_decimals) / (arg0.price_mist_per_token as u128);
        if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0 as u64)
        }
    }

    fun pow10_u128(arg0: u8) : u128 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun price_mist_per_token<T0>(arg0: &RedeemPool<T0>) : u64 {
        arg0.price_mist_per_token
    }

    public fun recipient<T0>(arg0: &RedeemPool<T0>) : address {
        arg0.recipient
    }

    public fun redeem<T0>(arg0: &mut RedeemPool<T0>, arg1: &mut 0xfe5d8f9be6c6d6e5477b74375f353ae246cdc9a20a9274290b75731f8901f4bd::platform::RedeemPlatform, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xfe5d8f9be6c6d6e5477b74375f353ae246cdc9a20a9274290b75731f8901f4bd::platform::assert_not_paused(arg1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 200);
        let v1 = (v0 as u128) * (arg0.price_mist_per_token as u128) / pow10_u128(arg0.coin_decimals);
        assert!(v1 <= 18446744073709551615, 203);
        let v2 = (v1 as u64);
        assert!(v2 > 0, 201);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) >= v2, 202);
        let v3 = (((v2 as u128) * (0xfe5d8f9be6c6d6e5477b74375f353ae246cdc9a20a9274290b75731f8901f4bd::platform::fee_bps_internal(arg1) as u128) / (10000 as u128)) as u64);
        let v4 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v2);
        if (v3 > 0) {
            0xfe5d8f9be6c6d6e5477b74375f353ae246cdc9a20a9274290b75731f8901f4bd::platform::deposit_fee(arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v4, v3));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg0.recipient);
        arg0.total_sui_paid_out = arg0.total_sui_paid_out + v2;
        arg0.total_coin_redeemed = arg0.total_coin_redeemed + v0;
        let v5 = Redeemed{
            pool_id                   : 0x2::object::id<RedeemPool<T0>>(arg0),
            pool_creator              : arg0.creator,
            redeemer                  : 0x2::tx_context::sender(arg4),
            coin_type                 : 0x1::type_name::with_defining_ids<T0>(),
            coin_recipient            : arg0.recipient,
            coin_in                   : v0,
            sui_gross                 : v2,
            fee                       : v3,
            sui_out                   : v2 - v3,
            reserve_after             : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve),
            total_coin_redeemed_after : arg0.total_coin_redeemed,
            total_sui_paid_out_after  : arg0.total_sui_paid_out,
            timestamp_ms              : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<Redeemed>(v5);
        0x2::coin::from_balance<0x2::sui::SUI>(v4, arg4)
    }

    public fun sui_reserve_balance<T0>(arg0: &RedeemPool<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve)
    }

    public fun total_coin_redeemed<T0>(arg0: &RedeemPool<T0>) : u64 {
        arg0.total_coin_redeemed
    }

    public fun total_sui_deposited<T0>(arg0: &RedeemPool<T0>) : u64 {
        arg0.total_sui_deposited
    }

    public fun total_sui_paid_out<T0>(arg0: &RedeemPool<T0>) : u64 {
        arg0.total_sui_paid_out
    }

    // decompiled from Move bytecode v7
}

