module 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::global_config {
    struct GlobalConfig has key {
        id: 0x2::object::UID,
        allowed_versions: 0x2::vec_set::VecSet<u16>,
        keepers: 0x2::vec_set::VecSet<address>,
        risk_managers: 0x2::vec_set::VecSet<address>,
        fee_address: address,
        protocol_fee_share_bps: u64,
        insurance_address: address,
        liquidator_fee_bps: u64,
        insurance_fee_bps: u64,
        max_orders_per_price: u64,
        oi_cap_bps: u64,
        price_refresh_threshold_ms: u64,
    }

    struct GlobalVault<phantom T0> has store {
        sheet: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T0, 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::witness::WaterXPerp>,
        balance: 0x2::balance::Balance<T0>,
    }

    public fun add_keeper(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg1.keepers, arg2);
    }

    public fun add_risk_manager(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg1.risk_managers, arg2);
    }

    public fun allow_version(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut GlobalConfig, arg2: u16) {
        if (!0x2::vec_set::contains<u16>(&arg1.allowed_versions, &arg2)) {
            0x2::vec_set::insert<u16>(&mut arg1.allowed_versions, arg2);
        };
    }

    public fun allowed_versions(arg0: &GlobalConfig) : vector<u16> {
        *0x2::vec_set::keys<u16>(&arg0.allowed_versions)
    }

    public fun assert_version(arg0: &GlobalConfig) {
        let v0 = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::version::package_version();
        if (!0x2::vec_set::contains<u16>(&arg0.allowed_versions, &v0)) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_invalid_version();
        };
    }

    public(friend) fun balance_mut<T0>(arg0: &mut GlobalConfig) : &mut 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, GlobalVault<T0>>(&arg0.id, v0)) {
            let v1 = GlobalVault<T0>{
                sheet   : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::new<T0, 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::witness::WaterXPerp>(0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::witness::witness()),
                balance : 0x2::balance::zero<T0>(),
            };
            0x2::dynamic_field::add<0x1::type_name::TypeName, GlobalVault<T0>>(&mut arg0.id, v0, v1);
        };
        &mut 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, GlobalVault<T0>>(&mut arg0.id, v0).balance
    }

    public fun disallow_version(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut GlobalConfig, arg2: u16) {
        if (0x2::vec_set::contains<u16>(&arg1.allowed_versions, &arg2)) {
            0x2::vec_set::remove<u16>(&mut arg1.allowed_versions, &arg2);
        };
    }

    public fun fee_address(arg0: &GlobalConfig) : address {
        arg0.fee_address
    }

    public(friend) fun global_config_uid(arg0: &GlobalConfig) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun global_config_uid_mut(arg0: &mut GlobalConfig) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id                         : 0x2::object::new(arg0),
            allowed_versions           : 0x2::vec_set::singleton<u16>(0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::version::package_version()),
            keepers                    : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg0)),
            risk_managers              : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg0)),
            fee_address                : 0x2::tx_context::sender(arg0),
            protocol_fee_share_bps     : 3000,
            insurance_address          : 0x2::tx_context::sender(arg0),
            liquidator_fee_bps         : 0,
            insurance_fee_bps          : 100,
            max_orders_per_price       : 100,
            oi_cap_bps                 : 0,
            price_refresh_threshold_ms : 0,
        };
        0x2::transfer::share_object<GlobalConfig>(v0);
    }

    public fun insurance_address(arg0: &GlobalConfig) : address {
        arg0.insurance_address
    }

    public fun insurance_fee_bps(arg0: &GlobalConfig) : u64 {
        arg0.insurance_fee_bps
    }

    public(friend) fun is_keeper(arg0: &GlobalConfig, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.keepers, &arg1)
    }

    public fun keeper_addresses(arg0: &GlobalConfig) : vector<address> {
        *0x2::vec_set::keys<address>(&arg0.keepers)
    }

    public fun keeper_count(arg0: &GlobalConfig) : u64 {
        0x2::vec_set::length<address>(&arg0.keepers)
    }

    public fun liquidator_fee_bps(arg0: &GlobalConfig) : u64 {
        arg0.liquidator_fee_bps
    }

    public fun max_orders_per_price(arg0: &GlobalConfig) : u64 {
        arg0.max_orders_per_price
    }

    public fun oi_cap_bps(arg0: &GlobalConfig) : u64 {
        arg0.oi_cap_bps
    }

    public fun price_refresh_threshold_ms(arg0: &GlobalConfig) : u64 {
        arg0.price_refresh_threshold_ms
    }

    public fun protocol_fee_share_bps(arg0: &GlobalConfig) : u64 {
        arg0.protocol_fee_share_bps
    }

    public fun remove_keeper(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg1.keepers, &arg2);
    }

    public fun remove_risk_manager(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg1.risk_managers, &arg2);
    }

    public fun risk_manager_addresses(arg0: &GlobalConfig) : vector<address> {
        *0x2::vec_set::keys<address>(&arg0.risk_managers)
    }

    public fun set_fee_address(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        arg1.fee_address = arg2;
    }

    public fun set_insurance_address(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        arg1.insurance_address = arg2;
    }

    public fun set_insurance_fee_bps(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.insurance_fee_bps = arg2;
    }

    public fun set_liquidator_fee_bps(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.liquidator_fee_bps = arg2;
    }

    public fun set_max_orders_per_price(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.max_orders_per_price = arg2;
    }

    public fun set_oi_cap_bps(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.oi_cap_bps = arg2;
    }

    public fun set_price_refresh_threshold_ms(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.price_refresh_threshold_ms = arg2;
    }

    public fun set_protocol_fee_share(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        if (arg2 > 10000) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_invalid_config();
        };
        arg1.protocol_fee_share_bps = arg2;
    }

    public(friend) fun vault_balance<T0>(arg0: &GlobalConfig) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, GlobalVault<T0>>(&arg0.id, v0)) {
            0
        } else {
            0x2::balance::value<T0>(&0x2::dynamic_field::borrow<0x1::type_name::TypeName, GlobalVault<T0>>(&arg0.id, v0).balance)
        }
    }

    public(friend) fun verify_keeper(arg0: &GlobalConfig, arg1: address) {
        assert_version(arg0);
        if (!0x2::vec_set::contains<address>(&arg0.keepers, &arg1)) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_unauthorized();
        };
    }

    public(friend) fun verify_risk_manager(arg0: &GlobalConfig, arg1: address) {
        assert_version(arg0);
        if (!0x2::vec_set::contains<address>(&arg0.risk_managers, &arg1)) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_unauthorized();
        };
    }

    // decompiled from Move bytecode v7
}

