module 0xeef943421fb0efe05ddc69d5e657256022bb18e8b56c03735e00d3141b7d20b::offchain {
    struct RegistrySnapshot has copy, drop {
        registry_id: 0x2::object::ID,
        project_count: u64,
        market_count: u64,
    }

    public fun registry_market_record(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: &0xeef943421fb0efe05ddc69d5e657256022bb18e8b56c03735e00d3141b7d20b::market_registry::MarketRegistry, arg2: 0x2::object::ID) : 0xeef943421fb0efe05ddc69d5e657256022bb18e8b56c03735e00d3141b7d20b::market_registry::MarketRecord {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        0xeef943421fb0efe05ddc69d5e657256022bb18e8b56c03735e00d3141b7d20b::market_registry::market_record(arg1, arg2)
    }

    public fun registry_project(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: &0xeef943421fb0efe05ddc69d5e657256022bb18e8b56c03735e00d3141b7d20b::market_registry::MarketRegistry, arg2: u64) : 0xeef943421fb0efe05ddc69d5e657256022bb18e8b56c03735e00d3141b7d20b::market_registry::Project {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        0xeef943421fb0efe05ddc69d5e657256022bb18e8b56c03735e00d3141b7d20b::market_registry::project(arg1, arg2)
    }

    public fun registry_snapshot(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: &0xeef943421fb0efe05ddc69d5e657256022bb18e8b56c03735e00d3141b7d20b::market_registry::MarketRegistry) : RegistrySnapshot {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        RegistrySnapshot{
            registry_id   : 0xeef943421fb0efe05ddc69d5e657256022bb18e8b56c03735e00d3141b7d20b::market_registry::id(arg1),
            project_count : 0xeef943421fb0efe05ddc69d5e657256022bb18e8b56c03735e00d3141b7d20b::market_registry::project_count(arg1),
            market_count  : 0xeef943421fb0efe05ddc69d5e657256022bb18e8b56c03735e00d3141b7d20b::market_registry::market_count(arg1),
        }
    }

    // decompiled from Move bytecode v7
}

