module 0xecf774832f03faa8f46faf763113d1e0a87d9a35836bea6250aa116b2d9b7ed8::memez_coin_registry {
    struct CoinInfo has copy, drop, store {
        treasury_cap_v2: address,
        metadata: address,
        mint_cap: address,
        burn_cap: address,
        metadata_cap: address,
    }

    struct MemezCoinRegistry has key {
        id: 0x2::object::UID,
        coins: 0x2::table::Table<0x1::type_name::TypeName, CoinInfo>,
    }

    public fun get<T0>(arg0: &MemezCoinRegistry) : 0x1::option::Option<CoinInfo> {
        if (0x2::table::contains<0x1::type_name::TypeName, CoinInfo>(&arg0.coins, 0x1::type_name::get<T0>())) {
            0x1::option::some<CoinInfo>(*0x2::table::borrow<0x1::type_name::TypeName, CoinInfo>(&arg0.coins, 0x1::type_name::get<T0>()))
        } else {
            0x1::option::none<CoinInfo>()
        }
    }

    public fun add<T0>(arg0: &mut MemezCoinRegistry, arg1: &0x6ae119a4ececaff1759043504e7a1fcbf3b93c45f670f1a2ab397bad9530993c::coin_v2::TreasuryCapV2, arg2: &0x2::coin::CoinMetadata<T0>, arg3: 0x6ae119a4ececaff1759043504e7a1fcbf3b93c45f670f1a2ab397bad9530993c::coin_v2::CapWitness) {
        assert!(0x1::type_name::get<T0>() == 0x6ae119a4ececaff1759043504e7a1fcbf3b93c45f670f1a2ab397bad9530993c::coin_v2::cap_witness_name(&arg3), 9223372273077977089);
        let v0 = 0x2::object::id<0x6ae119a4ececaff1759043504e7a1fcbf3b93c45f670f1a2ab397bad9530993c::coin_v2::TreasuryCapV2>(arg1);
        let v1 = 0x2::object::id_to_address(&v0);
        assert!(v1 == 0x6ae119a4ececaff1759043504e7a1fcbf3b93c45f670f1a2ab397bad9530993c::coin_v2::cap_witness_treasury(&arg3), 9223372290257977347);
        let v2 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg2);
        let v3 = CoinInfo{
            treasury_cap_v2 : v1,
            metadata        : 0x2::object::id_to_address(&v2),
            mint_cap        : 0x1::option::destroy_with_default<address>(0x6ae119a4ececaff1759043504e7a1fcbf3b93c45f670f1a2ab397bad9530993c::coin_v2::mint_cap_address(&arg3), @0x0),
            burn_cap        : 0x1::option::destroy_with_default<address>(0x6ae119a4ececaff1759043504e7a1fcbf3b93c45f670f1a2ab397bad9530993c::coin_v2::burn_cap_address(&arg3), @0x0),
            metadata_cap    : 0x1::option::destroy_with_default<address>(0x6ae119a4ececaff1759043504e7a1fcbf3b93c45f670f1a2ab397bad9530993c::coin_v2::metadata_cap_address(&arg3), @0x0),
        };
        0x2::table::add<0x1::type_name::TypeName, CoinInfo>(&mut arg0.coins, 0x1::type_name::get<T0>(), v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MemezCoinRegistry{
            id    : 0x2::object::new(arg0),
            coins : 0x2::table::new<0x1::type_name::TypeName, CoinInfo>(arg0),
        };
        0x2::transfer::share_object<MemezCoinRegistry>(v0);
    }

    // decompiled from Move bytecode v6
}

