module 0xf5ee1ce1f80c25057a93ce5b3dba42d6775911c033b5ab619df867ec0960a224::fee_manager {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct PlatformConfig has store, key {
        id: 0x2::object::UID,
        fees_collected: 0x2::balance::Balance<0x2::sui::SUI>,
        global_flat_fee: u64,
        is_paused: bool,
        registry: 0x2::bag::Bag,
    }

    struct FeeDetails has drop, store {
        flat_fee_override: u64,
    }

    struct FeesWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct RegistryUpdated has copy, drop {
        nft_type: 0x1::type_name::TypeName,
        is_added: bool,
        fee: u64,
    }

    struct GlobalFeeUpdated has copy, drop {
        old_fee: u64,
        new_fee: u64,
    }

    public fun check_paused(arg0: &PlatformConfig) {
        assert!(!arg0.is_paused, 2);
    }

    public(friend) fun collect_fee(arg0: &mut PlatformConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fees_collected, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun get_flat_fee(arg0: &PlatformConfig, arg1: 0x1::type_name::TypeName) : u64 {
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.registry, arg1)) {
            0x2::bag::borrow<0x1::type_name::TypeName, FeeDetails>(&arg0.registry, arg1).flat_fee_override
        } else {
            arg0.global_flat_fee
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PlatformConfig{
            id              : 0x2::object::new(arg0),
            fees_collected  : 0x2::balance::zero<0x2::sui::SUI>(),
            global_flat_fee : 0,
            is_paused       : false,
            registry        : 0x2::bag::new(arg0),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<PlatformConfig>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_admin(arg0: &PlatformConfig, arg1: &AdminCap) : bool {
        true
    }

    public entry fun set_paused(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: bool) {
        arg1.is_paused = arg2;
    }

    public entry fun update_global_fee(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: u64) {
        assert!(arg2 <= 5000000000, 4);
        arg1.global_flat_fee = arg2;
        let v0 = GlobalFeeUpdated{
            old_fee : arg1.global_flat_fee,
            new_fee : arg2,
        };
        0x2::event::emit<GlobalFeeUpdated>(v0);
    }

    public entry fun update_registry<T0: store + key>(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: bool, arg3: u64) {
        let v0 = 0x1::type_name::get<T0>();
        if (arg2) {
            assert!(arg3 <= 5000000000, 4);
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.registry, v0)) {
                0x2::bag::borrow_mut<0x1::type_name::TypeName, FeeDetails>(&mut arg1.registry, v0).flat_fee_override = arg3;
            } else {
                let v1 = FeeDetails{flat_fee_override: arg3};
                0x2::bag::add<0x1::type_name::TypeName, FeeDetails>(&mut arg1.registry, v0, v1);
            };
        } else if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.registry, v0)) {
            0x2::bag::remove<0x1::type_name::TypeName, FeeDetails>(&mut arg1.registry, v0);
        };
        let v2 = RegistryUpdated{
            nft_type : v0,
            is_added : arg2,
            fee      : arg3,
        };
        0x2::event::emit<RegistryUpdated>(v2);
    }

    public entry fun withdraw_fees(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.fees_collected) >= arg2, 3);
        let v0 = FeesWithdrawn{
            amount    : arg2,
            recipient : arg3,
        };
        0x2::event::emit<FeesWithdrawn>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.fees_collected, arg2), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

