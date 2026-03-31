module 0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::swap {
    struct Swap has copy, drop {
        pool_id: 0x2::object::ID,
        is_buy: bool,
        amount_in: u64,
        amount_out: u64,
        fee_bps: u64,
        price_after: u64,
        trader: address,
    }

    public fun buy<T0>(arg0: &mut 0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::pool::Pool<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::pool::current_fee_bps<T0>(arg0, arg3);
        let v2 = 0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::pool::real_token_reserve<T0>(arg0);
        let v3 = 0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::pool::real_sui_reserve<T0>(arg0);
        let v4 = 0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::pool::virtual_sui_mist<T0>(arg0);
        let v5 = 0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::swap_math::get_amount_out(v0, v2, v3, v4, v1);
        assert!(v5 >= arg2, 0);
        0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::pool::deposit_sui<T0>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::pool::withdraw_tokens<T0>(arg0, v5, arg4), 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::pool::withdraw_creator_fee<T0>(arg0, v0, arg4), 0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::pool::pool_creator<T0>(arg0));
        0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::pool::record_swap<T0>(arg0, v0);
        let v6 = Swap{
            pool_id     : 0x2::object::id<0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::pool::Pool<T0>>(arg0),
            is_buy      : true,
            amount_in   : v0,
            amount_out  : v5,
            fee_bps     : v1,
            price_after : 0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::swap_math::spot_price_mist(v2 - v5, v3 + v0, v4),
            trader      : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<Swap>(v6);
    }

    public fun sell<T0>(arg0: &mut 0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::pool::Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::pool::current_fee_bps<T0>(arg0, arg3);
        let v2 = 0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::pool::real_token_reserve<T0>(arg0);
        let v3 = 0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::pool::real_sui_reserve<T0>(arg0);
        let v4 = 0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::pool::virtual_sui_mist<T0>(arg0);
        let v5 = 0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::swap_math::get_sui_out(v0, v2, v3, v4, v1);
        assert!(v5 >= arg2, 0);
        0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::pool::deposit_tokens<T0>(arg0, arg1);
        let v6 = 0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::pool::withdraw_sui<T0>(arg0, v5, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v6, (((v5 as u128) * (0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::pool::creator_fee_bps<T0>(arg0) as u128) / 10000) as u64), arg4), 0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::pool::pool_creator<T0>(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v6, 0x2::tx_context::sender(arg4));
        0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::pool::record_swap<T0>(arg0, v5);
        let v7 = Swap{
            pool_id     : 0x2::object::id<0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::pool::Pool<T0>>(arg0),
            is_buy      : false,
            amount_in   : v0,
            amount_out  : v5,
            fee_bps     : v1,
            price_after : 0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::swap_math::spot_price_mist(v2 + v0, v3 - v5, v4),
            trader      : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<Swap>(v7);
    }

    // decompiled from Move bytecode v6
}

