module 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch {
    struct VaultLaunch has key {
        id: 0x2::object::UID,
        creator: address,
        status: u8,
        base_coin_type: 0x1::string::String,
        quote_coin_type: 0x1::string::String,
        goal_amount: u64,
        total_deposited: u64,
        total_supply: u64,
        depositor_alloc: u64,
        liquidity_alloc: u64,
        platform_fee_collected: u64,
        creator_fee_collected: u64,
        depositor_count: u64,
        pool_id: 0x1::option::Option<0x2::object::ID>,
        converted_at: 0x1::option::Option<u64>,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        website: 0x1::string::String,
        twitter: 0x1::string::String,
    }

    struct LaunchCap has store, key {
        id: 0x2::object::UID,
        launch_id: 0x2::object::ID,
    }

    public fun id(arg0: &VaultLaunch) : 0x2::object::ID {
        0x2::object::id<VaultLaunch>(arg0)
    }

    public fun total_supply(arg0: &VaultLaunch) : u64 {
        arg0.total_supply
    }

    public fun add_deposit(arg0: &mut VaultLaunch, arg1: u64) {
        assert!(arg0.status == 0, 0);
        arg0.total_deposited = arg0.total_deposited + arg1;
        arg0.depositor_count = arg0.depositor_count + 1;
    }

    public fun cap_launch_id(arg0: &LaunchCap) : 0x2::object::ID {
        arg0.launch_id
    }

    public fun converted_at(arg0: &VaultLaunch) : 0x1::option::Option<u64> {
        arg0.converted_at
    }

    public entry fun create_launch(arg0: &mut 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::config::GlobalConfig, arg1: &0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::config::LaunchCreatorCap, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg12);
        let v1 = 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::config::total_supply();
        let v2 = v1 * 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::config::depositor_alloc_bps() / 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::config::bps_denominator();
        let v3 = VaultLaunch{
            id                     : 0x2::object::new(arg12),
            creator                : v0,
            status                 : 0,
            base_coin_type         : arg3,
            quote_coin_type        : arg4,
            goal_amount            : arg2,
            total_deposited        : 0,
            total_supply           : v1,
            depositor_alloc        : v2,
            liquidity_alloc        : v1 - v2,
            platform_fee_collected : 0,
            creator_fee_collected  : 0,
            depositor_count        : 0,
            pool_id                : 0x1::option::none<0x2::object::ID>(),
            converted_at           : 0x1::option::none<u64>(),
            name                   : arg5,
            symbol                 : arg6,
            description            : arg7,
            image_url              : arg8,
            website                : arg9,
            twitter                : arg10,
        };
        let v4 = 0x2::object::id<VaultLaunch>(&v3);
        let v5 = LaunchCap{
            id        : 0x2::object::new(arg12),
            launch_id : v4,
        };
        0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::events::emit_launch_created(v4, v0, arg2, v3.name, v3.symbol);
        0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::config::increment_launches(arg0);
        0x2::transfer::share_object<VaultLaunch>(v3);
        0x2::transfer::transfer<LaunchCap>(v5, v0);
    }

    public fun creator(arg0: &VaultLaunch) : address {
        arg0.creator
    }

    public fun creator_fee_collected(arg0: &VaultLaunch) : u64 {
        arg0.creator_fee_collected
    }

    public fun depositor_alloc(arg0: &VaultLaunch) : u64 {
        arg0.depositor_alloc
    }

    public fun depositor_count(arg0: &VaultLaunch) : u64 {
        arg0.depositor_count
    }

    public fun goal_amount(arg0: &VaultLaunch) : u64 {
        arg0.goal_amount
    }

    public fun is_funding(arg0: &VaultLaunch) : bool {
        arg0.status == 0
    }

    public fun is_live(arg0: &VaultLaunch) : bool {
        arg0.status == 1
    }

    public fun liquidity_alloc(arg0: &VaultLaunch) : u64 {
        arg0.liquidity_alloc
    }

    public fun name(arg0: &VaultLaunch) : 0x1::string::String {
        arg0.name
    }

    public fun platform_fee_collected(arg0: &VaultLaunch) : u64 {
        arg0.platform_fee_collected
    }

    public fun pool_id(arg0: &VaultLaunch) : 0x1::option::Option<0x2::object::ID> {
        arg0.pool_id
    }

    public fun set_converted(arg0: &mut VaultLaunch, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg0.status == 0, 0);
        arg0.status = 1;
        arg0.platform_fee_collected = arg1;
        arg0.creator_fee_collected = arg2;
        arg0.converted_at = 0x1::option::some<u64>(arg3);
    }

    public fun set_pool_id(arg0: &mut VaultLaunch, arg1: 0x2::object::ID) {
        arg0.pool_id = 0x1::option::some<0x2::object::ID>(arg1);
    }

    public fun status(arg0: &VaultLaunch) : u8 {
        arg0.status
    }

    public fun symbol(arg0: &VaultLaunch) : 0x1::string::String {
        arg0.symbol
    }

    public fun total_deposited(arg0: &VaultLaunch) : u64 {
        arg0.total_deposited
    }

    public fun uid(arg0: &VaultLaunch) : &0x2::object::UID {
        &arg0.id
    }

    public fun uid_mut(arg0: &mut VaultLaunch) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v7
}

