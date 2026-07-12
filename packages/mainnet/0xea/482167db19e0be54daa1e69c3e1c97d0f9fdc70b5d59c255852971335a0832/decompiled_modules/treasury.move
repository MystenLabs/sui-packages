module 0xea482167db19e0be54daa1e69c3e1c97d0f9fdc70b5d59c255852971335a0832::treasury {
    struct TreasuryVault has key {
        id: 0x2::object::UID,
        asset_count: u64,
    }

    struct AssetKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct TreasuryEntry<phantom T0> has store {
        cap: 0x2::coin::TreasuryCap<T0>,
        enabled: bool,
    }

    public fun burn<T0>(arg0: &0xea482167db19e0be54daa1e69c3e1c97d0f9fdc70b5d59c255852971335a0832::config::GlobalConfig, arg1: &mut TreasuryVault, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) : u64 {
        0xea482167db19e0be54daa1e69c3e1c97d0f9fdc70b5d59c255852971335a0832::config::assert_version(arg0);
        0xea482167db19e0be54daa1e69c3e1c97d0f9fdc70b5d59c255852971335a0832::config::assert_broker(arg0, 0x2::tx_context::sender(arg3));
        let v0 = borrow_entry_mut<T0>(arg1);
        assert!(v0.enabled, 0);
        let v1 = 0x2::coin::burn<T0>(&mut v0.cap, arg2);
        0xea482167db19e0be54daa1e69c3e1c97d0f9fdc70b5d59c255852971335a0832::events::burned(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())), v1, 0x2::tx_context::sender(arg3));
        v1
    }

    public fun mint<T0>(arg0: &0xea482167db19e0be54daa1e69c3e1c97d0f9fdc70b5d59c255852971335a0832::config::GlobalConfig, arg1: &mut TreasuryVault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xea482167db19e0be54daa1e69c3e1c97d0f9fdc70b5d59c255852971335a0832::config::assert_version(arg0);
        0xea482167db19e0be54daa1e69c3e1c97d0f9fdc70b5d59c255852971335a0832::config::assert_broker(arg0, 0x2::tx_context::sender(arg3));
        let v0 = borrow_entry_mut<T0>(arg1);
        assert!(v0.enabled, 0);
        0xea482167db19e0be54daa1e69c3e1c97d0f9fdc70b5d59c255852971335a0832::events::minted(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())), arg2, 0x2::tx_context::sender(arg3));
        0x2::coin::mint<T0>(&mut v0.cap, arg2, arg3)
    }

    public fun total_supply<T0>(arg0: &TreasuryVault) : u64 {
        0x2::coin::total_supply<T0>(&borrow_entry<T0>(arg0).cap)
    }

    public fun asset_count(arg0: &TreasuryVault) : u64 {
        arg0.asset_count
    }

    fun borrow_entry<T0>(arg0: &TreasuryVault) : &TreasuryEntry<T0> {
        let v0 = AssetKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<AssetKey<T0>, TreasuryEntry<T0>>(&arg0.id, v0), 2);
        let v1 = AssetKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<AssetKey<T0>, TreasuryEntry<T0>>(&arg0.id, v1)
    }

    fun borrow_entry_mut<T0>(arg0: &mut TreasuryVault) : &mut TreasuryEntry<T0> {
        let v0 = AssetKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<AssetKey<T0>, TreasuryEntry<T0>>(&arg0.id, v0), 2);
        let v1 = AssetKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<AssetKey<T0>, TreasuryEntry<T0>>(&mut arg0.id, v1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TreasuryVault{
            id          : 0x2::object::new(arg0),
            asset_count : 0,
        };
        0x2::transfer::share_object<TreasuryVault>(v0);
    }

    public fun is_enabled<T0>(arg0: &TreasuryVault) : bool {
        borrow_entry<T0>(arg0).enabled
    }

    public fun is_registered<T0>(arg0: &TreasuryVault) : bool {
        let v0 = AssetKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_with_type<AssetKey<T0>, TreasuryEntry<T0>>(&arg0.id, v0)
    }

    public fun register<T0>(arg0: &0xea482167db19e0be54daa1e69c3e1c97d0f9fdc70b5d59c255852971335a0832::config::AdminCap, arg1: &0xea482167db19e0be54daa1e69c3e1c97d0f9fdc70b5d59c255852971335a0832::config::GlobalConfig, arg2: &mut TreasuryVault, arg3: 0x2::coin::TreasuryCap<T0>) {
        0xea482167db19e0be54daa1e69c3e1c97d0f9fdc70b5d59c255852971335a0832::config::assert_version(arg1);
        let v0 = AssetKey<T0>{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_with_type<AssetKey<T0>, TreasuryEntry<T0>>(&arg2.id, v0), 1);
        let v1 = AssetKey<T0>{dummy_field: false};
        let v2 = TreasuryEntry<T0>{
            cap     : arg3,
            enabled : true,
        };
        0x2::dynamic_field::add<AssetKey<T0>, TreasuryEntry<T0>>(&mut arg2.id, v1, v2);
        arg2.asset_count = arg2.asset_count + 1;
        0xea482167db19e0be54daa1e69c3e1c97d0f9fdc70b5d59c255852971335a0832::events::treasury_registered(0x2::object::uid_to_inner(&arg2.id), 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())));
    }

    public fun set_enabled<T0>(arg0: &0xea482167db19e0be54daa1e69c3e1c97d0f9fdc70b5d59c255852971335a0832::config::AdminCap, arg1: &0xea482167db19e0be54daa1e69c3e1c97d0f9fdc70b5d59c255852971335a0832::config::GlobalConfig, arg2: &mut TreasuryVault, arg3: bool) {
        0xea482167db19e0be54daa1e69c3e1c97d0f9fdc70b5d59c255852971335a0832::config::assert_version(arg1);
        borrow_entry_mut<T0>(arg2).enabled = arg3;
    }

    // decompiled from Move bytecode v7
}

