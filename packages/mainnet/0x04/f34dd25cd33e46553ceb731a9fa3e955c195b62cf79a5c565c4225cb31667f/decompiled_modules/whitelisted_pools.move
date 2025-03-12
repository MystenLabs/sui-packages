module 0x4f34dd25cd33e46553ceb731a9fa3e955c195b62cf79a5c565c4225cb31667f::whitelisted_pools {
    struct WhitelistRegistry has key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<0x2::object::ID, bool>,
    }

    public entry fun add_pool_to_whitelist(arg0: &0x4f34dd25cd33e46553ceb731a9fa3e955c195b62cf79a5c565c4225cb31667f::admin::AdminCap, arg1: &mut WhitelistRegistry, arg2: 0x2::object::ID) {
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg1.pools, arg2), 9223372161408827393);
        0x2::table::add<0x2::object::ID, bool>(&mut arg1.pools, arg2, true);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = WhitelistRegistry{
            id    : 0x2::object::new(arg0),
            pools : 0x2::table::new<0x2::object::ID, bool>(arg0),
        };
        0x2::transfer::share_object<WhitelistRegistry>(v0);
    }

    public(friend) fun is_id_whitelisted(arg0: &WhitelistRegistry, arg1: &0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.pools, *arg1)
    }

    public fun is_pool_whitelisted<T0, T1>(arg0: &WhitelistRegistry, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>) : bool {
        let v0 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1);
        is_id_whitelisted(arg0, &v0)
    }

    public entry fun remove_pool_from_whitelist(arg0: &0x4f34dd25cd33e46553ceb731a9fa3e955c195b62cf79a5c565c4225cb31667f::admin::AdminCap, arg1: &mut WhitelistRegistry, arg2: 0x2::object::ID) {
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg1.pools, arg2), 9223372204358631427);
        0x2::table::remove<0x2::object::ID, bool>(&mut arg1.pools, arg2);
    }

    // decompiled from Move bytecode v6
}

