module 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::converter {
    struct AcceptQuoteEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        base_amount: u64,
        quote_amount: u64,
        base_for_quote: bool,
        quoter: address,
    }

    public fun compute_quote<T0, T1>(arg0: &0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::quote::Quote<T0, T1>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        let v1 = 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::quote::base_amount<T0, T1>(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&v1));
        let v2 = 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::quote::quote_amount<T0, T1>(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&v2));
        let v3 = 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::quote::timestamp_ms<T0, T1>(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&v3));
        0x2::hash::keccak256(&v0)
    }

    public fun convert_base_for_quote<T0, T1>(arg0: &mut 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::state::State, arg1: &mut 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::pool::Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T0>, arg3: 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::quote::Quote<T0, T1>, arg4: vector<vector<u8>>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::state::assert_version(arg0);
        0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::state::assert_not_pause(arg0);
        assert!(0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::quote::timestamp_ms<T0, T1>(&arg3) + (0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::state::quote_seconds_to_live(arg0) as u64) * 1000 > 0x2::clock::timestamp_ms(arg5), 3);
        let v0 = 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::quote::base_amount<T0, T1>(&arg3) - 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::quote::base_amount<T0, T1>(&arg3) % 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::pool::min_lot_size<T0, T1>(arg1);
        assert!(v0 >= 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::pool::min_lot_size<T0, T1>(arg1) && v0 <= 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::pool::max_lot_size<T0, T1>(arg1), 5);
        let v1 = 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::quote::quote_amount<T0, T1>(&arg3);
        assert!(v1 >= 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::pool::min_order_size<T0, T1>(arg1) && v1 <= 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::pool::max_order_size<T0, T1>(arg1), 6);
        assert!(0x2::coin::value<T0>(arg2) >= v0, 4);
        assert!(0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::pool::quote_balance<T0, T1>(arg1) >= v1, 4);
        verify_signatures(0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::state::borrow_guardians(arg0), arg4, compute_quote<T0, T1>(&arg3));
        0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::state::increase_tx_count(arg0);
        0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::pool::deposit<T0, T1>(arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, v0, arg6)), 0x2::balance::zero<T1>());
        let (v2, v3) = 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::pool::withdraw<T0, T1>(arg1, 0, v1);
        0x2::balance::destroy_zero<T0>(v2);
        let v4 = AcceptQuoteEvent{
            pool_id        : 0x2::object::id<0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::pool::Pool<T0, T1>>(arg1),
            base_amount    : v0,
            quote_amount   : v1,
            base_for_quote : true,
            quoter         : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<AcceptQuoteEvent>(v4);
        0x2::coin::from_balance<T1>(v3, arg6)
    }

    public fun convert_quote_for_base<T0, T1>(arg0: &mut 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::state::State, arg1: &mut 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::pool::Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T1>, arg3: 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::quote::Quote<T1, T0>, arg4: vector<vector<u8>>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::state::assert_version(arg0);
        0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::state::assert_not_pause(arg0);
        assert!(0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::quote::timestamp_ms<T1, T0>(&arg3) + (0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::state::quote_seconds_to_live(arg0) as u64) * 1000 > 0x2::clock::timestamp_ms(arg5), 3);
        let v0 = 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::quote::quote_amount<T1, T0>(&arg3) - 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::quote::quote_amount<T1, T0>(&arg3) % 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::pool::min_lot_size<T0, T1>(arg1);
        assert!(v0 >= 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::pool::min_lot_size<T0, T1>(arg1) && v0 <= 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::pool::max_lot_size<T0, T1>(arg1), 5);
        let v1 = 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::quote::base_amount<T1, T0>(&arg3);
        assert!(v1 >= 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::pool::min_order_size<T0, T1>(arg1) && v1 <= 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::pool::max_order_size<T0, T1>(arg1), 6);
        assert!(0x2::coin::value<T1>(arg2) >= v1, 4);
        assert!(0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::pool::base_balance<T0, T1>(arg1) >= v0, 4);
        verify_signatures(0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::state::borrow_guardians(arg0), arg4, compute_quote<T1, T0>(&arg3));
        0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::state::increase_tx_count(arg0);
        0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::pool::deposit<T0, T1>(arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg2, v1, arg6)));
        let (v2, v3) = 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::pool::withdraw<T0, T1>(arg1, v0, 0);
        0x2::balance::destroy_zero<T1>(v3);
        let v4 = AcceptQuoteEvent{
            pool_id        : 0x2::object::id<0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::pool::Pool<T0, T1>>(arg1),
            base_amount    : v0,
            quote_amount   : v1,
            base_for_quote : false,
            quoter         : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<AcceptQuoteEvent>(v4);
        0x2::coin::from_balance<T0>(v2, arg6)
    }

    fun verify_signatures(arg0: &vector<0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::guardian::Guardian>, arg1: vector<vector<u8>>, arg2: vector<u8>) {
        assert!(0x1::vector::length<vector<u8>>(&arg1) >= 0x1::vector::length<0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::guardian::Guardian>(arg0), 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg1)) {
            assert!(0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::guardian::verify(0x1::vector::borrow<0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::guardian::Guardian>(arg0, v0), *0x1::vector::borrow<vector<u8>>(&arg1, v0), arg2), 2);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

