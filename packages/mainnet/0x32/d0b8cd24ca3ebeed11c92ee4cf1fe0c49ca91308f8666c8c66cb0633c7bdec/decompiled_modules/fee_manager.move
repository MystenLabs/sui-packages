module 0x32d0b8cd24ca3ebeed11c92ee4cf1fe0c49ca91308f8666c8c66cb0633c7bdec::fee_manager {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CollectionConfig has copy, drop, store {
        is_verified: bool,
        flat_fee_override: u64,
    }

    struct PlatformConfig has key {
        id: 0x2::object::UID,
        admin_cap_id: 0x2::object::ID,
        global_flat_fee: u64,
        registry: 0x2::table::Table<0x1::type_name::TypeName, CollectionConfig>,
        fees_collected: 0x2::balance::Balance<0x2::sui::SUI>,
        admin_address: address,
    }

    struct FeeUpdated has copy, drop {
        old_fee: u64,
        new_fee: u64,
    }

    struct RegistryUpdated has copy, drop {
        collection: 0x1::type_name::TypeName,
        is_verified: bool,
        fee: u64,
    }

    struct RegistryRemoved has copy, drop {
        collection: 0x1::type_name::TypeName,
    }

    struct FeesWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    public fun admin_cap_id(arg0: &PlatformConfig) : 0x2::object::ID {
        arg0.admin_cap_id
    }

    public fun collect_fee(arg0: &mut PlatformConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fees_collected, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun get_flat_fee(arg0: &PlatformConfig, arg1: 0x1::type_name::TypeName) : u64 {
        if (0x2::table::contains<0x1::type_name::TypeName, CollectionConfig>(&arg0.registry, arg1)) {
            0x2::table::borrow<0x1::type_name::TypeName, CollectionConfig>(&arg0.registry, arg1).flat_fee_override
        } else {
            arg0.global_flat_fee
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = 0x2::tx_context::sender(arg0);
        0x2::transfer::transfer<AdminCap>(v0, v1);
        let v2 = PlatformConfig{
            id              : 0x2::object::new(arg0),
            admin_cap_id    : 0x2::object::id<AdminCap>(&v0),
            global_flat_fee : 0,
            registry        : 0x2::table::new<0x1::type_name::TypeName, CollectionConfig>(arg0),
            fees_collected  : 0x2::balance::zero<0x2::sui::SUI>(),
            admin_address   : v1,
        };
        0x2::transfer::share_object<PlatformConfig>(v2);
    }

    public fun remove_from_registry(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: 0x1::type_name::TypeName) {
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 1);
        assert!(0x2::table::contains<0x1::type_name::TypeName, CollectionConfig>(&arg1.registry, arg2), 4);
        0x2::table::remove<0x1::type_name::TypeName, CollectionConfig>(&mut arg1.registry, arg2);
        let v0 = RegistryRemoved{collection: arg2};
        0x2::event::emit<RegistryRemoved>(v0);
    }

    public fun update_global_fee(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: u64) {
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 1);
        assert!(arg2 <= 10000000000, 5);
        arg1.global_flat_fee = arg2;
        let v0 = FeeUpdated{
            old_fee : arg1.global_flat_fee,
            new_fee : arg2,
        };
        0x2::event::emit<FeeUpdated>(v0);
    }

    public fun update_registry(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: 0x1::type_name::TypeName, arg3: bool, arg4: u64) {
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 1);
        assert!(arg4 <= 10000000000, 5);
        let v0 = CollectionConfig{
            is_verified       : arg3,
            flat_fee_override : arg4,
        };
        if (0x2::table::contains<0x1::type_name::TypeName, CollectionConfig>(&arg1.registry, arg2)) {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, CollectionConfig>(&mut arg1.registry, arg2) = v0;
        } else {
            0x2::table::add<0x1::type_name::TypeName, CollectionConfig>(&mut arg1.registry, arg2, v0);
        };
        let v1 = RegistryUpdated{
            collection  : arg2,
            is_verified : arg3,
            fee         : arg4,
        };
        0x2::event::emit<RegistryUpdated>(v1);
    }

    public fun withdraw_fees(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 1);
        assert!(arg2 <= 0x2::balance::value<0x2::sui::SUI>(&arg1.fees_collected), 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.fees_collected, arg2), arg3), arg1.admin_address);
        let v0 = FeesWithdrawn{
            amount    : arg2,
            recipient : arg1.admin_address,
        };
        0x2::event::emit<FeesWithdrawn>(v0);
    }

    // decompiled from Move bytecode v6
}

