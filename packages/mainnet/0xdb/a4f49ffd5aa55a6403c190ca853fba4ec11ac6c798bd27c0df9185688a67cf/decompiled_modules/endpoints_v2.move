module 0xdba4f49ffd5aa55a6403c190ca853fba4ec11ac6c798bd27c0df9185688a67cf::endpoints_v2 {
    struct BookStatus has copy, drop, store {
        price: vector<u64>,
        depths: vector<u64>,
    }

    struct AsksAndBids has copy, drop, store {
        asks: BookStatus,
        bids: BookStatus,
    }

    public entry fun account_balance<T0, T1>(arg0: &0xdee9::clob_v2::Pool<T0, T1>, arg1: &0xdee9::custodian_v2::AccountCap) : (u64, u64, u64, u64) {
        0xdee9::clob_v2::account_balance<T0, T1>(arg0, arg1)
    }

    public entry fun batch_cancel_order<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: vector<u64>, arg2: &0xdee9::custodian_v2::AccountCap) {
        0xdee9::clob_v2::batch_cancel_order<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun cancel_all_orders<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: &0xdee9::custodian_v2::AccountCap) {
        0xdee9::clob_v2::cancel_all_orders<T0, T1>(arg0, arg1);
    }

    public entry fun cancel_order<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: &0xdee9::custodian_v2::AccountCap) {
        0xdee9::clob_v2::cancel_order<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun create_account(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xdee9::custodian_v2::AccountCap>(0xdee9::clob_v2::create_account(arg0), 0x2::tx_context::sender(arg0));
    }

    public entry fun create_pool<T0, T1>(arg0: u64, arg1: u64, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = combine_spit_coins<0x2::sui::SUI>(arg2, arg3, arg4);
        0xdee9::clob_v2::create_pool<T0, T1>(arg0, arg1, v0, arg4);
    }

    public entry fun deposit_base<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T0>>, arg2: &0xdee9::custodian_v2::AccountCap, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xdee9::clob_v2::deposit_base<T0, T1>(arg0, combine_spit_coins<T0>(arg1, arg3, arg4), arg2);
    }

    public entry fun deposit_quote<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T1>>, arg2: &0xdee9::custodian_v2::AccountCap, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xdee9::clob_v2::deposit_quote<T0, T1>(arg0, combine_spit_coins<T1>(arg1, arg3, arg4), arg2);
    }

    public entry fun get_level2_book_status_ask_side<T0, T1>(arg0: &0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        let (v0, v1) = 0xdee9::clob_v2::get_level2_book_status_ask_side<T0, T1>(arg0, arg1, arg2, arg3);
        let v2 = BookStatus{
            price  : v0,
            depths : v1,
        };
        0x2::event::emit<BookStatus>(v2);
    }

    public entry fun get_level2_book_status_bid_side<T0, T1>(arg0: &0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        let (v0, v1) = 0xdee9::clob_v2::get_level2_book_status_bid_side<T0, T1>(arg0, arg1, arg2, arg3);
        let v2 = BookStatus{
            price  : v0,
            depths : v1,
        };
        0x2::event::emit<BookStatus>(v2);
    }

    public entry fun list_open_orders<T0, T1>(arg0: &0xdee9::clob_v2::Pool<T0, T1>, arg1: &0xdee9::custodian_v2::AccountCap) : vector<0xdee9::clob_v2::Order> {
        0xdee9::clob_v2::list_open_orders<T0, T1>(arg0, arg1)
    }

    public entry fun place_limit_order<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: bool, arg4: u64, arg5: u8, arg6: &0x2::clock::Clock, arg7: &0xdee9::custodian_v2::AccountCap, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64, bool, u64) {
        0xdee9::clob_v2::place_limit_order<T0, T1>(arg0, 0, arg1, arg2, 0, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public entry fun place_market_order<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: &0xdee9::custodian_v2::AccountCap, arg2: u64, arg3: bool, arg4: vector<0x2::coin::Coin<T0>>, arg5: vector<0x2::coin::Coin<T1>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = combine_coins<T0>(arg4, arg7);
        let v1 = combine_coins<T1>(arg5, arg7);
        let (v2, v3) = 0xdee9::clob_v2::place_market_order<T0, T1>(arg0, arg1, 0, arg2, arg3, v0, v1, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, 0x2::tx_context::sender(arg7));
    }

    public entry fun withdraw_base<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: &0xdee9::custodian_v2::AccountCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xdee9::clob_v2::withdraw_base<T0, T1>(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_quote<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: &0xdee9::custodian_v2::AccountCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xdee9::clob_v2::withdraw_quote<T0, T1>(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    fun combine_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
            0x2::coin::zero<T0>(arg1)
        } else {
            let v1 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
            0x2::pay::join_vec<T0>(&mut v1, arg0);
            v1
        }
    }

    fun combine_spit_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = combine_coins<T0>(arg0, arg2);
        send_coin<T0>(v0, 0x2::tx_context::sender(arg2));
        0x2::coin::split<T0>(&mut v0, arg1, arg2)
    }

    public entry fun get_pool_bids_and_asks<T0, T1>(arg0: &0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        let (v0, v1) = 0xdee9::clob_v2::get_level2_book_status_ask_side<T0, T1>(arg0, arg1, arg2, arg3);
        let (v2, v3) = 0xdee9::clob_v2::get_level2_book_status_bid_side<T0, T1>(arg0, arg1, arg2, arg3);
        let v4 = BookStatus{
            price  : v0,
            depths : v1,
        };
        let v5 = BookStatus{
            price  : v2,
            depths : v3,
        };
        let v6 = AsksAndBids{
            asks : v4,
            bids : v5,
        };
        0x2::event::emit<AsksAndBids>(v6);
    }

    fun send_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public entry fun swap_base_for_quote<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: &0xdee9::custodian_v2::AccountCap, arg3: u64, arg4: vector<0x2::coin::Coin<T0>>, arg5: vector<0x2::coin::Coin<T1>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = combine_spit_coins<T0>(arg4, arg1, arg7);
        let v1 = combine_coins<T1>(arg5, arg7);
        let (v2, v3, v4) = 0xdee9::clob_v2::swap_exact_base_for_quote<T0, T1>(arg0, 0, arg2, arg1, v0, v1, arg6, arg7);
        assert!(v4 >= arg3, 1);
        send_coin<T0>(v2, 0x2::tx_context::sender(arg7));
        send_coin<T1>(v3, 0x2::tx_context::sender(arg7));
        v4
    }

    public entry fun swap_quote_for_base<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: &0xdee9::custodian_v2::AccountCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: vector<0x2::coin::Coin<T1>>, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = combine_coins<T1>(arg5, arg6);
        let (v1, v2, v3) = 0xdee9::clob_v2::swap_exact_quote_for_base<T0, T1>(arg0, 0, arg1, arg2, arg4, v0, arg6);
        assert!(v3 >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg6));
        v3
    }

    // decompiled from Move bytecode v6
}

