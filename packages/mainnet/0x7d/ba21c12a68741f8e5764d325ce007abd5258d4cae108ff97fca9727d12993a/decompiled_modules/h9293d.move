module 0x7dba21c12a68741f8e5764d325ce007abd5258d4cae108ff97fca9727d12993a::h9293d {
    struct H79b5f has copy, drop {
        hc3725: u64,
        he3bfa: 0x1::string::String,
        h4db0d: u64,
    }

    struct H356d9 has copy, drop {
        hc3725: u64,
        h332f0: 0x2::object::ID,
        h6773b: 0x1::string::String,
        h89e53: u256,
        h44928: u256,
        he7c93: u256,
    }

    struct H905a1 has copy, drop {
        hc3725: u64,
        h07498: 0x2::object::ID,
        hbd34d: 0x2::object::ID,
        ha8d50: u64,
        ha120b: vector<0x2::object::ID>,
        h3ace5: vector<bool>,
    }

    struct Hd0dab has copy, drop {
        h332f0: 0x2::object::ID,
        h14e98: u64,
        hbdd57: u64,
        h88e3d: u256,
        h80417: u256,
        h07948: u256,
        h36637: u64,
        h65778: u256,
        h0edcd: u256,
        hd9985: u256,
        h6ae5e: u256,
        hf4aa5: u256,
        h22b97: u256,
        h0ea91: u8,
        hf708b: u64,
        he3a37: u64,
    }

    struct H4a8d8 has copy, drop {
        hc3725: u64,
        h332f0: 0x2::object::ID,
        hacf35: u256,
        h89e53: u256,
        h44928: u256,
        h5205c: u256,
        h694b3: u256,
        ha2451: u64,
        h836dd: u256,
        hd8732: u256,
        hd5a1a: u256,
        h60b12: u256,
        hcdfd3: u256,
        he4d79: u256,
        hc2221: u256,
    }

    struct Hd58d9 has copy, drop {
        h332f0: 0x2::object::ID,
        hf3ee5: 0x1::option::Option<u64>,
        h2e816: 0x1::option::Option<u64>,
        h8719d: 0x1::option::Option<u256>,
        hde8be: 0x1::option::Option<u256>,
        hbaee6: 0x1::option::Option<u256>,
    }

    struct Hc7f8e has copy, drop {
        hc3725: u64,
        h332f0: 0x2::object::ID,
        h91ed3: 0x1::option::Option<u256>,
        ha9efd: u64,
    }

    struct H1736a has copy, drop {
        h7219d: u128,
        haf9bd: bool,
        h5d888: u64,
        h9e263: u64,
        hc773d: 0x1::option::Option<u64>,
    }

    struct Hccc70 has copy, drop {
        hc3725: 0x2::object::ID,
        h332f0: 0x2::object::ID,
        h1f3f6: vector<H1736a>,
        h4eafb: vector<H1736a>,
    }

    struct H869ab has copy, drop {
        hc3725: 0x2::object::ID,
        h332f0: 0x2::object::ID,
        hca48a: u64,
        hed78c: u64,
        hdaef6: u64,
        hbcb8a: u64,
        h100f5: u64,
    }

    struct H97166 has copy, drop {
        h332f0: 0x2::object::ID,
        h72acb: vector<H1736a>,
    }

    public fun h0f491<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x2::clock::Clock) {
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg1);
        if (!0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T0>(arg0, v0)) {
            return
        };
        let v1 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg0);
        let v2 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(arg0, v0);
        let v3 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::mark_price<T0>(arg0, arg2, arg4);
        let v4 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::collateral_oracle_price(v1, arg3, arg4);
        let v5 = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::effective_initial_margin_ratio(v2, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::margin_ratio_initial(v1));
        let v6 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::collateral_haircut(v1);
        let (v7, v8) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v2);
        let (v9, v10) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_base_amounts_by_side(v2);
        let (v11, v12) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::cum_funding_rates(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_state<T0>(arg0));
        let v13 = H4a8d8{
            hc3725 : v0,
            h332f0 : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(arg0),
            hacf35 : 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v2),
            h89e53 : v7,
            h44928 : v8,
            h5205c : v9,
            h694b3 : v10,
            ha2451 : 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_order_count(v2),
            h836dd : v5,
            hd8732 : 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::unrealized_pnl(v2, v3),
            hd5a1a : 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::margin_requirement(v2, v3, v5),
            h60b12 : 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::compute_free_collateral(v2, v4, v3, v5, v6),
            hcdfd3 : 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::compute_free_collateral_with_fundings(v2, v4, v3, v5, v11, v12, v6),
            he4d79 : v3,
            hc2221 : v4,
        };
        0x2::event::emit<H4a8d8>(v13);
    }

    public fun h0faef<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: vector<u128>) {
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::orderbook<T0>(arg0);
        let v1 = 0x1::vector::empty<H1736a>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u128>(&arg1)) {
            0x1::vector::push_back<H1736a>(&mut v1, h793ee(v0, *0x1::vector::borrow<u128>(&arg1, v2)));
            v2 = v2 + 1;
        };
        let v3 = H97166{
            h332f0 : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(arg0),
            h72acb : v1,
        };
        0x2::event::emit<H97166>(v3);
    }

    public fun h1a3ed(arg0: vector<u128>) : vector<H1736a> {
        let v0 = 0x1::vector::empty<H1736a>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u128>(&arg0)) {
            0x1::vector::push_back<H1736a>(&mut v0, h37d2b(*0x1::vector::borrow<u128>(&arg0, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun h1bf90(arg0: &0x7dba21c12a68741f8e5764d325ce007abd5258d4cae108ff97fca9727d12993a::h95cce::H032e6) {
        let (v0, v1) = 0x7dba21c12a68741f8e5764d325ce007abd5258d4cae108ff97fca9727d12993a::h95cce::hf19ba(arg0);
        let (v2, v3, v4, v5, v6) = 0x7dba21c12a68741f8e5764d325ce007abd5258d4cae108ff97fca9727d12993a::h95cce::h552f1(arg0);
        let v7 = H869ab{
            hc3725 : v0,
            h332f0 : v1,
            hca48a : v2,
            hed78c : v3,
            hdaef6 : v4,
            hbcb8a : v5,
            h100f5 : v6,
        };
        0x2::event::emit<H869ab>(v7);
    }

    public fun h37d2b(arg0: u128) : H1736a {
        hbdcc1(arg0, 0x1::option::none<u64>())
    }

    public fun h4d3ad<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>) : bool {
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T0>(arg0, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg1))
    }

    fun h5170b(arg0: &vector<0x1::option::Option<u128>>) : vector<H1736a> {
        let v0 = 0x1::vector::empty<H1736a>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::option::Option<u128>>(arg0)) {
            let v2 = 0x1::vector::borrow<0x1::option::Option<u128>>(arg0, v1);
            if (0x1::option::is_some<u128>(v2)) {
                0x1::vector::push_back<H1736a>(&mut v0, h37d2b(*0x1::option::borrow<u128>(v2)));
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun h561b3<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>) {
        let v0 = Hd58d9{
            h332f0 : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(arg0),
            hf3ee5 : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::best_price_u64<T0>(arg0, false),
            h2e816 : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::best_price_u64<T0>(arg0, true),
            h8719d : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::best_price<T0>(arg0, false),
            hde8be : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::best_price<T0>(arg0, true),
            hbaee6 : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::book_price<T0>(arg0),
        };
        0x2::event::emit<Hd58d9>(v0);
    }

    public fun h57445(arg0: &0x7dba21c12a68741f8e5764d325ce007abd5258d4cae108ff97fca9727d12993a::h95cce::H032e6) {
        let (v0, v1) = 0x7dba21c12a68741f8e5764d325ce007abd5258d4cae108ff97fca9727d12993a::h95cce::hf19ba(arg0);
        let (v2, v3) = 0x7dba21c12a68741f8e5764d325ce007abd5258d4cae108ff97fca9727d12993a::h95cce::ha3a8e(arg0);
        let v4 = v3;
        let v5 = v2;
        let v6 = Hccc70{
            hc3725 : v0,
            h332f0 : v1,
            h1f3f6 : h5170b(&v5),
            h4eafb : h5170b(&v4),
        };
        0x2::event::emit<Hccc70>(v6);
    }

    public fun h6c52f<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: vector<u8>) {
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg1);
        let (v1, v2, v3) = if (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T0>(arg0, v0)) {
            let v4 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(arg0, v0);
            let (v5, v6) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v4);
            (v5, v6, 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v4))
        } else {
            (0, 0, 0)
        };
        let v7 = H356d9{
            hc3725 : v0,
            h332f0 : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(arg0),
            h6773b : 0x1::string::utf8(arg2),
            h89e53 : v1,
            h44928 : v2,
            he7c93 : v3,
        };
        0x2::event::emit<H356d9>(v7);
    }

    public fun h6f4dc<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0x7dba21c12a68741f8e5764d325ce007abd5258d4cae108ff97fca9727d12993a::h95cce::H032e6) {
        let (v0, v1) = 0x7dba21c12a68741f8e5764d325ce007abd5258d4cae108ff97fca9727d12993a::h95cce::hf19ba(arg1);
        let v2 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::orderbook<T0>(arg0);
        let (v3, v4) = 0x7dba21c12a68741f8e5764d325ce007abd5258d4cae108ff97fca9727d12993a::h95cce::ha3a8e(arg1);
        let v5 = v4;
        let v6 = v3;
        let v7 = Hccc70{
            hc3725 : v0,
            h332f0 : v1,
            h1f3f6 : hefa5e(v2, &v6),
            h4eafb : hefa5e(v2, &v5),
        };
        0x2::event::emit<Hccc70>(v7);
    }

    fun h793ee(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::Orderbook, arg1: u128) : H1736a {
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::get_order(arg0, arg1);
        let v1 = if (0x1::option::is_some<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::Order>(&v0)) {
            let v2 = 0x1::option::extract<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::Order>(&mut v0);
            let (_, v4, _, _, _, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::as_parts(&v2);
            0x1::option::some<u64>(v4)
        } else {
            0x1::option::none<u64>()
        };
        hbdcc1(arg1, v1)
    }

    public fun h8af4d<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<u256>) {
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg1);
        let v1 = Hc7f8e{
            hc3725 : v0,
            h332f0 : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(arg0),
            h91ed3 : arg5,
            ha9efd : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::collateral_to_deallocate_for_margin_ratio<T0>(arg0, v0, arg2, arg3, arg4, arg5),
        };
        0x2::event::emit<Hc7f8e>(v1);
    }

    public fun h991a5<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg1: vector<u8>) {
        let v0 = H79b5f{
            hc3725 : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg0),
            he3bfa : 0x1::string::utf8(arg1),
            h4db0d : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::collateral_balance<T0>(arg0),
        };
        0x2::event::emit<H79b5f>(v0);
    }

    public fun h9f669<T0, T1>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: vector<0x2::object::ID>) {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg3)) {
            0x1::vector::push_back<bool>(&mut v0, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::is_account_assistant_cap_registered(arg2, *0x1::vector::borrow<0x2::object::ID>(&arg3, v1)));
            v1 = v1 + 1;
        };
        let v2 = H905a1{
            hc3725 : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg0),
            h07498 : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>>(arg0),
            hbd34d : 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::for<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, T1>(arg1),
            ha8d50 : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::collateral_balance<T0>(arg0),
            ha120b : arg3,
            h3ace5 : v0,
        };
        0x2::event::emit<H905a1>(v2);
    }

    fun hbdcc1(arg0: u128, arg1: 0x1::option::Option<u64>) : H1736a {
        H1736a{
            h7219d : arg0,
            haf9bd : 0x7dba21c12a68741f8e5764d325ce007abd5258d4cae108ff97fca9727d12993a::h5a57f::he7a1a(arg0),
            h5d888 : 0x7dba21c12a68741f8e5764d325ce007abd5258d4cae108ff97fca9727d12993a::h5a57f::h321c0(arg0),
            h9e263 : 0x7dba21c12a68741f8e5764d325ce007abd5258d4cae108ff97fca9727d12993a::h5a57f::h104d2(arg0),
            hc773d : arg1,
        }
    }

    public fun hc405e<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>) {
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg0);
        let v1 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_state<T0>(arg0);
        let (v2, v3) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::cum_funding_rates(v1);
        let (v4, v5) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::collateral_and_insurance_fund_balances<T0>(arg0);
        let v6 = Hd0dab{
            h332f0 : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(arg0),
            h14e98 : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::tick_size(v0),
            hbdd57 : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(v0),
            h88e3d : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::min_order_usd_value(v0),
            h80417 : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::margin_ratio_initial(v0),
            h07948 : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::margin_ratio_maintenance(v0),
            h36637 : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::max_pending_orders(v0),
            h65778 : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::max_open_interest(v0),
            h0edcd : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::open_interest(v1),
            hd9985 : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::scaling_factor(v0),
            h6ae5e : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::collateral_haircut(v0),
            hf4aa5 : v2,
            h22b97 : v3,
            h0ea91 : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_pause_mode<T0>(arg0),
            hf708b : v4,
            he3a37 : v5,
        };
        0x2::event::emit<Hd0dab>(v6);
    }

    fun hefa5e(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::Orderbook, arg1: &vector<0x1::option::Option<u128>>) : vector<H1736a> {
        let v0 = 0x1::vector::empty<H1736a>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::option::Option<u128>>(arg1)) {
            let v2 = 0x1::vector::borrow<0x1::option::Option<u128>>(arg1, v1);
            if (0x1::option::is_some<u128>(v2)) {
                0x1::vector::push_back<H1736a>(&mut v0, h793ee(arg0, *0x1::option::borrow<u128>(v2)));
            };
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

