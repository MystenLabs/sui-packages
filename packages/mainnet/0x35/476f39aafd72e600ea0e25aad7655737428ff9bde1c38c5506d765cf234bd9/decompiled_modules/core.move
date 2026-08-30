module 0x35476f39aafd72e600ea0e25aad7655737428ff9bde1c38c5506d765cf234bd9::core {
    struct Data has key {
        id: 0x2::object::UID,
        v: u64,
        c: 0x1::option::Option<0x2::object::ID>,
        a1: address,
        a2: address,
        a3: address,
        t1: 0x2::table::Table<0x2::object::ID, bool>,
        t2: 0x2::table::Table<0x2::object::ID, Span>,
        t3: 0x2::table::Table<0x2::object::ID, Bound>,
        b: 0x2::bag::Bag,
        t4: 0x2::table::Table<0x2::object::ID, Meta>,
        p1: u64,
        p2: u64,
    }

    struct Span has drop, store {
        lo: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        hi: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
    }

    struct Bound has drop, store {
        x1: u128,
        x2: u128,
    }

    struct Meta has drop, store {
        k: vector<u8>,
        d0: u8,
        d1: u8,
        d2: u8,
        inv: bool,
    }

    struct Tag has copy, drop, store {
        dummy_field: bool,
    }

    public fun addr_of(arg0: &Data) : address {
        let v0 = 0x1::type_name::with_original_ids<Data>();
        let v1 = 0x1::type_name::address_string(&v0);
        0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1))
    }

    public fun calc_a(arg0: &Meta, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::get_price_no_older_than(arg1, arg3, arg2);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_info_from_price_info_object(arg1);
        let v2 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_identifier(&v1);
        assert!(arg0.k == 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_identifier::get_bytes(&v2), 115);
        let v3 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_expo(&v0);
        let v4 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_price(&v0);
        assert!(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&v3) == (arg0.d0 as u64), 119);
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v4)
    }

    public fun calc_b(arg0: &Meta, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg2: u64, arg3: &0x2::clock::Clock) : u256 {
        calc_c(arg0, calc_a(arg0, arg1, arg2, arg3))
    }

    public fun calc_c(arg0: &Meta, arg1: u64) : u256 {
        if (!arg0.inv) {
            (arg1 as u256) * 0x1::u256::pow(10, arg0.d2) * 340282366920938463463374607431768211456 / 0x1::u256::pow(10, arg0.d0) * 0x1::u256::pow(10, arg0.d1)
        } else {
            0x1::u256::pow(10, arg0.d0) * 0x1::u256::pow(10, arg0.d2) * 340282366920938463463374607431768211456 / (arg1 as u256) * 0x1::u256::pow(10, arg0.d1)
        }
    }

    fun chk_a<T0, T1>(arg0: &Data, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) : 0x2::object::ID {
        let v0 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg0.t1, v0), 104);
        v0
    }

    public(friend) fun chk_b<T0, T1>(arg0: &Data, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg4: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, Span>(&arg0.t2, v0), 107);
        let v1 = 0x2::table::borrow<0x2::object::ID, Span>(&arg0.t2, v0);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v1.lo, arg2) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v1.hi, arg3), 109);
        let v2 = calc_b(0x2::table::borrow<0x2::object::ID, Meta>(&arg0.t4, v0), arg4, arg0.p1, arg5);
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::create_tick(arg2);
        let v4 = 0x1::u256::pow((0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::sqrt_price(&v3) as u256), 2);
        let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::create_tick(arg3);
        let v6 = 0x1::u256::pow((0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::sqrt_price(&v5) as u256), 2);
        let v7 = 0x1::u256::pow((0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg1) as u256), 2);
        assert!(0x1::u256::min(v6, v4) >= 0x1::u256::max(v7, v2) || 0x1::u256::max(v6, v4) <= 0x1::u256::min(v7, v2), 122);
    }

    public(friend) fun chk_c(arg0: &Data, arg1: 0x2::object::ID, arg2: bool, arg3: u128, arg4: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &0x2::clock::Clock) {
        assert!(0x2::table::contains<0x2::object::ID, Bound>(&arg0.t3, arg1), 108);
        if (arg2) {
            assert!(0x2::table::borrow<0x2::object::ID, Bound>(&arg0.t3, arg1).x1 <= arg3, 110);
        } else {
            assert!(0x2::table::borrow<0x2::object::ID, Bound>(&arg0.t3, arg1).x2 >= arg3, 110);
        };
        if (arg2) {
            assert!(0x1::u256::pow((arg3 as u256), 2) >= calc_b(0x2::table::borrow<0x2::object::ID, Meta>(&arg0.t4, arg1), arg4, arg0.p1, arg5) * ((10000 - arg0.p2) as u256) / 10000, 121);
        } else {
            assert!(0x1::u256::pow((arg3 as u256), 2) <= calc_b(0x2::table::borrow<0x2::object::ID, Meta>(&arg0.t4, arg1), arg4, arg0.p1, arg5) * ((10000 + arg0.p2) as u256) / 10000, 121);
        };
    }

    fun chk_d(arg0: &Data) {
        assert!(arg0.v == 4, 100);
    }

    fun chk_e(arg0: &Data, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.a1, 101);
    }

    fun chk_f(arg0: &Data, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.a2, 102);
    }

    entry fun conf_a(arg0: &mut Data, arg1: &0x2::package::UpgradeCap, arg2: &0x2::tx_context::TxContext) {
        chk_e(arg0, arg2);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.c), 111);
        let v0 = 0x2::package::upgrade_package(arg1);
        assert!(0x2::object::id_to_address(&v0) == addr_of(arg0), 103);
        arg0.c = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::package::UpgradeCap>(arg1));
    }

    entry fun conf_b(arg0: &mut Data, arg1: address, arg2: 0x2::package::UpgradeCap, arg3: &0x2::tx_context::TxContext) {
        chk_d(arg0);
        chk_e(arg0, arg3);
        let v0 = 0x2::object::id<0x2::package::UpgradeCap>(&arg2);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.c, &v0), 103);
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(arg2, arg1);
        arg0.a1 = arg1;
    }

    entry fun conf_c(arg0: &mut Data, arg1: address, arg2: &0x2::tx_context::TxContext) {
        chk_d(arg0);
        chk_e(arg0, arg2);
        arg0.a2 = arg1;
    }

    entry fun conf_d(arg0: &mut Data, arg1: address, arg2: &0x2::tx_context::TxContext) {
        chk_d(arg0);
        chk_e(arg0, arg2);
        arg0.a3 = arg1;
    }

    entry fun conf_e(arg0: &mut Data, arg1: 0x2::object::ID, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        chk_d(arg0);
        chk_e(arg0, arg3);
        if (0x2::table::contains<0x2::object::ID, bool>(&arg0.t1, arg1)) {
            if (!arg2) {
                0x2::table::remove<0x2::object::ID, bool>(&mut arg0.t1, arg1);
            };
        } else if (arg2) {
            0x2::table::add<0x2::object::ID, bool>(&mut arg0.t1, arg1, true);
        };
    }

    entry fun conf_f(arg0: &mut Data, arg1: 0x2::object::ID, arg2: u32, arg3: u32, arg4: &0x2::tx_context::TxContext) {
        chk_d(arg0);
        chk_e(arg0, arg4);
        if (0x2::table::contains<0x2::object::ID, Span>(&arg0.t2, arg1)) {
            0x2::table::remove<0x2::object::ID, Span>(&mut arg0.t2, arg1);
        };
        let v0 = Span{
            lo : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg2),
            hi : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3),
        };
        0x2::table::add<0x2::object::ID, Span>(&mut arg0.t2, arg1, v0);
    }

    entry fun conf_g(arg0: &mut Data, arg1: 0x2::object::ID, arg2: u128, arg3: u128, arg4: &0x2::tx_context::TxContext) {
        chk_d(arg0);
        chk_e(arg0, arg4);
        if (0x2::table::contains<0x2::object::ID, Bound>(&arg0.t3, arg1)) {
            0x2::table::remove<0x2::object::ID, Bound>(&mut arg0.t3, arg1);
        };
        let v0 = Bound{
            x1 : arg2,
            x2 : arg3,
        };
        0x2::table::add<0x2::object::ID, Bound>(&mut arg0.t3, arg1, v0);
    }

    entry fun conf_h(arg0: &mut Data, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        chk_d(arg0);
        chk_e(arg0, arg2);
        arg0.p1 = arg1;
    }

    entry fun conf_i(arg0: &mut Data, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        chk_d(arg0);
        chk_e(arg0, arg2);
        assert!(arg1 <= 10000, 114);
        arg0.p2 = arg1;
    }

    entry fun conf_j<T0, T1>(arg0: &mut Data, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: vector<u8>, arg3: u8, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::coin::CoinMetadata<T1>, arg6: bool, arg7: &0x2::tx_context::TxContext) {
        chk_d(arg0);
        chk_e(arg0, arg7);
        let v0 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1);
        if (0x2::table::contains<0x2::object::ID, Meta>(&arg0.t4, v0)) {
            0x2::table::remove<0x2::object::ID, Meta>(&mut arg0.t4, v0);
        };
        0x2::table::add<0x2::object::ID, Meta>(&mut arg0.t4, v0, new_meta(arg2, arg3, 0x2::coin::get_decimals<T0>(arg4), 0x2::coin::get_decimals<T1>(arg5), arg6));
    }

    entry fun conf_k(arg0: &mut Data, arg1: &0x2::tx_context::TxContext) {
        chk_e(arg0, arg1);
        assert!(arg0.v < 4, 100);
        arg0.v = 4;
    }

    entry fun conf_l(arg0: &mut Data, arg1: u32, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        chk_d(arg0);
        chk_e(arg0, arg3);
        assert!(0x1::vector::length<u8>(&arg2) > 0, 124);
        let v0 = Tag{dummy_field: false};
        if (!0x2::dynamic_field::exists<Tag>(&arg0.id, v0)) {
            0x2::dynamic_field::add<Tag, 0x2::table::Table<u32, vector<u8>>>(&mut arg0.id, v0, 0x2::table::new<u32, vector<u8>>(arg3));
        };
        let v1 = 0x2::dynamic_field::borrow_mut<Tag, 0x2::table::Table<u32, vector<u8>>>(&mut arg0.id, v0);
        if (0x2::table::contains<u32, vector<u8>>(v1, arg1)) {
            0x2::table::remove<u32, vector<u8>>(v1, arg1);
        };
        0x2::table::add<u32, vector<u8>>(v1, arg1, arg2);
    }

    entry fun conf_m(arg0: &mut Data, arg1: u32, arg2: &0x2::tx_context::TxContext) {
        chk_d(arg0);
        chk_e(arg0, arg2);
        let v0 = Tag{dummy_field: false};
        assert!(0x2::dynamic_field::exists<Tag>(&arg0.id, v0), 123);
        let v1 = 0x2::dynamic_field::borrow_mut<Tag, 0x2::table::Table<u32, vector<u8>>>(&mut arg0.id, v0);
        assert!(0x2::table::contains<u32, vector<u8>>(v1, arg1), 123);
        0x2::table::remove<u32, vector<u8>>(v1, arg1);
    }

    fun do_a<T0, T1>(arg0: &mut Data, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u128, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg9: &0x2::clock::Clock) {
        let v0 = &mut arg0.b;
        let v1 = 0x2::balance::split<T0>(do_c<T0>(v0), arg3);
        let v2 = &mut arg0.b;
        let (v3, v4, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity<T0, T1>(arg9, arg1, arg2, arg8, v1, 0x2::balance::split<T1>(do_c<T1>(v2), arg4), arg7);
        assert!(v3 >= arg5, 112);
        assert!(v4 >= arg6, 113);
        let v7 = &mut arg0.b;
        0x2::balance::join<T0>(do_c<T0>(v7), v5);
        let v8 = &mut arg0.b;
        0x2::balance::join<T1>(do_c<T1>(v8), v6);
    }

    fun do_b<T0, T1>(arg0: &Data, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u32, arg4: u32, arg5: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position {
        chk_b<T0, T1>(arg0, arg2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg4), arg5, arg6);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, arg2, arg3, arg4, arg7)
    }

    fun do_c<T0>(arg0: &mut 0x2::bag::Bag) : &mut 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(arg0, v0), 106);
        0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, v0)
    }

    entry fun exec_a<T0>(arg0: &mut Data, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        chk_d(arg0);
        chk_f(arg0, arg2);
        let v0 = &mut arg0.b;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(do_c<T0>(v0), arg1, arg2), arg0.a3);
    }

    entry fun exec_b<T0>(arg0: &mut Data, arg1: &mut 0x2::tx_context::TxContext) {
        chk_d(arg0);
        chk_f(arg0, arg1);
        let v0 = &mut arg0.b;
        let v1 = do_c<T0>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v1, 0x2::balance::value<T0>(v1), arg1), 0x2::object::uid_to_address(&arg0.id));
    }

    entry fun exec_c(arg0: &mut Data, arg1: 0x2::transfer::Receiving<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg2: &0x2::tx_context::TxContext) {
        chk_d(arg0);
        chk_f(arg0, arg2);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(0x2::transfer::public_receive<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, arg1), arg0.a3);
    }

    entry fun exec_d<T0>(arg0: &mut Data, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: &0x2::tx_context::TxContext) {
        chk_d(arg0);
        chk_f(arg0, arg2);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.b, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.b, v0, 0x2::balance::zero<T0>());
        };
        0x2::coin::put<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.b, v0), 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1));
    }

    entry fun exec_e<T0>(arg0: &mut Data, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        chk_d(arg0);
        chk_f(arg0, arg2);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.b, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.b, v0, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.b, v0), 0x2::balance::redeem_funds<T0>(0x2::balance::withdraw_funds_from_object<T0>(&mut arg0.id, arg1)));
    }

    entry fun exec_f<T0, T1>(arg0: &Data, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u32, arg4: u32, arg5: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        chk_d(arg0);
        chk_f(arg0, arg7);
        chk_a<T0, T1>(arg0, arg2);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(do_b<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7), 0x2::object::uid_to_address(&arg0.id));
    }

    entry fun exec_g<T0, T1>(arg0: &mut Data, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u32, arg4: u32, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        chk_d(arg0);
        chk_f(arg0, arg12);
        chk_a<T0, T1>(arg0, arg2);
        let v0 = do_b<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg10, arg11, arg12);
        let v1 = &mut v0;
        do_a<T0, T1>(arg0, arg1, arg2, arg5, arg6, arg7, arg8, arg9, v1, arg11);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0, 0x2::object::uid_to_address(&arg0.id));
    }

    entry fun exec_h<T0, T1>(arg0: &mut Data, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u128, arg4: u64, arg5: u64, arg6: 0x2::transfer::Receiving<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        chk_d(arg0);
        chk_f(arg0, arg8);
        chk_a<T0, T1>(arg0, arg2);
        let v0 = 0x2::transfer::public_receive<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, arg6);
        let (v1, v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut v0, arg3, arg7);
        let v5 = v4;
        let v6 = v3;
        assert!(v1 >= arg4, 112);
        assert!(v2 >= arg5, 113);
        let (_, _, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg7, arg1, arg2, &mut v0);
        0x2::balance::join<T0>(&mut v6, v9);
        0x2::balance::join<T1>(&mut v5, v10);
        let v11 = &mut arg0.b;
        0x2::balance::join<T0>(do_c<T0>(v11), v6);
        let v12 = &mut arg0.b;
        0x2::balance::join<T1>(do_c<T1>(v12), v5);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0, 0x2::object::uid_to_address(&arg0.id));
    }

    entry fun exec_i<T0, T1>(arg0: &mut Data, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::transfer::Receiving<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        chk_d(arg0);
        chk_f(arg0, arg5);
        chk_a<T0, T1>(arg0, arg2);
        let v0 = 0x2::transfer::public_receive<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, arg3);
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v0) == 0, 105);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg4, arg1, arg2, v0);
    }

    entry fun exec_j<T0, T1>(arg0: &mut Data, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::transfer::Receiving<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        chk_d(arg0);
        chk_f(arg0, arg5);
        chk_a<T0, T1>(arg0, arg2);
        let v0 = 0x2::transfer::public_receive<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, arg3);
        let (_, _, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg4, arg1, arg2, &mut v0);
        let v5 = &mut arg0.b;
        0x2::balance::join<T0>(do_c<T0>(v5), v3);
        let v6 = &mut arg0.b;
        0x2::balance::join<T1>(do_c<T1>(v6), v4);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0, 0x2::object::uid_to_address(&arg0.id));
    }

    entry fun exec_k<T0, T1, T2>(arg0: &mut Data, arg1: &0x2::clock::Clock, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: 0x2::transfer::Receiving<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg5: &mut 0x2::tx_context::TxContext) {
        chk_d(arg0);
        chk_f(arg0, arg5);
        chk_a<T0, T1>(arg0, arg3);
        let v0 = 0x2::transfer::public_receive<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, arg4);
        let v1 = 0x2::object::uid_to_address(&arg0.id);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg1, arg2, arg3, &mut v0), arg5), v1);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0, v1);
    }

    entry fun exec_l<T0, T1>(arg0: &mut Data, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: &0x2::clock::Clock, arg12: &0x2::tx_context::TxContext) {
        chk_d(arg0);
        chk_f(arg0, arg12);
        chk_c(arg0, chk_a<T0, T1>(arg0, arg2), arg5, arg9, arg10, arg11);
        let v0 = &mut arg0.b;
        let v1 = 0x2::balance::split<T0>(do_c<T0>(v0), arg3);
        let v2 = &mut arg0.b;
        let (v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg11, arg1, arg2, v1, 0x2::balance::split<T1>(do_c<T1>(v2), arg4), arg5, arg6, arg7, arg8, arg9);
        let v5 = &mut arg0.b;
        0x2::balance::join<T0>(do_c<T0>(v5), v3);
        let v6 = &mut arg0.b;
        0x2::balance::join<T1>(do_c<T1>(v6), v4);
    }

    public fun exec_n(arg0: &mut Data, arg1: &0x7ab08860460bbf5357d940a9b2c2655b05eef3574dc6aacf49ade3b2e328fc69::messenger_oapp::State, arg2: &mut 0xfcc3a7785cee55c4e9e7a34efc865cd3dd3671544c914c756d56c27b9792413a::mtoken::State<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>, arg3: &mut 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg4: u32, arg5: vector<u8>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>, 0x7ab08860460bbf5357d940a9b2c2655b05eef3574dc6aacf49ade3b2e328fc69::messenger_oapp::SendContext) {
        chk_d(arg0);
        chk_f(arg0, arg8);
        let v0 = &mut arg0.b;
        0x7ab08860460bbf5357d940a9b2c2655b05eef3574dc6aacf49ade3b2e328fc69::messenger_oapp::send_token(arg1, arg2, arg3, arg4, arg5, arg6, param_d(arg0, arg4), 0x2::coin::take<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(do_c<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(v0), arg7, arg8), arg8)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Data{
            id : 0x2::object::new(arg0),
            v  : 4,
            c  : 0x1::option::none<0x2::object::ID>(),
            a1 : v0,
            a2 : v0,
            a3 : v0,
            t1 : 0x2::table::new<0x2::object::ID, bool>(arg0),
            t2 : 0x2::table::new<0x2::object::ID, Span>(arg0),
            t3 : 0x2::table::new<0x2::object::ID, Bound>(arg0),
            b  : 0x2::bag::new(arg0),
            t4 : 0x2::table::new<0x2::object::ID, Meta>(arg0),
            p1 : 90,
            p2 : 100,
        };
        0x2::transfer::share_object<Data>(v1);
    }

    public(friend) fun new_meta(arg0: vector<u8>, arg1: u8, arg2: u8, arg3: u8, arg4: bool) : Meta {
        Meta{
            k   : arg0,
            d0  : arg1,
            d1  : arg2,
            d2  : arg3,
            inv : arg4,
        }
    }

    public fun param_a(arg0: &Data) : u64 {
        arg0.p1
    }

    public fun param_b(arg0: &Data) : u64 {
        arg0.p2
    }

    public fun param_c(arg0: &Data, arg1: u32) : bool {
        let v0 = Tag{dummy_field: false};
        if (!0x2::dynamic_field::exists<Tag>(&arg0.id, v0)) {
            return false
        };
        0x2::table::contains<u32, vector<u8>>(0x2::dynamic_field::borrow<Tag, 0x2::table::Table<u32, vector<u8>>>(&arg0.id, v0), arg1)
    }

    public fun param_d(arg0: &Data, arg1: u32) : vector<u8> {
        let v0 = Tag{dummy_field: false};
        assert!(0x2::dynamic_field::exists<Tag>(&arg0.id, v0), 123);
        let v1 = 0x2::dynamic_field::borrow<Tag, 0x2::table::Table<u32, vector<u8>>>(&arg0.id, v0);
        assert!(0x2::table::contains<u32, vector<u8>>(v1, arg1), 123);
        *0x2::table::borrow<u32, vector<u8>>(v1, arg1)
    }

    // decompiled from Move bytecode v7
}

