module 0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::trusted_pull_oracle {
    struct EventNewTrustedPullOracle has copy, drop {
        oracle_id: 0x2::object::ID,
        oracle_cap_id: 0x2::object::ID,
    }

    struct SignedPrice has copy, drop, store {
        base: 0x1::type_name::TypeName,
        quote: 0x1::type_name::TypeName,
        price: 0x1::uq32_32::UQ32_32,
    }

    struct SignedPricesData has copy, drop, store {
        expiry_time_ms: u64,
        prices: vector<SignedPrice>,
    }

    struct TrustedPullOracle has key {
        id: 0x2::object::UID,
        trusted_price_data_cap: 0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::trusted_prices::TrustedPriceDataCap,
        ed25519_public_key: vector<u8>,
    }

    struct TrustedPullOracleCap has store, key {
        id: 0x2::object::UID,
        oracle: 0x2::object::ID,
    }

    public fun new(arg0: 0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::trusted_prices::TrustedPriceDataCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : TrustedPullOracleCap {
        let v0 = TrustedPullOracle{
            id                     : 0x2::object::new(arg2),
            trusted_price_data_cap : arg0,
            ed25519_public_key     : arg1,
        };
        let v1 = TrustedPullOracleCap{
            id     : 0x2::object::new(arg2),
            oracle : 0x2::object::id<TrustedPullOracle>(&v0),
        };
        let v2 = EventNewTrustedPullOracle{
            oracle_id     : 0x2::object::id<TrustedPullOracle>(&v0),
            oracle_cap_id : 0x2::object::id<TrustedPullOracleCap>(&v1),
        };
        0x2::event::emit<EventNewTrustedPullOracle>(v2);
        0x2::transfer::share_object<TrustedPullOracle>(v0);
        v1
    }

    public fun make_trusted_prices_data(arg0: &TrustedPullOracle, arg1: vector<SignedPrice>, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::trusted_prices::TrustedPriceData {
        assert!(0x2::clock::timestamp_ms(arg4) < arg2, 2);
        let v0 = SignedPricesData{
            expiry_time_ms : arg2,
            prices         : arg1,
        };
        let v1 = 0x1::bcs::to_bytes<SignedPricesData>(&v0);
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg0.ed25519_public_key, &v1), 1);
        let v2 = 0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::trusted_prices::create_empty_trusted_price_data(&arg0.trusted_price_data_cap, arg5);
        0x1::vector::reverse<SignedPrice>(&mut arg1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<SignedPrice>(&arg1)) {
            let v4 = 0x1::vector::pop_back<SignedPrice>(&mut arg1);
            0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::trusted_prices::set_price_raw(&mut v2, v4.base, v4.quote, v4.price, &arg0.trusted_price_data_cap);
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<SignedPrice>(arg1);
        v2
    }

    public fun new_signed_price<T0, T1>(arg0: 0x1::uq32_32::UQ32_32) : SignedPrice {
        new_signed_price_raw(0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), arg0)
    }

    public fun new_signed_price_raw(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName, arg2: 0x1::uq32_32::UQ32_32) : SignedPrice {
        SignedPrice{
            base  : arg0,
            quote : arg1,
            price : arg2,
        }
    }

    public fun set_ed25519_public_key(arg0: &mut TrustedPullOracle, arg1: vector<u8>, arg2: &TrustedPullOracleCap) {
        assert!(arg2.oracle == 0x2::object::uid_to_inner(&arg0.id), 0);
        arg0.ed25519_public_key = arg1;
    }

    // decompiled from Move bytecode v6
}

