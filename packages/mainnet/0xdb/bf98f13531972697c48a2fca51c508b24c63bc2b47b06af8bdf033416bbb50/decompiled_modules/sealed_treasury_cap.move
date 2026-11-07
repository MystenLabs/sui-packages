module 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::sealed_treasury_cap {
    struct SealedTreasuryCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        package_witness: 0x1::type_name::TypeName,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
    }

    struct VenueAdmission has drop {
        package_witness: 0x1::type_name::TypeName,
        venue: 0x1::type_name::TypeName,
    }

    public fun total_supply<T0>(arg0: &SealedTreasuryCap<T0>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.treasury_cap)
    }

    public fun new<T0, T1: drop>(arg0: T1, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : SealedTreasuryCap<T0> {
        SealedTreasuryCap<T0>{
            id              : 0x2::object::new(arg2),
            package_witness : 0x1::type_name::with_original_ids<T1>(),
            treasury_cap    : arg1,
        }
    }

    public fun admission_package_witness(arg0: &VenueAdmission) : 0x1::type_name::TypeName {
        arg0.package_witness
    }

    public fun admission_venue(arg0: &VenueAdmission) : 0x1::type_name::TypeName {
        arg0.venue
    }

    public fun into_treasury_cap<T0, T1: drop>(arg0: SealedTreasuryCap<T0>, arg1: T1) : 0x2::coin::TreasuryCap<T0> {
        assert!(arg0.package_witness == 0x1::type_name::with_original_ids<T1>(), 10);
        let SealedTreasuryCap {
            id              : v0,
            package_witness : _,
            treasury_cap    : v2,
        } = arg0;
        0x2::object::delete(v0);
        v2
    }

    public fun package_witness<T0>(arg0: &SealedTreasuryCap<T0>) : 0x1::type_name::TypeName {
        arg0.package_witness
    }

    public fun treasury_cap_id<T0>(arg0: &SealedTreasuryCap<T0>) : 0x2::object::ID {
        0x2::object::id<0x2::coin::TreasuryCap<T0>>(&arg0.treasury_cap)
    }

    public fun treasury_cap_mut<T0, T1: drop>(arg0: &mut SealedTreasuryCap<T0>, arg1: VenueAdmission, arg2: T1) : &mut 0x2::coin::TreasuryCap<T0> {
        assert!(arg1.package_witness == arg0.package_witness, 10);
        assert!(arg1.venue == 0x1::type_name::with_original_ids<T1>(), 14);
        &mut arg0.treasury_cap
    }

    public fun venue_admission<T0: drop, T1: drop>(arg0: T1) : VenueAdmission {
        VenueAdmission{
            package_witness : 0x1::type_name::with_original_ids<T1>(),
            venue           : 0x1::type_name::with_original_ids<T0>(),
        }
    }

    // decompiled from Move bytecode v7
}

