module 0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_app {
    struct LEVERAGE_APP has drop {
        dummy_field: bool,
    }

    struct LeverageApp has store, key {
        id: 0x2::object::UID,
        version: u64,
        markets: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        protocol_caller_cap: vector<0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::PackageCallerCap>,
    }

    public(friend) fun accept_protocol_caller_cap(arg0: &mut LeverageApp, arg1: 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::PackageCallerCap) {
        assert!(0x1::vector::length<0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::PackageCallerCap>(&arg0.protocol_caller_cap) == 0, 0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_error::already_assigned_caller_cap());
        0x1::vector::push_back<0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::PackageCallerCap>(&mut arg0.protocol_caller_cap, arg1);
    }

    public(friend) fun add_market_id(arg0: &mut LeverageApp, arg1: 0x2::object::ID) {
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.markets, arg1), 0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_error::market_already_exists());
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.markets, arg1, arg1);
    }

    public(friend) fun borrow_protocol_caller_cap(arg0: &LeverageApp) : &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::PackageCallerCap {
        assert!(0x1::vector::length<0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::PackageCallerCap>(&arg0.protocol_caller_cap) == 1, 0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_error::no_caller_cap());
        0x1::vector::borrow<0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::PackageCallerCap>(&arg0.protocol_caller_cap, 0)
    }

    fun create(arg0: &mut 0x2::tx_context::TxContext) : LeverageApp {
        LeverageApp{
            id                  : 0x2::object::new(arg0),
            version             : 2,
            markets             : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg0),
            protocol_caller_cap : 0x1::vector::empty<0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::PackageCallerCap>(),
        }
    }

    public fun current_version() : u64 {
        2
    }

    public(friend) fun ensure_version_matches(arg0: &LeverageApp) {
        assert!(arg0.version == 2, 0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_error::version_mismatch());
    }

    fun init(arg0: LEVERAGE_APP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<LEVERAGE_APP>(arg0, arg1);
        0x2::transfer::public_share_object<LeverageApp>(create(arg1));
    }

    public(friend) fun migrate(arg0: &mut LeverageApp) : u64 {
        assert!(arg0.version < 2, 0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_error::version_mismatch());
        arg0.version = 2;
        2
    }

    public(friend) fun revoke_protocol_caller_cap(arg0: &mut LeverageApp, arg1: &mut 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::ProtocolApp) {
        assert!(0x1::vector::length<0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::PackageCallerCap>(&arg0.protocol_caller_cap) == 1, 0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_error::no_caller_cap());
        0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::whitelist_admin::burn_whitelist(arg1, 0x1::vector::pop_back<0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::PackageCallerCap>(&mut arg0.protocol_caller_cap));
    }

    // decompiled from Move bytecode v6
}

