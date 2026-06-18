module 0xf18fbd6b75e1db6b4b901d4a50bc40c5c9cdd7d59a14e68d580b67efab447d3c::offchain {
    struct RegistrySnapshot has copy, drop {
        registry_id: 0x2::object::ID,
        project_count: u64,
        market_count: u64,
    }

    public fun registry_market_record(arg0: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg1: &0xf18fbd6b75e1db6b4b901d4a50bc40c5c9cdd7d59a14e68d580b67efab447d3c::market_registry::MarketRegistry, arg2: 0x2::object::ID) : 0xf18fbd6b75e1db6b4b901d4a50bc40c5c9cdd7d59a14e68d580b67efab447d3c::market_registry::MarketRecord {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg0);
        0xf18fbd6b75e1db6b4b901d4a50bc40c5c9cdd7d59a14e68d580b67efab447d3c::market_registry::market_record(arg1, arg2)
    }

    public fun registry_project(arg0: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg1: &0xf18fbd6b75e1db6b4b901d4a50bc40c5c9cdd7d59a14e68d580b67efab447d3c::market_registry::MarketRegistry, arg2: u64) : 0xf18fbd6b75e1db6b4b901d4a50bc40c5c9cdd7d59a14e68d580b67efab447d3c::market_registry::Project {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg0);
        0xf18fbd6b75e1db6b4b901d4a50bc40c5c9cdd7d59a14e68d580b67efab447d3c::market_registry::project(arg1, arg2)
    }

    public fun registry_snapshot(arg0: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg1: &0xf18fbd6b75e1db6b4b901d4a50bc40c5c9cdd7d59a14e68d580b67efab447d3c::market_registry::MarketRegistry) : RegistrySnapshot {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg0);
        RegistrySnapshot{
            registry_id   : 0xf18fbd6b75e1db6b4b901d4a50bc40c5c9cdd7d59a14e68d580b67efab447d3c::market_registry::id(arg1),
            project_count : 0xf18fbd6b75e1db6b4b901d4a50bc40c5c9cdd7d59a14e68d580b67efab447d3c::market_registry::project_count(arg1),
            market_count  : 0xf18fbd6b75e1db6b4b901d4a50bc40c5c9cdd7d59a14e68d580b67efab447d3c::market_registry::market_count(arg1),
        }
    }

    // decompiled from Move bytecode v7
}

