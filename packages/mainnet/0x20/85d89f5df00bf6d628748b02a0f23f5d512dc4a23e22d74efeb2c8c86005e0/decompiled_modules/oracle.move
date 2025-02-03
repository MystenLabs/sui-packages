module 0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::oracle {
    struct Oracle<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        feeds: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        time_limit: u64,
        deviation: u256,
    }

    struct Report has copy, drop, store {
        price: u256,
        timestamp: u64,
    }

    struct Request {
        oracle: 0x2::object::ID,
        feeds: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        reports: vector<Report>,
    }

    struct Price {
        oracle: 0x2::object::ID,
        price: u256,
        decimals: u8,
        timestamp: u64,
    }

    public fun new<T0: drop>(arg0: &mut 0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::owner::OwnerCap<T0>, arg1: T0, arg2: vector<0x1::type_name::TypeName>, arg3: u64, arg4: u256, arg5: &mut 0x2::tx_context::TxContext) : Oracle<T0> {
        assert!(arg3 != 0, 1);
        assert!(arg4 != 0, 2);
        let v0 = Oracle<T0>{
            id         : 0x2::object::new(arg5),
            feeds      : 0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::vectors::to_vec_set<0x1::type_name::TypeName>(arg2),
            time_limit : arg3,
            deviation  : arg4,
        };
        0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::owner::add<T0>(arg0, arg1, 0x2::object::id<Oracle<T0>>(&v0));
        v0
    }

    public fun remove<T0: drop>(arg0: &mut Oracle<T0>, arg1: &0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::owner::OwnerCap<T0>, arg2: 0x1::type_name::TypeName) {
        0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::owner::assert_ownership<T0>(arg1, 0x2::object::id<Oracle<T0>>(arg0));
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.feeds, &arg2);
    }

    public fun oracle(arg0: &Price) : 0x2::object::ID {
        arg0.oracle
    }

    public fun add<T0: drop>(arg0: &mut Oracle<T0>, arg1: &0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::owner::OwnerCap<T0>, arg2: 0x1::type_name::TypeName) {
        0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::owner::assert_ownership<T0>(arg1, 0x2::object::id<Oracle<T0>>(arg0));
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.feeds, arg2);
    }

    public fun decimals(arg0: &Price) : u8 {
        arg0.decimals
    }

    public fun destroy_oracle<T0: drop>(arg0: Oracle<T0>) {
        let Oracle {
            id         : v0,
            feeds      : _,
            time_limit : _,
            deviation  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_price(arg0: Price) : (0x2::object::ID, u256, u8, u64) {
        let Price {
            oracle    : v0,
            price     : v1,
            decimals  : v2,
            timestamp : v3,
        } = arg0;
        (v0, v1, v2, v3)
    }

    public fun destroy_request<T0: drop>(arg0: &Oracle<T0>, arg1: Request, arg2: &0x2::clock::Clock) : Price {
        let Request {
            oracle  : v0,
            feeds   : v1,
            reports : v2,
        } = arg1;
        let v3 = v2;
        assert!(v0 == 0x2::object::id<Oracle<T0>>(arg0), 3);
        let v4 = 0x2::vec_set::size<0x1::type_name::TypeName>(&arg0.feeds);
        assert!(v4 == 0x1::vector::length<Report>(&v3), 4);
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(arg0.feeds);
        let v9 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(v1);
        while (v4 > v5) {
            let v10 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v8, v5);
            let v11 = *0x1::vector::borrow<Report>(&v3, v5);
            assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v9, &v10), 5);
            assert!(v11.timestamp + arg0.time_limit >= 0x2::clock::timestamp_ms(arg2), 6);
            if (v5 == 0) {
                v6 = v11.price;
                v7 = v11.timestamp;
            } else {
                assert!(arg0.deviation >= 0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::math256::mul_div_up(0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::math256::diff(v6, v11.price), 1000000000000000000, v6), 8);
            };
            v5 = v5 + 1;
        };
        Price{
            oracle    : v0,
            price     : v6,
            decimals  : 18,
            timestamp : v7,
        }
    }

    public fun deviation<T0: drop>(arg0: &Oracle<T0>) : u256 {
        arg0.deviation
    }

    public fun feeds<T0: drop>(arg0: &Oracle<T0>) : vector<0x1::type_name::TypeName> {
        0x2::vec_set::into_keys<0x1::type_name::TypeName>(arg0.feeds)
    }

    public fun price(arg0: &Price) : u256 {
        arg0.price
    }

    public fun report<T0: drop>(arg0: &mut Request, arg1: T0, arg2: u64, arg3: u128, arg4: u8) {
        assert!(arg3 != 0, 7);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.feeds, 0x1::type_name::get<T0>());
        let v0 = Report{
            price     : 0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::math256::mul_div_down((arg3 as u256), 1000000000000000000, 0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::math256::pow(10, (arg4 as u256))),
            timestamp : arg2,
        };
        0x1::vector::push_back<Report>(&mut arg0.reports, v0);
    }

    public fun request<T0: drop>(arg0: &Oracle<T0>) : Request {
        assert!(0x2::vec_set::size<0x1::type_name::TypeName>(&arg0.feeds) != 0, 0);
        Request{
            oracle  : 0x2::object::id<Oracle<T0>>(arg0),
            feeds   : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            reports : 0x1::vector::empty<Report>(),
        }
    }

    public fun share<T0: drop>(arg0: Oracle<T0>) {
        0x2::transfer::share_object<Oracle<T0>>(arg0);
    }

    public fun time_limit<T0: drop>(arg0: &Oracle<T0>) : u64 {
        arg0.time_limit
    }

    public fun timestamp(arg0: &Price) : u64 {
        arg0.timestamp
    }

    public fun uid<T0: drop>(arg0: &Oracle<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public fun uid_mut<T0: drop>(arg0: &mut Oracle<T0>, arg1: &0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::owner::OwnerCap<T0>) : &mut 0x2::object::UID {
        0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::owner::assert_ownership<T0>(arg1, 0x2::object::id<Oracle<T0>>(arg0));
        &mut arg0.id
    }

    public fun update_deviation<T0: drop>(arg0: &mut Oracle<T0>, arg1: &0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::owner::OwnerCap<T0>, arg2: u256) {
        0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::owner::assert_ownership<T0>(arg1, 0x2::object::id<Oracle<T0>>(arg0));
        assert!(arg2 != 0, 2);
        arg0.deviation = arg2;
    }

    public fun update_time_limit<T0: drop>(arg0: &mut Oracle<T0>, arg1: &0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::owner::OwnerCap<T0>, arg2: u64) {
        0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::owner::assert_ownership<T0>(arg1, 0x2::object::id<Oracle<T0>>(arg0));
        assert!(arg2 != 0, 1);
        arg0.time_limit = arg2;
    }

    // decompiled from Move bytecode v6
}

