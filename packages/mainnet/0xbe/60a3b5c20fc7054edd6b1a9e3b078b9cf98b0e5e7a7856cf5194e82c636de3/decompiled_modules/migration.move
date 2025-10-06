module 0xbe60a3b5c20fc7054edd6b1a9e3b078b9cf98b0e5e7a7856cf5194e82c636de3::migration {
    struct MigrationCap has store, key {
        id: 0x2::object::UID,
    }

    struct MigrationTicket<phantom T0> {
        migration_cap: address,
        oft_cap: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap,
        treasury_cap: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>,
        escrow: 0x1::option::Option<0x2::balance::Balance<T0>>,
        extra: 0x2::bag::Bag,
    }

    public fun create_migration_ticket<T0>(arg0: &MigrationCap, arg1: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap, arg2: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>, arg3: 0x1::option::Option<0x2::balance::Balance<T0>>, arg4: 0x2::bag::Bag) : MigrationTicket<T0> {
        assert!(0x1::option::is_none<0x2::coin::TreasuryCap<T0>>(&arg2) && 0x1::option::is_some<0x2::balance::Balance<T0>>(&arg3) || 0x1::option::is_some<0x2::coin::TreasuryCap<T0>>(&arg2) && 0x1::option::is_none<0x2::balance::Balance<T0>>(&arg3), 1);
        MigrationTicket<T0>{
            migration_cap : 0x2::object::id_address<MigrationCap>(arg0),
            oft_cap       : arg1,
            treasury_cap  : arg2,
            escrow        : arg3,
            extra         : arg4,
        }
    }

    public fun destroy_migration_cap(arg0: MigrationCap) {
        let MigrationCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_migration_ticket<T0>(arg0: MigrationTicket<T0>, arg1: &MigrationCap) : (0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap, 0x1::option::Option<0x2::coin::TreasuryCap<T0>>, 0x1::option::Option<0x2::balance::Balance<T0>>, 0x2::bag::Bag) {
        assert!(0x2::object::id_address<MigrationCap>(arg1) == arg0.migration_cap, 2);
        let MigrationTicket {
            migration_cap : _,
            oft_cap       : v1,
            treasury_cap  : v2,
            escrow        : v3,
            extra         : v4,
        } = arg0;
        (v1, v2, v3, v4)
    }

    public fun new_migration_cap(arg0: &mut 0x2::tx_context::TxContext) : MigrationCap {
        MigrationCap{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

