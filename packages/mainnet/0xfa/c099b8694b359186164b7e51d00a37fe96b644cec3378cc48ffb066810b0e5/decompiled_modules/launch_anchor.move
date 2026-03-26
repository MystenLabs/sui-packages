module 0xfac099b8694b359186164b7e51d00a37fe96b644cec3378cc48ffb066810b0e5::launch_anchor {
    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    struct LaunchAnchor has key {
        id: 0x2::object::UID,
        token_type: 0x1::type_name::TypeName,
        token_name: 0x1::string::String,
        token_symbol: 0x1::string::String,
        total_supply: u64,
        token_decimals: u8,
        peg_mist: u64,
        price_per_token_mist: u64,
        sqrt_price_x64: 0x1::string::String,
        tick_index: u64,
        tick_lower: u64,
        tick_upper: u64,
        pool_id: 0x2::object::ID,
        creator: address,
        launched_at_ms: u64,
        protocol_version: u8,
    }

    struct AnchorMinted has copy, drop {
        anchor_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
        token_name: 0x1::string::String,
        token_symbol: 0x1::string::String,
        peg_sui: u64,
        creator: address,
        launched_at_ms: u64,
        pool_id: 0x2::object::ID,
    }

    public fun anchor_id(arg0: &LaunchAnchor) : 0x2::object::ID {
        0x2::object::id<LaunchAnchor>(arg0)
    }

    public fun creator(arg0: &LaunchAnchor) : address {
        arg0.creator
    }

    public fun freeze_anchor(arg0: LaunchAnchor) {
        0x2::transfer::freeze_object<LaunchAnchor>(arg0);
    }

    public fun implied_mcap_sui(arg0: &LaunchAnchor) : u64 {
        arg0.peg_mist / 1000000000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MintCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MintCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun launched_at_ms(arg0: &LaunchAnchor) : u64 {
        arg0.launched_at_ms
    }

    public fun mint(arg0: &MintCap, arg1: 0x1::type_name::TypeName, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u8, arg6: u64, arg7: 0x1::string::String, arg8: u64, arg9: u64, arg10: 0x2::object::ID, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : LaunchAnchor {
        assert!(arg6 > 0, 1);
        assert!(arg4 > 0, 2);
        assert!(!0x1::string::is_empty(&arg2), 3);
        assert!(!0x1::string::is_empty(&arg3), 4);
        assert!(!0x1::string::is_empty(&arg7), 5);
        let v0 = if (arg4 > 0) {
            arg6 / arg4
        } else {
            0
        };
        let v1 = 0x2::clock::timestamp_ms(arg11);
        let v2 = 0x2::tx_context::sender(arg12);
        let v3 = LaunchAnchor{
            id                   : 0x2::object::new(arg12),
            token_type           : arg1,
            token_name           : arg2,
            token_symbol         : arg3,
            total_supply         : arg4,
            token_decimals       : arg5,
            peg_mist             : arg6,
            price_per_token_mist : v0,
            sqrt_price_x64       : arg7,
            tick_index           : arg8,
            tick_lower           : arg9,
            tick_upper           : 443636,
            pool_id              : arg10,
            creator              : v2,
            launched_at_ms       : v1,
            protocol_version     : 1,
        };
        let v4 = AnchorMinted{
            anchor_id      : 0x2::object::id<LaunchAnchor>(&v3),
            token_type     : arg1,
            token_name     : arg2,
            token_symbol   : arg3,
            peg_sui        : arg6 / 1000000000,
            creator        : v2,
            launched_at_ms : v1,
            pool_id        : arg10,
        };
        0x2::event::emit<AnchorMinted>(v4);
        v3
    }

    public fun peg_mist(arg0: &LaunchAnchor) : u64 {
        arg0.peg_mist
    }

    public fun peg_sui(arg0: &LaunchAnchor) : u64 {
        arg0.peg_mist / 1000000000
    }

    public fun pool_id(arg0: &LaunchAnchor) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun price_per_token_mist(arg0: &LaunchAnchor) : u64 {
        arg0.price_per_token_mist
    }

    public fun protocol_version(arg0: &LaunchAnchor) : u8 {
        arg0.protocol_version
    }

    public fun sqrt_price_x64(arg0: &LaunchAnchor) : &0x1::string::String {
        &arg0.sqrt_price_x64
    }

    public fun tick_index(arg0: &LaunchAnchor) : u64 {
        arg0.tick_index
    }

    public fun tick_lower(arg0: &LaunchAnchor) : u64 {
        arg0.tick_lower
    }

    public fun tick_upper(arg0: &LaunchAnchor) : u64 {
        arg0.tick_upper
    }

    public fun token_decimals(arg0: &LaunchAnchor) : u8 {
        arg0.token_decimals
    }

    public fun token_name(arg0: &LaunchAnchor) : &0x1::string::String {
        &arg0.token_name
    }

    public fun token_symbol(arg0: &LaunchAnchor) : &0x1::string::String {
        &arg0.token_symbol
    }

    public fun token_type(arg0: &LaunchAnchor) : 0x1::type_name::TypeName {
        arg0.token_type
    }

    public fun total_supply(arg0: &LaunchAnchor) : u64 {
        arg0.total_supply
    }

    // decompiled from Move bytecode v6
}

