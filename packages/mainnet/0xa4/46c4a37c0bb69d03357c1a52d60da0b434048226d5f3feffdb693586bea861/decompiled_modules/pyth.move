module 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::pyth {
    public fun get_price(arg0: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::State, arg1: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price::Price {
        get_price_no_older_than(arg1, arg2, 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::get_stale_price_threshold_secs(arg0))
    }

    fun abs_diff(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            return arg0 - arg1
        };
        arg1 - arg0
    }

    fun check_price_is_fresh(arg0: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price::Price, arg1: &0x2::clock::Clock, arg2: u64) {
        assert!(abs_diff(0x2::clock::timestamp_ms(arg1) / 1000, 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price::get_timestamp(arg0)) < arg2, 3);
    }

    public fun create_price_feeds(arg0: &mut 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::State, arg1: vector<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::assert_latest_only(arg0);
        while (!0x1::vector::is_empty<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA>(&arg1)) {
            let v1 = 0x1::vector::pop_back<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA>(&mut arg1);
            assert!(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::is_valid_data_source(arg0, 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::data_source::new((0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::emitter_chain(&v1) as u64), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::emitter_address(&v1))), 1);
            let v2 = 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::batch_price_attestation::destroy(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::batch_price_attestation::deserialize(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_payload(v1), arg2));
            while (!0x1::vector::is_empty<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfo>(&v2)) {
                let v3 = 0x1::vector::pop_back<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfo>(&mut v2);
                if (!0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::price_feed_object_exists(arg0, 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_feed::get_price_identifier(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::get_price_feed(&v3)))) {
                    let v4 = 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::new_price_info_object(v3, arg3);
                    0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::register_price_info_object(&v0, arg0, 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::get_price_identifier(&v3), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::uid_to_inner(&v4));
                    0x2::transfer::public_share_object<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfoObject>(v4);
                };
            };
        };
        0x1::vector::destroy_empty<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA>(arg1);
    }

    public fun get_price_no_older_than(arg0: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfoObject, arg1: &0x2::clock::Clock, arg2: u64) : 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price::Price {
        let v0 = get_price_unsafe(arg0);
        check_price_is_fresh(&v0, arg1, arg2);
        v0
    }

    public fun get_price_unsafe(arg0: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfoObject) : 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price::Price {
        let v0 = 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::get_price_info_from_price_info_object(arg0);
        0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_feed::get_price(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::get_price_feed(&v0))
    }

    public fun get_stale_price_threshold_secs(arg0: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::State) : u64 {
        0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::get_stale_price_threshold_secs(arg0)
    }

    public fun get_total_update_fee(arg0: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::State, arg1: u64) : u64 {
        0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::get_base_update_fee(arg0) * arg1
    }

    public entry fun init_pyth(arg0: 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::setup::DeployerCap, arg1: 0x2::package::UpgradeCap, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: vector<u64>, arg6: vector<vector<u8>>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::setup::init_and_share_state(arg0, arg1, arg2, arg7, 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::data_source::new(arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::from_bytes(arg4))), parse_data_sources(arg5, arg6), arg8);
        0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::event::emit_pyth_initialization_event();
    }

    fun is_fresh_update(arg0: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfo, arg1: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfoObject) : bool {
        let v0 = 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_feed::get_price(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::get_price_feed(arg0));
        let v1 = 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::get_price_info_from_price_info_object(arg1);
        let v2 = 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_feed::get_price(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::get_price_feed(&v1));
        0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price::get_timestamp(&v0) > 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price::get_timestamp(&v2)
    }

    fun parse_data_sources(arg0: vector<u64>, arg1: vector<vector<u8>>) : vector<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::data_source::DataSource> {
        assert!(0x1::vector::length<u64>(&arg0) == 0x1::vector::length<vector<u8>>(&arg1), 0);
        let v0 = 0x1::vector::empty<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::data_source::DataSource>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            0x1::vector::push_back<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::data_source::DataSource>(&mut v0, 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::data_source::new(*0x1::vector::borrow<u64>(&arg0, v1), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::from_bytes(*0x1::vector::borrow<vector<u8>>(&arg1, v1)))));
            v1 = v1 + 1;
        };
        v0
    }

    public fun price_feed_exists(arg0: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::State, arg1: 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_identifier::PriceIdentifier) : bool {
        0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::price_feed_object_exists(arg0, arg1)
    }

    public(friend) fun update_cache(arg0: vector<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfo>, arg1: &mut vector<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfoObject>, arg2: &0x2::clock::Clock) {
        while (!0x1::vector::is_empty<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfo>(&arg0)) {
            let v0 = 0x1::vector::pop_back<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfo>(&mut arg0);
            let v1 = 0;
            let v2 = false;
            while (v1 < 0x1::vector::length<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfoObject>(arg1) && v2 == false) {
                let v3 = 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::get_price_info_from_price_info_object(0x1::vector::borrow<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfoObject>(arg1, v1));
                if (0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::get_price_identifier(&v3) == 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::get_price_identifier(&v0)) {
                    v2 = true;
                    if (is_fresh_update(&v0, 0x1::vector::borrow<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfoObject>(arg1, v1))) {
                        0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::event::emit_price_feed_update(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_feed::from(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::get_price_feed(&v0)), 0x2::clock::timestamp_ms(arg2) / 1000);
                        0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::update_price_info_object(0x1::vector::borrow_mut<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfoObject>(arg1, v1), v0);
                    };
                };
                v1 = v1 + 1;
            };
            if (!v2) {
                abort 4
            };
        };
        0x1::vector::destroy_empty<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfo>(arg0);
    }

    fun update_price_feed_from_single_vaa(arg0: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::State, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA, arg2: &mut vector<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfoObject>, arg3: &0x2::clock::Clock) {
        assert!(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::is_valid_data_source(arg0, 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::data_source::new((0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::emitter_chain(&arg1) as u64), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::emitter_address(&arg1))), 1);
        update_cache(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::batch_price_attestation::destroy(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::batch_price_attestation::deserialize(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_payload(arg1), arg3)), arg2, arg3);
    }

    public fun update_price_feeds(arg0: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::State, arg1: vector<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA>, arg2: &mut vector<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfoObject>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock) {
        0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::assert_latest_only(arg0);
        assert!(get_total_update_fee(arg0, 0x1::vector::length<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA>(&arg1)) <= 0x2::coin::value<0x2::sui::SUI>(&arg3), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::get_fee_recipient(arg0));
        while (!0x1::vector::is_empty<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA>(&arg1)) {
            update_price_feed_from_single_vaa(arg0, 0x1::vector::pop_back<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA>(&mut arg1), arg2, arg4);
        };
        0x1::vector::destroy_empty<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA>(arg1);
    }

    public fun update_price_feeds_if_fresh(arg0: vector<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA>, arg1: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::State, arg2: &mut vector<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfoObject>, arg3: vector<u64>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock) {
        assert!(0x1::vector::length<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfoObject>(arg2) == 0x1::vector::length<u64>(&arg3), 5);
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg3)) {
            let v2 = 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::get_price_info_from_price_info_object(0x1::vector::borrow<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfoObject>(arg2, v1));
            let v3 = 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_feed::get_price(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::get_price_feed(&v2));
            if (0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price::get_timestamp(&v3) < *0x1::vector::borrow<u64>(&arg3, v1)) {
                v0 = true;
                break
            };
            v1 = v1 + 1;
        };
        assert!(v0, 6);
        update_price_feeds(arg1, arg0, arg2, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

