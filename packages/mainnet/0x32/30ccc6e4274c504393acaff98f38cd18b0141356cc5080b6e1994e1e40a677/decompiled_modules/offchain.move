module 0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::offchain {
    struct RegistrySnapshot has copy, drop {
        registry_id: 0x2::object::ID,
        project_count: u64,
        series_count: u64,
        market_count: u64,
        point_program_count: u64,
    }

    public fun registry_market_metadata(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::MarketRegistry, arg2: 0x2::object::ID) : 0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::MarketMetadata {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg0);
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::market_metadata(arg1, arg2)
    }

    public fun registry_market_metadata_exists(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::MarketRegistry, arg2: 0x2::object::ID) : bool {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg0);
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::market_metadata_exists(arg1, arg2)
    }

    public fun registry_market_point_config(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::MarketRegistry, arg2: 0x2::object::ID) : 0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::MarketPointConfig {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg0);
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::market_point_config(arg1, arg2)
    }

    public fun registry_market_point_config_exists(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::MarketRegistry, arg2: 0x2::object::ID) : bool {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg0);
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::market_point_config_exists(arg1, arg2)
    }

    public fun registry_market_point_config_ids(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::MarketRegistry, arg2: 0x2::object::ID) : (u64, 0x2::object::ID, 0x2::object::ID, 0x2::object::ID) {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg0);
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::market_point_config_ids(arg1, arg2)
    }

    public fun registry_market_point_config_params(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::MarketRegistry, arg2: 0x2::object::ID) : (u64, u64, u64) {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg0);
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::market_point_config_params(arg1, arg2)
    }

    public fun registry_market_point_program(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::MarketRegistry, arg2: 0x2::object::ID, arg3: 0x2::object::ID) : 0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::MarketPointProgram {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg0);
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::market_point_program(arg1, arg2, arg3)
    }

    public fun registry_market_point_program_config(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::MarketRegistry, arg2: 0x2::object::ID, arg3: 0x2::object::ID) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID, bool, bool, bool) {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg0);
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::market_point_program_config(arg1, arg2, arg3)
    }

    public fun registry_market_point_program_ids(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::MarketRegistry, arg2: 0x2::object::ID) : vector<0x2::object::ID> {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg0);
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::market_point_program_ids(arg1, arg2)
    }

    public fun registry_market_record(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::MarketRegistry, arg2: 0x2::object::ID) : 0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::MarketRecord {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg0);
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::market_record(arg1, arg2)
    }

    public fun registry_point_program(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::MarketRegistry, arg2: 0x2::object::ID) : 0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::PointProgram {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg0);
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::point_program(arg1, arg2)
    }

    public fun registry_point_program_ids(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::MarketRegistry) : vector<0x2::object::ID> {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg0);
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::point_program_ids(arg1)
    }

    public fun registry_point_program_ids_config(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::MarketRegistry, arg2: 0x2::object::ID) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID, 0x2::object::ID) {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg0);
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::point_program_ids_config(arg1, arg2)
    }

    public fun registry_point_program_market_ids(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::MarketRegistry, arg2: 0x2::object::ID) : vector<0x2::object::ID> {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg0);
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::point_program_market_ids(arg1, arg2)
    }

    public fun registry_point_program_metadata(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::MarketRegistry, arg2: 0x2::object::ID) : (vector<u8>, vector<u8>, vector<u8>, vector<u8>, bool) {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg0);
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::point_program_metadata(arg1, arg2)
    }

    public fun registry_project(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::MarketRegistry, arg2: u64) : 0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::Project {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg0);
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::project(arg1, arg2)
    }

    public fun registry_project_metadata(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::MarketRegistry, arg2: u64) : 0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::ProjectMetadata {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg0);
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::project_metadata(arg1, arg2)
    }

    public fun registry_project_metadata_exists(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::MarketRegistry, arg2: u64) : bool {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg0);
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::project_metadata_exists(arg1, arg2)
    }

    public fun registry_project_point_config(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::MarketRegistry, arg2: u64) : 0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::ProjectPointConfig {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg0);
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::project_point_config(arg1, arg2)
    }

    public fun registry_project_point_config_exists(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::MarketRegistry, arg2: u64) : bool {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg0);
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::project_point_config_exists(arg1, arg2)
    }

    public fun registry_project_point_config_ids(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::MarketRegistry, arg2: u64) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID, 0x2::object::ID, 0x2::object::ID, 0x2::object::ID) {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg0);
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::project_point_config_ids(arg1, arg2)
    }

    public fun registry_project_point_config_metadata(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::MarketRegistry, arg2: u64) : (vector<u8>, vector<u8>, vector<u8>) {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg0);
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::project_point_config_metadata(arg1, arg2)
    }

    public fun registry_project_point_config_params(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::MarketRegistry, arg2: u64) : (bool, u64, u64, u64) {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg0);
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::project_point_config_params(arg1, arg2)
    }

    public fun registry_series(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::MarketRegistry, arg2: u64) : 0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::MarketSeries {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg0);
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::series(arg1, arg2)
    }

    public fun registry_snapshot(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::MarketRegistry) : RegistrySnapshot {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg0);
        RegistrySnapshot{
            registry_id         : 0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::id(arg1),
            project_count       : 0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::project_count(arg1),
            series_count        : 0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::series_count(arg1),
            market_count        : 0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::market_count(arg1),
            point_program_count : 0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry::point_program_count(arg1),
        }
    }

    // decompiled from Move bytecode v7
}

