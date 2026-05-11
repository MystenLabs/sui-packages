module 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::registry {
    struct LaunchInfo has copy, drop, store {
        creator: address,
        vault_id: 0x2::object::ID,
        bonding_curve_id: 0x2::object::ID,
        bonding_curve_tax_bps: u16,
        post_graduation_tax_bps: u16,
        graduation_market_cap_sui: u64,
        payout_kind: u8,
        distribution_interval_hours: u16,
        launched_at_ms: u64,
        total_supply: u64,
    }

    struct LaunchpadRegistry has key {
        id: 0x2::object::UID,
        launches: 0x2::table::Table<0x1::ascii::String, LaunchInfo>,
        paused: bool,
        count: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : LaunchpadRegistry {
        LaunchpadRegistry{
            id       : 0x2::object::new(arg0),
            launches : 0x2::table::new<0x1::ascii::String, LaunchInfo>(arg0),
            paused   : false,
            count    : 0,
        }
    }

    public fun contains<T0>(arg0: &LaunchpadRegistry) : bool {
        0x2::table::contains<0x1::ascii::String, LaunchInfo>(&arg0.launches, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    public fun bonding_curve_id(arg0: &LaunchInfo) : 0x2::object::ID {
        arg0.bonding_curve_id
    }

    public fun bonding_curve_tax_bps(arg0: &LaunchInfo) : u16 {
        arg0.bonding_curve_tax_bps
    }

    public fun creator(arg0: &LaunchInfo) : address {
        arg0.creator
    }

    public fun distribution_interval_hours(arg0: &LaunchInfo) : u16 {
        arg0.distribution_interval_hours
    }

    public fun get<T0>(arg0: &LaunchpadRegistry) : &LaunchInfo {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        assert!(0x2::table::contains<0x1::ascii::String, LaunchInfo>(&arg0.launches, v0), 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_registry_not_found());
        0x2::table::borrow<0x1::ascii::String, LaunchInfo>(&arg0.launches, v0)
    }

    public fun graduation_market_cap_sui(arg0: &LaunchInfo) : u64 {
        arg0.graduation_market_cap_sui
    }

    public fun is_paused(arg0: &LaunchpadRegistry) : bool {
        arg0.paused
    }

    public fun launch_count(arg0: &LaunchpadRegistry) : u64 {
        arg0.count
    }

    public fun launched_at_ms(arg0: &LaunchInfo) : u64 {
        arg0.launched_at_ms
    }

    public fun payout_kind(arg0: &LaunchInfo) : u8 {
        arg0.payout_kind
    }

    public fun post_graduation_tax_bps(arg0: &LaunchInfo) : u16 {
        arg0.post_graduation_tax_bps
    }

    public(friend) fun register<T0>(arg0: &mut LaunchpadRegistry, arg1: address, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u16, arg5: u16, arg6: u64, arg7: u8, arg8: u16, arg9: u64, arg10: &0x2::clock::Clock) {
        assert!(!arg0.paused, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_registry_paused());
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        assert!(!0x2::table::contains<0x1::ascii::String, LaunchInfo>(&arg0.launches, v0), 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_registry_already_registered());
        let v1 = 0x2::clock::timestamp_ms(arg10);
        let v2 = LaunchInfo{
            creator                     : arg1,
            vault_id                    : arg2,
            bonding_curve_id            : arg3,
            bonding_curve_tax_bps       : arg4,
            post_graduation_tax_bps     : arg5,
            graduation_market_cap_sui   : arg6,
            payout_kind                 : arg7,
            distribution_interval_hours : arg8,
            launched_at_ms              : v1,
            total_supply                : arg9,
        };
        0x2::table::add<0x1::ascii::String, LaunchInfo>(&mut arg0.launches, v0, v2);
        arg0.count = arg0.count + 1;
        0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::events::emit_launch(0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::events::new_launch_event(v0, arg1, arg2, arg3, arg9, arg4, arg5, arg6, arg7, arg8, v1));
    }

    public fun set_paused(arg0: &mut LaunchpadRegistry, arg1: &0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::admin::AdminCap, arg2: bool, arg3: &0x2::clock::Clock) {
        arg0.paused = arg2;
        0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::events::emit_pause(0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::events::new_pause_event(arg2, 0x2::clock::timestamp_ms(arg3)));
    }

    public(friend) fun share(arg0: LaunchpadRegistry) {
        0x2::transfer::share_object<LaunchpadRegistry>(arg0);
    }

    public fun total_supply(arg0: &LaunchInfo) : u64 {
        arg0.total_supply
    }

    public fun vault_id(arg0: &LaunchInfo) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v6
}

