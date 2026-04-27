module 0x58854b206540c556983a55cff3901b28297fff79f9eac07f3e4a0d807d58c744::fee_manager {
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
        is_paused: bool,
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

    struct FeesWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct AdminAddressChanged has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    public fun check_paused(arg0: &PlatformConfig) {
        assert!(!arg0.is_paused, 100);
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
            is_paused       : false,
        };
        0x2::transfer::share_object<PlatformConfig>(v2);
    }

    public fun is_admin(arg0: &PlatformConfig, arg1: &AdminCap) : bool {
        0x2::object::id<AdminCap>(arg1) == arg0.admin_cap_id
    }

    public fun remove_from_registry(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: 0x1::type_name::TypeName) {
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 1);
        if (0x2::table::contains<0x1::type_name::TypeName, CollectionConfig>(&arg1.registry, arg2)) {
            0x2::table::remove<0x1::type_name::TypeName, CollectionConfig>(&mut arg1.registry, arg2);
        };
    }

    public fun set_admin_address(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: address) {
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 1);
        arg1.admin_address = arg2;
        let v0 = AdminAddressChanged{
            old_admin : arg1.admin_address,
            new_admin : arg2,
        };
        0x2::event::emit<AdminAddressChanged>(v0);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: bool) {
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 1);
        arg1.is_paused = arg2;
    }

    public fun update_global_fee(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: u64) {
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 1);
        assert!(arg2 <= 100000000000, 101);
        arg1.global_flat_fee = arg2;
        let v0 = FeeUpdated{
            old_fee : arg1.global_flat_fee,
            new_fee : arg2,
        };
        0x2::event::emit<FeeUpdated>(v0);
    }

    public fun update_registry(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: 0x1::type_name::TypeName, arg3: bool, arg4: u64) {
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 1);
        assert!(arg4 <= 100000000000, 101);
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

