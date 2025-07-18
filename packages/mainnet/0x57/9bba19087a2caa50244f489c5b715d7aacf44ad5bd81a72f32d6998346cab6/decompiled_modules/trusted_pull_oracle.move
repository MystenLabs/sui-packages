module 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::trusted_pull_oracle {
    struct EventNewTrustedPullOracle has copy, drop {
        oracle_id: 0x2::object::ID,
        oracle_cap_id: 0x2::object::ID,
    }

    struct SignedPrice has copy, drop, store {
        asset: 0x1::type_name::TypeName,
        price: 0x1::uq32_32::UQ32_32,
    }

    struct SignedPricesData has copy, drop, store {
        expiry_time_ms: u64,
        prices: vector<SignedPrice>,
    }

    struct TrustedPullOracle has key {
        id: 0x2::object::UID,
        trusted_price_data_cap: 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::trusted_prices::TrustedPriceDataCap,
        ed25519_public_key: vector<u8>,
    }

    struct TrustedPullOracleCap has store, key {
        id: 0x2::object::UID,
        oracle: 0x2::object::ID,
    }

    public fun new(arg0: 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::trusted_prices::TrustedPriceDataCap, arg1: vector<u8>, arg2: &mut 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::global::GlobalInfo, arg3: &mut 0x2::tx_context::TxContext) : TrustedPullOracleCap {
        let v0 = TrustedPullOracle{
            id                     : 0x2::object::new(arg3),
            trusted_price_data_cap : arg0,
            ed25519_public_key     : arg1,
        };
        let v1 = TrustedPullOracleCap{
            id     : 0x2::object::new(arg3),
            oracle : 0x2::object::id<TrustedPullOracle>(&v0),
        };
        let v2 = EventNewTrustedPullOracle{
            oracle_id     : 0x2::object::id<TrustedPullOracle>(&v0),
            oracle_cap_id : 0x2::object::id<TrustedPullOracleCap>(&v1),
        };
        0x2::event::emit<EventNewTrustedPullOracle>(v2);
        0x2::transfer::share_object<TrustedPullOracle>(v0);
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::global::update_shared_object_id<TrustedPullOracleCap>(arg2, b"trusted_oracle", &v1);
        v1
    }

    public(friend) fun assert_for_oracle(arg0: &TrustedPullOracleCap, arg1: &TrustedPullOracle) {
        assert!(arg0.oracle == 0x2::object::uid_to_inner(&arg1.id), 0);
    }

    public fun destroy(arg0: TrustedPullOracle, arg1: TrustedPullOracleCap) : 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::trusted_prices::TrustedPriceDataCap {
        assert_for_oracle(&arg1, &arg0);
        let TrustedPullOracle {
            id                     : v0,
            trusted_price_data_cap : v1,
            ed25519_public_key     : _,
        } = arg0;
        0x2::object::delete(v0);
        let TrustedPullOracleCap {
            id     : v3,
            oracle : _,
        } = arg1;
        0x2::object::delete(v3);
        v1
    }

    public fun make_trusted_prices_data(arg0: &TrustedPullOracle, arg1: vector<SignedPrice>, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::trusted_prices::TrustedPriceData {
        assert!(0x2::clock::timestamp_ms(arg4) < arg2, 2);
        let v0 = SignedPricesData{
            expiry_time_ms : arg2,
            prices         : arg1,
        };
        let v1 = 0x1::bcs::to_bytes<SignedPricesData>(&v0);
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg0.ed25519_public_key, &v1), 1);
        let v2 = 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::trusted_prices::create_empty_trusted_price_data(&arg0.trusted_price_data_cap, arg5);
        0x1::vector::reverse<SignedPrice>(&mut arg1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<SignedPrice>(&arg1)) {
            let v4 = 0x1::vector::pop_back<SignedPrice>(&mut arg1);
            0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::trusted_prices::set_price_raw(&mut v2, v4.asset, v4.price, &arg0.trusted_price_data_cap);
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<SignedPrice>(arg1);
        v2
    }

    public fun new_signed_price<T0>(arg0: 0x1::uq32_32::UQ32_32) : SignedPrice {
        new_signed_price_raw(0x1::type_name::get<T0>(), arg0)
    }

    public fun new_signed_price_raw(arg0: 0x1::type_name::TypeName, arg1: 0x1::uq32_32::UQ32_32) : SignedPrice {
        SignedPrice{
            asset : arg0,
            price : arg1,
        }
    }

    public fun oracle_id(arg0: &TrustedPullOracleCap) : 0x2::object::ID {
        arg0.oracle
    }

    public fun set_ed25519_public_key(arg0: &mut TrustedPullOracle, arg1: vector<u8>, arg2: &TrustedPullOracleCap) {
        assert_for_oracle(arg2, arg0);
        arg0.ed25519_public_key = arg1;
    }

    // decompiled from Move bytecode v6
}

