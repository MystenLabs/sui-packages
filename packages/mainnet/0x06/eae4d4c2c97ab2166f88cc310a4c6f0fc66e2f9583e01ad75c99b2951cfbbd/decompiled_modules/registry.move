module 0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry {
    struct REGISTRY has drop {
        dummy_field: bool,
    }

    struct FeeManagerRole has drop {
        dummy_field: bool,
    }

    struct ProtocolManagerRole has drop {
        dummy_field: bool,
    }

    struct ProtocolRegistry has key {
        id: 0x2::object::UID,
        protocols: 0x2::vec_map::VecMap<0x1::string::String, ProtocolEntry>,
    }

    struct ProtocolConfig has key {
        id: 0x2::object::UID,
        deposit_fee_bps: u64,
        org_yield_fee_bps: u64,
        vault_yield_fee_bps: u64,
        treasury: address,
    }

    struct ProtocolEntry has store {
        adapter_package: address,
        yield_type: u8,
        enabled: bool,
    }

    struct ProtocolAdded has copy, drop {
        name: 0x1::string::String,
        adapter_package: address,
        yield_type: u8,
    }

    struct ProtocolDisabled has copy, drop {
        name: 0x1::string::String,
    }

    struct ProtocolEnabled has copy, drop {
        name: 0x1::string::String,
    }

    struct FeesUpdated has copy, drop {
        deposit_fee_bps: u64,
        org_yield_fee_bps: u64,
        vault_yield_fee_bps: u64,
    }

    struct TreasuryUpdated has copy, drop {
        new_treasury: address,
    }

    public fun add_protocol(arg0: &mut ProtocolRegistry, arg1: &0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::access_control::AccessControl<REGISTRY>, arg2: 0x1::string::String, arg3: address, arg4: u8, arg5: &0x2::tx_context::TxContext) {
        0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::access_control::assert_has_role<REGISTRY, ProtocolManagerRole>(arg1, 0x2::tx_context::sender(arg5));
        assert!(!0x2::vec_map::contains<0x1::string::String, ProtocolEntry>(&arg0.protocols, &arg2), 13906834513645797377);
        assert!(arg4 <= 2, 13906834517941026821);
        let v0 = ProtocolEntry{
            adapter_package : arg3,
            yield_type      : arg4,
            enabled         : true,
        };
        0x2::vec_map::insert<0x1::string::String, ProtocolEntry>(&mut arg0.protocols, arg2, v0);
        let v1 = ProtocolAdded{
            name            : arg2,
            adapter_package : arg3,
            yield_type      : arg4,
        };
        0x2::event::emit<ProtocolAdded>(v1);
    }

    public fun deposit_fee_bps(arg0: &ProtocolConfig) : u64 {
        arg0.deposit_fee_bps
    }

    public fun disable_protocol(arg0: &mut ProtocolRegistry, arg1: &0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::access_control::AccessControl<REGISTRY>, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::access_control::assert_has_role<REGISTRY, ProtocolManagerRole>(arg1, 0x2::tx_context::sender(arg3));
        assert!(0x2::vec_map::contains<0x1::string::String, ProtocolEntry>(&arg0.protocols, &arg2), 13906834569480503299);
        0x2::vec_map::get_mut<0x1::string::String, ProtocolEntry>(&mut arg0.protocols, &arg2).enabled = false;
        let v0 = ProtocolDisabled{name: arg2};
        0x2::event::emit<ProtocolDisabled>(v0);
    }

    public fun enable_protocol(arg0: &mut ProtocolRegistry, arg1: &0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::access_control::AccessControl<REGISTRY>, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::access_control::assert_has_role<REGISTRY, ProtocolManagerRole>(arg1, 0x2::tx_context::sender(arg3));
        assert!(0x2::vec_map::contains<0x1::string::String, ProtocolEntry>(&arg0.protocols, &arg2), 13906834621020110851);
        0x2::vec_map::get_mut<0x1::string::String, ProtocolEntry>(&mut arg0.protocols, &arg2).enabled = true;
        let v0 = ProtocolEnabled{name: arg2};
        0x2::event::emit<ProtocolEnabled>(v0);
    }

    fun init(arg0: REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::access_control::new<REGISTRY>(arg0, 0, arg1);
        0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::access_control::grant_role<REGISTRY, FeeManagerRole>(&mut v0, 0x2::tx_context::sender(arg1), arg1);
        0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::access_control::grant_role<REGISTRY, ProtocolManagerRole>(&mut v0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::access_control::AccessControl<REGISTRY>>(v0);
        let v1 = ProtocolRegistry{
            id        : 0x2::object::new(arg1),
            protocols : 0x2::vec_map::empty<0x1::string::String, ProtocolEntry>(),
        };
        0x2::transfer::share_object<ProtocolRegistry>(v1);
        let v2 = ProtocolConfig{
            id                  : 0x2::object::new(arg1),
            deposit_fee_bps     : 0,
            org_yield_fee_bps   : 0,
            vault_yield_fee_bps : 0,
            treasury            : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<ProtocolConfig>(v2);
    }

    public fun is_approved(arg0: &ProtocolRegistry, arg1: &0x1::string::String) : bool {
        0x2::vec_map::contains<0x1::string::String, ProtocolEntry>(&arg0.protocols, arg1) && 0x2::vec_map::get<0x1::string::String, ProtocolEntry>(&arg0.protocols, arg1).enabled
    }

    public fun org_yield_fee_bps(arg0: &ProtocolConfig) : u64 {
        arg0.org_yield_fee_bps
    }

    public fun protocols_by_type(arg0: &ProtocolRegistry, arg1: u8) : vector<0x1::string::String> {
        let v0 = 0x2::vec_map::keys<0x1::string::String, ProtocolEntry>(&arg0.protocols);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &v0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(v2)) {
            let v4 = 0x1::vector::borrow<0x1::string::String>(v2, v3);
            let v5 = 0x2::vec_map::get<0x1::string::String, ProtocolEntry>(&arg0.protocols, v4);
            if (v5.enabled && v5.yield_type == arg1) {
                0x1::vector::push_back<0x1::string::String>(&mut v1, *v4);
            };
            v3 = v3 + 1;
        };
        v1
    }

    public fun set_fees(arg0: &mut ProtocolConfig, arg1: &0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::access_control::AccessControl<REGISTRY>, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::access_control::assert_has_role<REGISTRY, FeeManagerRole>(arg1, 0x2::tx_context::sender(arg5));
        assert!(arg2 <= 500, 13906834681149915143);
        assert!(arg3 <= 5000, 13906834685445013513);
        assert!(arg4 <= 5000, 13906834689740111883);
        arg0.deposit_fee_bps = arg2;
        arg0.org_yield_fee_bps = arg3;
        arg0.vault_yield_fee_bps = arg4;
        let v0 = FeesUpdated{
            deposit_fee_bps     : arg2,
            org_yield_fee_bps   : arg3,
            vault_yield_fee_bps : arg4,
        };
        0x2::event::emit<FeesUpdated>(v0);
    }

    public fun set_treasury(arg0: &mut ProtocolConfig, arg1: &0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::access_control::AccessControl<REGISTRY>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::access_control::assert_has_role<REGISTRY, FeeManagerRole>(arg1, 0x2::tx_context::sender(arg3));
        arg0.treasury = arg2;
        let v0 = TreasuryUpdated{new_treasury: arg2};
        0x2::event::emit<TreasuryUpdated>(v0);
    }

    public fun treasury(arg0: &ProtocolConfig) : address {
        arg0.treasury
    }

    public fun vault_yield_fee_bps(arg0: &ProtocolConfig) : u64 {
        arg0.vault_yield_fee_bps
    }

    // decompiled from Move bytecode v7
}

