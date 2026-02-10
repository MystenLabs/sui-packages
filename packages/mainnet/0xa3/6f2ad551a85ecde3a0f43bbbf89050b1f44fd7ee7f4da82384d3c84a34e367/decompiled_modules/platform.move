module 0xa36f2ad551a85ecde3a0f43bbbf89050b1f44fd7ee7f4da82384d3c84a34e367::platform {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Platform has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        fee_rate_bps: u64,
        total_fees_collected: u64,
        total_tips_processed: u64,
        creator_count: u64,
        version: u64,
    }

    struct PlatformInitialized has copy, drop {
        platform_id: 0x2::object::ID,
        name: 0x1::string::String,
        admin: address,
    }

    struct PlatformUpdated has copy, drop {
        platform_id: 0x2::object::ID,
        new_fee_rate_bps: u64,
    }

    public fun calculate_fee(arg0: &Platform, arg1: u64) : u64 {
        arg1 * arg0.fee_rate_bps / 10000
    }

    public fun get_creator_count(arg0: &Platform) : u64 {
        arg0.creator_count
    }

    public fun get_description(arg0: &Platform) : 0x1::string::String {
        arg0.description
    }

    public fun get_fee_rate_bps(arg0: &Platform) : u64 {
        arg0.fee_rate_bps
    }

    public fun get_name(arg0: &Platform) : 0x1::string::String {
        arg0.name
    }

    public fun get_total_fees_collected(arg0: &Platform) : u64 {
        arg0.total_fees_collected
    }

    public fun get_total_tips_processed(arg0: &Platform) : u64 {
        arg0.total_tips_processed
    }

    public fun get_version(arg0: &Platform) : u64 {
        arg0.version
    }

    public(friend) fun increment_creator_count(arg0: &mut Platform) {
        arg0.creator_count = arg0.creator_count + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Platform{
            id                   : 0x2::object::new(arg0),
            name                 : 0x1::string::utf8(b"CreatorVault"),
            description          : 0x1::string::utf8(b"Decentralized Tipping Platform for Creators"),
            fee_rate_bps         : 250,
            total_fees_collected : 0,
            total_tips_processed : 0,
            creator_count        : 0,
            version              : 1,
        };
        let v2 = PlatformInitialized{
            platform_id : 0x2::object::id<Platform>(&v1),
            name        : v1.name,
            admin       : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<PlatformInitialized>(v2);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Platform>(v1);
    }

    public(friend) fun record_tip(arg0: &mut Platform, arg1: u64, arg2: u64) {
        arg0.total_tips_processed = arg0.total_tips_processed + arg1;
        arg0.total_fees_collected = arg0.total_fees_collected + arg2;
    }

    public fun update_fee_rate(arg0: &AdminCap, arg1: &mut Platform, arg2: u64) {
        assert!(arg2 <= 1000, 1);
        arg1.fee_rate_bps = arg2;
        let v0 = PlatformUpdated{
            platform_id      : 0x2::object::id<Platform>(arg1),
            new_fee_rate_bps : arg2,
        };
        0x2::event::emit<PlatformUpdated>(v0);
    }

    public fun update_platform_info(arg0: &AdminCap, arg1: &mut Platform, arg2: vector<u8>, arg3: vector<u8>) {
        arg1.name = 0x1::string::utf8(arg2);
        arg1.description = 0x1::string::utf8(arg3);
    }

    // decompiled from Move bytecode v6
}

