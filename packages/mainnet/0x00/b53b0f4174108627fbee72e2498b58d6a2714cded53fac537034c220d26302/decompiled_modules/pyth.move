module 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth {
    public fun get_price(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::Price {
        get_price_no_older_than(arg1, arg2, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::get_stale_price_threshold_secs(arg0))
    }

    fun abs_diff(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            return arg0 - arg1
        };
        arg1 - arg0
    }

    fun check_price_is_fresh(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::Price, arg1: &0x2::clock::Clock, arg2: u64) {
        assert!(abs_diff(0x2::clock::timestamp_ms(arg1) / 1000, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_timestamp(arg0)) < arg2, 3);
    }

    public fun create_price_feeds(arg0: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg1: vector<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::assert_latest_only(arg0);
        while (!0x1::vector::is_empty<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA>(&arg1)) {
            let v1 = 0x1::vector::pop_back<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA>(&mut arg1);
            assert!(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::is_valid_data_source(arg0, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::data_source::new((0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::emitter_chain(&v1) as u64), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::emitter_address(&v1))), 1);
            let v2 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::batch_price_attestation::destroy(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::batch_price_attestation::deserialize(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_payload(v1), arg2));
            while (!0x1::vector::is_empty<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfo>(&v2)) {
                let v3 = 0x1::vector::pop_back<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfo>(&mut v2);
                if (!0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::price_feed_object_exists(arg0, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_feed::get_price_identifier(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::get_price_feed(&v3)))) {
                    let v4 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::new_price_info_object(v3, arg3);
                    0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::register_price_info_object(&v0, arg0, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::get_price_identifier(&v3), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::uid_to_inner(&v4));
                    0x2::transfer::public_share_object<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject>(v4);
                };
            };
        };
        0x1::vector::destroy_empty<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA>(arg1);
    }

    public fun create_price_infos_hot_potato(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg1: vector<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA>, arg2: &0x2::clock::Clock) : 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::hot_potato_vector::HotPotatoVector<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfo> {
        0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::assert_latest_only(arg0);
        let v0 = 0x1::vector::empty<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfo>();
        while (0x1::vector::length<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA>(&arg1) != 0) {
            let v1 = 0x1::vector::pop_back<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA>(&mut arg1);
            assert!(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::is_valid_data_source(arg0, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::data_source::new((0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::emitter_chain(&v1) as u64), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::emitter_address(&v1))), 1);
            let v2 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::batch_price_attestation::destroy(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::batch_price_attestation::deserialize(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_payload(v1), arg2));
            while (0x1::vector::length<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfo>(&v2) != 0) {
                0x1::vector::push_back<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfo>(&mut v0, 0x1::vector::pop_back<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfo>(&mut v2));
            };
        };
        0x1::vector::destroy_empty<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA>(arg1);
        0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::hot_potato_vector::new<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfo>(v0)
    }

    public fun get_price_no_older_than(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg1: &0x2::clock::Clock, arg2: u64) : 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::Price {
        let v0 = get_price_unsafe(arg0);
        check_price_is_fresh(&v0, arg1, arg2);
        v0
    }

    public fun get_price_unsafe(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject) : 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::Price {
        let v0 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::get_price_info_from_price_info_object(arg0);
        0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_feed::get_price(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::get_price_feed(&v0))
    }

    public fun get_stale_price_threshold_secs(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State) : u64 {
        0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::get_stale_price_threshold_secs(arg0)
    }

    public fun get_total_update_fee(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg1: u64) : u64 {
        0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::get_base_update_fee(arg0) * arg1
    }

    fun has_same_price_identifier(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfo, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject) : bool {
        let v0 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::get_price_info_from_price_info_object(arg1);
        0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::get_price_identifier(&v0) == 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::get_price_identifier(arg0)
    }

    public entry fun init_pyth(arg0: 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::setup::DeployerCap, arg1: 0x2::package::UpgradeCap, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: vector<u64>, arg6: vector<vector<u8>>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::setup::init_and_share_state(arg0, arg1, arg2, arg7, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::data_source::new(arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::from_bytes(arg4))), parse_data_sources(arg5, arg6), arg8);
        0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::event::emit_pyth_initialization_event();
    }

    fun is_fresh_update(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfo, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject) : bool {
        let v0 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_feed::get_price(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::get_price_feed(arg0));
        let v1 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::get_price_info_from_price_info_object(arg1);
        let v2 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_feed::get_price(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::get_price_feed(&v1));
        0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_timestamp(&v0) > 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_timestamp(&v2)
    }

    fun parse_data_sources(arg0: vector<u64>, arg1: vector<vector<u8>>) : vector<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::data_source::DataSource> {
        assert!(0x1::vector::length<u64>(&arg0) == 0x1::vector::length<vector<u8>>(&arg1), 0);
        let v0 = 0x1::vector::empty<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::data_source::DataSource>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            0x1::vector::push_back<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::data_source::DataSource>(&mut v0, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::data_source::new(*0x1::vector::borrow<u64>(&arg0, v1), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::from_bytes(*0x1::vector::borrow<vector<u8>>(&arg1, v1)))));
            v1 = v1 + 1;
        };
        v0
    }

    public fun price_feed_exists(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg1: 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_identifier::PriceIdentifier) : bool {
        0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::price_feed_object_exists(arg0, arg1)
    }

    public(friend) fun update_cache(arg0: 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::LatestOnly, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfo, arg2: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) {
        assert!(has_same_price_identifier(arg1, arg2), 4);
        if (is_fresh_update(arg1, arg2)) {
            0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::event::emit_price_feed_update(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_feed::from(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::get_price_feed(arg1)), 0x2::clock::timestamp_ms(arg3) / 1000);
            0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::update_price_info_object(arg2, arg1);
        };
    }

    public fun update_single_price_feed(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg1: 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::hot_potato_vector::HotPotatoVector<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfo>, arg2: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock) : 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::hot_potato_vector::HotPotatoVector<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfo> {
        assert!(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::get_base_update_fee(arg0) <= 5 * 0x2::coin::value<0x2::sui::SUI>(&arg3), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::get_fee_recipient(arg0));
        let v0 = 0;
        let v1 = false;
        while (v0 < 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::hot_potato_vector::length<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfo>(&arg1)) {
            let v2 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::hot_potato_vector::borrow<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfo>(&arg1, v0);
            if (has_same_price_identifier(v2, arg2)) {
                v1 = true;
                update_cache(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::assert_latest_only(arg0), v2, arg2, arg4);
                break
            };
            v0 = v0 + 1;
        };
        if (v1 == false) {
            abort 5
        };
        arg1
    }

    // decompiled from Move bytecode v6
}

