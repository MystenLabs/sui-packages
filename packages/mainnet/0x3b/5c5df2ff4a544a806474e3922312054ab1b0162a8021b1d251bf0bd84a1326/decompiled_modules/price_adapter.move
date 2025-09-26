module 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::price_adapter {
    struct AssertVersion has drop {
        dummy_field: bool,
    }

    struct PriceAdapter has key {
        id: 0x2::object::UID,
        prices: 0x2::table::Table<vector<u8>, 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::price_data::PriceData>,
        config: 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_config::Config,
        version: u8,
    }

    struct PriceWrite has copy, drop {
        feed_id: 0x1::string::String,
        value: u256,
        timestamp: u64,
        write_timestamp: u64,
    }

    struct UpdateError has copy, drop {
        feed_id: vector<u8>,
        error: 0x1::string::String,
    }

    public(friend) fun new(arg0: &0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::admin::AdminCap, arg1: vector<vector<u8>>, arg2: u8, arg3: u64, arg4: u64, arg5: vector<address>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceAdapter{
            id      : 0x2::object::new(arg7),
            prices  : 0x2::table::new<vector<u8>, 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::price_data::PriceData>(arg7),
            config  : 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_config::new(arg2, arg1, arg3, arg4, arg5, arg6),
            version : 2,
        };
        0x2::transfer::share_object<PriceAdapter>(v0);
    }

    fun assert_version(arg0: &PriceAdapter) : AssertVersion {
        assert!(arg0.version == 2, 0);
        AssertVersion{dummy_field: false}
    }

    fun get_or_create_default(arg0: AssertVersion, arg1: &mut PriceAdapter, arg2: vector<u8>) : &mut 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::price_data::PriceData {
        if (!0x2::table::contains<vector<u8>, 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::price_data::PriceData>(&arg1.prices, arg2)) {
            0x2::table::add<vector<u8>, 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::price_data::PriceData>(&mut arg1.prices, arg2, 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::price_data::default(arg2));
        };
        0x2::table::borrow_mut<vector<u8>, 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::price_data::PriceData>(&mut arg1.prices, arg2)
    }

    public fun price_data(arg0: &PriceAdapter, arg1: vector<u8>) : &0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::price_data::PriceData {
        if (!0x2::table::contains<vector<u8>, 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::price_data::PriceData>(&arg0.prices, arg1)) {
            abort 1
        };
        0x2::table::borrow<vector<u8>, 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::price_data::PriceData>(&arg0.prices, arg1)
    }

    fun get_price_feed_write_timestamp(arg0: &PriceAdapter, arg1: vector<u8>) : 0x1::option::Option<u64> {
        if (!0x2::table::contains<vector<u8>, 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::price_data::PriceData>(&arg0.prices, arg1)) {
            return 0x1::option::none<u64>()
        };
        0x1::option::some<u64>(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::price_data::write_timestamp(0x2::table::borrow<vector<u8>, 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::price_data::PriceData>(&arg0.prices, arg1)))
    }

    public fun migrate_to_version_2(arg0: &0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::admin::AdminCap, arg1: &mut PriceAdapter) {
        assert!(arg1.version == 1, 3);
        assert!(2 == 2, 4);
        set_version(arg1, arg0, 2);
    }

    fun overwrite_price(arg0: AssertVersion, arg1: &mut PriceAdapter, arg2: vector<u8>, arg3: u256, arg4: u64, arg5: u64) : 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::Result<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit> {
        let v0 = get_or_create_default(arg0, arg1, arg2);
        if (arg4 <= 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::price_data::timestamp(v0)) {
            return 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::error<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>(b"Timestamp too old")
        };
        0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::price_data::update(v0, arg2, arg3, arg4, arg5);
        let v1 = PriceWrite{
            feed_id         : 0x1::string::utf8(arg2),
            value           : arg3,
            timestamp       : arg4,
            write_timestamp : arg5,
        };
        0x2::event::emit<PriceWrite>(v1);
        0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::ok<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::unit())
    }

    public fun price(arg0: &PriceAdapter, arg1: vector<u8>) : u256 {
        0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::price_data::price(price_data(arg0, arg1))
    }

    public fun price_and_timestamp(arg0: &PriceAdapter, arg1: vector<u8>) : (u256, u64) {
        0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::price_data::price_and_timestamp(price_data(arg0, arg1))
    }

    public(friend) fun set_version(arg0: &mut PriceAdapter, arg1: &0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::admin::AdminCap, arg2: u8) {
        arg0.version = arg2;
    }

    public fun timestamp(arg0: &PriceAdapter, arg1: vector<u8>) : u64 {
        0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::price_data::timestamp(price_data(arg0, arg1))
    }

    public fun try_write_price(arg0: &mut PriceAdapter, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::Result<u256> {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = assert_version(arg0);
        let v2 = get_price_feed_write_timestamp(arg0, arg1);
        let v3 = if (0x1::option::is_some<u64>(&v2)) {
            0x1::option::some<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::Result<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>>(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_update_check::is_update_time_sound(&arg0.config, 0x1::option::destroy_some<u64>(v2), v0, 0x2::tx_context::sender(arg4)))
        } else {
            0x1::option::destroy_none<u64>(v2);
            0x1::option::none<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::Result<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>>()
        };
        let v4 = v3;
        let v5 = if (0x1::option::is_some<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::Result<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>>(&v4)) {
            0x1::option::destroy_some<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::Result<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>>(v4)
        } else {
            0x1::option::destroy_none<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::Result<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>>(v4);
            0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::ok<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::unit())
        };
        let v6 = v5;
        let v7 = if (0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::is_ok<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>(&v6)) {
            0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::unwrap<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>(v6);
            write_price_checked(v1, arg0, arg1, arg2, v0)
        } else {
            0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::error<u256>(0x1::string::into_bytes(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::unwrap_err<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>(v6)))
        };
        let v8 = v7;
        if (!0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::is_ok<u256>(&v8)) {
            let v9 = UpdateError{
                feed_id : arg1,
                error   : *0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::borrow_err<u256>(&v8),
            };
            0x2::event::emit<UpdateError>(v9);
        };
        v8
    }

    public fun update_config(arg0: &0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::admin::AdminCap, arg1: &mut PriceAdapter, arg2: 0x1::option::Option<vector<vector<u8>>>, arg3: 0x1::option::Option<u8>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<vector<address>>, arg7: 0x1::option::Option<u64>) {
        let v0 = assert_version(arg1);
        update_config_checked(v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun update_config_checked(arg0: AssertVersion, arg1: &0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::admin::AdminCap, arg2: &mut PriceAdapter, arg3: 0x1::option::Option<vector<vector<u8>>>, arg4: 0x1::option::Option<u8>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<vector<address>>, arg8: 0x1::option::Option<u64>) {
        let v0 = if (0x1::option::is_some<vector<vector<u8>>>(&arg3)) {
            0x1::option::extract<vector<vector<u8>>>(&mut arg3)
        } else {
            0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_config::signers(&arg2.config)
        };
        let v1 = if (0x1::option::is_some<u8>(&arg4)) {
            0x1::option::extract<u8>(&mut arg4)
        } else {
            0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_config::signer_count_threshold(&arg2.config)
        };
        let v2 = if (0x1::option::is_some<u64>(&arg5)) {
            0x1::option::extract<u64>(&mut arg5)
        } else {
            0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_config::max_timestamp_delay_ms(&arg2.config)
        };
        let v3 = if (0x1::option::is_some<u64>(&arg6)) {
            0x1::option::extract<u64>(&mut arg6)
        } else {
            0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_config::max_timestamp_ahead_ms(&arg2.config)
        };
        let v4 = if (0x1::option::is_some<vector<address>>(&arg7)) {
            0x1::option::extract<vector<address>>(&mut arg7)
        } else {
            0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_config::trusted_updaters(&arg2.config)
        };
        let v5 = if (0x1::option::is_some<u64>(&arg8)) {
            0x1::option::extract<u64>(&mut arg8)
        } else {
            0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_config::min_interval_between_updates_ms(&arg2.config)
        };
        0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_config::update_config(&mut arg2.config, arg1, v0, v1, v2, v3, v4, v5);
    }

    public fun write_price(arg0: &mut PriceAdapter, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : u256 {
        0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::unwrap_or<u256>(try_write_price(arg0, arg1, arg2, arg3, arg4), 0)
    }

    fun write_price_checked(arg0: AssertVersion, arg1: &mut PriceAdapter, arg2: vector<u8>, arg3: vector<u8>, arg4: u64) : 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::Result<u256> {
        let v0 = 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_payload::try_process_payload(&arg1.config, arg4, arg2, arg3);
        if (0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::is_ok<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_payload::ParsedPayload>(&v0)) {
            let (v2, v3) = 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_payload::destroy_processed_payload(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::unwrap<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_payload::ParsedPayload>(v0));
            let v4 = overwrite_price(arg0, arg1, arg2, v2, v3, arg4);
            if (0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::is_ok<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>(&v4)) {
                0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::unwrap<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>(v4);
                0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::ok<u256>(v2)
            } else {
                0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::error<u256>(0x1::string::into_bytes(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::unwrap_err<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::unit::Unit>(v4)))
            }
        } else {
            0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::error<u256>(0x1::string::into_bytes(0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result::unwrap_err<0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::redstone_sdk_payload::ParsedPayload>(v0)))
        }
    }

    // decompiled from Move bytecode v6
}

