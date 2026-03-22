module 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_app {
    struct LEVERAGE_APP has drop {
        dummy_field: bool,
    }

    struct LeverageMarketUniqueKey has copy, drop, store {
        lending_market: 0x2::object::ID,
        emode_group: u8,
    }

    struct LeverageApp has store, key {
        id: 0x2::object::UID,
        version: u64,
        markets: 0x2::table::Table<LeverageMarketUniqueKey, bool>,
        protocol_caller_cap: vector<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::PackageCallerCap>,
    }

    public(friend) fun accept_protocol_caller_cap(arg0: &mut LeverageApp, arg1: 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::PackageCallerCap) {
        assert!(0x1::vector::length<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::PackageCallerCap>(&arg0.protocol_caller_cap) == 0, 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_error::already_assigned_caller_cap());
        0x1::vector::push_back<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::PackageCallerCap>(&mut arg0.protocol_caller_cap, arg1);
    }

    public(friend) fun add_market(arg0: &mut LeverageApp, arg1: 0x2::object::ID, arg2: u8) {
        let v0 = LeverageMarketUniqueKey{
            lending_market : arg1,
            emode_group    : arg2,
        };
        assert!(!0x2::table::contains<LeverageMarketUniqueKey, bool>(&arg0.markets, v0), 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_error::market_already_exists());
        0x2::table::add<LeverageMarketUniqueKey, bool>(&mut arg0.markets, v0, true);
    }

    public(friend) fun borrow_protocol_caller_cap(arg0: &LeverageApp) : &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::PackageCallerCap {
        assert!(0x1::vector::length<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::PackageCallerCap>(&arg0.protocol_caller_cap) == 1, 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_error::no_caller_cap());
        0x1::vector::borrow<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::PackageCallerCap>(&arg0.protocol_caller_cap, 0)
    }

    fun create(arg0: &mut 0x2::tx_context::TxContext) : LeverageApp {
        LeverageApp{
            id                  : 0x2::object::new(arg0),
            version             : 0,
            markets             : 0x2::table::new<LeverageMarketUniqueKey, bool>(arg0),
            protocol_caller_cap : 0x1::vector::empty<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::PackageCallerCap>(),
        }
    }

    public fun current_version() : u64 {
        0
    }

    public(friend) fun ensure_version_matches(arg0: &LeverageApp) {
        assert!(arg0.version == 0, 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_error::version_mismatch());
    }

    fun init(arg0: LEVERAGE_APP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<LEVERAGE_APP>(arg0, arg1);
        0x2::transfer::public_share_object<LeverageApp>(create(arg1));
    }

    public(friend) fun migrate(arg0: &mut LeverageApp) : u64 {
        assert!(arg0.version < 0, 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_error::version_mismatch());
        arg0.version = 0;
        0
    }

    public(friend) fun revoke_protocol_caller_cap(arg0: &mut LeverageApp, arg1: &mut 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp) {
        assert!(0x1::vector::length<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::PackageCallerCap>(&arg0.protocol_caller_cap) == 1, 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_error::no_caller_cap());
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::whitelist_admin::burn_whitelist(arg1, 0x1::vector::pop_back<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::PackageCallerCap>(&mut arg0.protocol_caller_cap));
    }

    // decompiled from Move bytecode v6
}

