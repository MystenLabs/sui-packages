module 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_app {
    struct LEVERAGE_APP has drop {
        dummy_field: bool,
    }

    struct LeverageApp has store, key {
        id: 0x2::object::UID,
        version: u64,
        markets: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        protocol_caller_cap: vector<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::app::PackageCallerCap>,
    }

    public(friend) fun accept_protocol_caller_cap(arg0: &mut LeverageApp, arg1: 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::app::PackageCallerCap) {
        assert!(0x1::vector::length<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::app::PackageCallerCap>(&arg0.protocol_caller_cap) == 0, 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_error::already_assigned_caller_cap());
        0x1::vector::push_back<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::app::PackageCallerCap>(&mut arg0.protocol_caller_cap, arg1);
    }

    public(friend) fun add_market_id(arg0: &mut LeverageApp, arg1: 0x2::object::ID) {
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.markets, arg1), 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_error::market_already_exists());
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.markets, arg1, arg1);
    }

    public(friend) fun borrow_protocol_caller_cap(arg0: &LeverageApp) : &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::app::PackageCallerCap {
        assert!(0x1::vector::length<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::app::PackageCallerCap>(&arg0.protocol_caller_cap) == 1, 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_error::no_caller_cap());
        0x1::vector::borrow<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::app::PackageCallerCap>(&arg0.protocol_caller_cap, 0)
    }

    fun create(arg0: &mut 0x2::tx_context::TxContext) : LeverageApp {
        LeverageApp{
            id                  : 0x2::object::new(arg0),
            version             : current_version(),
            markets             : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg0),
            protocol_caller_cap : 0x1::vector::empty<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::app::PackageCallerCap>(),
        }
    }

    public(friend) fun current_version() : u64 {
        1
    }

    public(friend) fun ensure_version_matches(arg0: &LeverageApp) {
        assert!(arg0.version == current_version(), 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_error::version_mismatch());
    }

    public(friend) fun get_version(arg0: &LeverageApp) : u64 {
        arg0.version
    }

    fun init(arg0: LEVERAGE_APP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<LEVERAGE_APP>(arg0, arg1);
        0x2::transfer::public_share_object<LeverageApp>(create(arg1));
    }

    public(friend) fun is_market(arg0: &LeverageApp, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.markets, arg1)
    }

    public(friend) fun revoke_protocol_caller_cap(arg0: &mut LeverageApp, arg1: &mut 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::app::ProtocolApp) {
        assert!(0x1::vector::length<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::app::PackageCallerCap>(&arg0.protocol_caller_cap) == 1, 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_error::no_caller_cap());
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::whitelist_admin::burn_whitelist(arg1, 0x1::vector::pop_back<0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::app::PackageCallerCap>(&mut arg0.protocol_caller_cap));
    }

    public(friend) fun validate_market(arg0: &LeverageApp, arg1: 0x2::object::ID) {
        assert!(0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.markets, arg1), 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_error::market_not_found());
    }

    // decompiled from Move bytecode v6
}

