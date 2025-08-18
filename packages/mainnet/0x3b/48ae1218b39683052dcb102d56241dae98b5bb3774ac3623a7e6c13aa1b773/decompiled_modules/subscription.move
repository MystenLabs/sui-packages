module 0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::subscription {
    struct Subscription has store, key {
        id: 0x2::object::UID,
        holder: address,
        plan: u8,
        expires_ms: u64,
        version: u16,
    }

    struct PlatformService has store, key {
        id: 0x2::object::UID,
        monthly_fees: vector<u64>,
        duration_ms: u64,
        admin: address,
    }

    public fun extend(arg0: &mut Subscription, arg1: &PlatformService, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.holder == 0x2::tx_context::sender(arg4), 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= *0x1::vector::borrow<u64>(&arg1.monthly_fees, (arg0.plan as u64)), 0);
        arg0.expires_ms = arg0.expires_ms + arg1.duration_ms;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg1.admin);
        0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::inkray_events::emit_subscription_extended(arg0.holder, 0x2::object::uid_to_address(&arg0.id), arg0.expires_ms, arg0.expires_ms);
    }

    public fun get_plan_constants() : (u8, u8, u8) {
        (0, 1, 2)
    }

    public fun get_plan_name(arg0: u8) : vector<u8> {
        if (arg0 == 0) {
            b"Basic"
        } else if (arg0 == 1) {
            b"Premium"
        } else if (arg0 == 2) {
            b"Pro"
        } else {
            b"Unknown"
        }
    }

    public fun get_service_info(arg0: &PlatformService) : (&vector<u64>, u64, address) {
        (&arg0.monthly_fees, arg0.duration_ms, arg0.admin)
    }

    public fun get_subscription_info(arg0: &Subscription) : (address, u8, u64, u16) {
        (arg0.holder, arg0.plan, arg0.expires_ms, arg0.version)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PlatformService{
            id           : 0x2::object::new(arg0),
            monthly_fees : vector[5000000000, 10000000000, 20000000000],
            duration_ms  : 2592000000,
            admin        : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<PlatformService>(v0);
    }

    public fun is_expired(arg0: &Subscription, arg1: &0x2::clock::Clock) : bool {
        !is_valid(arg0, arg1)
    }

    public fun is_valid(arg0: &Subscription, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) < arg0.expires_ms
    }

    public fun mint_platform(arg0: &PlatformService, arg1: u8, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : Subscription {
        assert!((arg1 as u64) < 0x1::vector::length<u64>(&arg0.monthly_fees), 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= *0x1::vector::borrow<u64>(&arg0.monthly_fees, (arg1 as u64)), 0);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3) + arg0.duration_ms;
        let v2 = 0x2::object::new(arg4);
        let v3 = Subscription{
            id         : v2,
            holder     : v0,
            plan       : arg1,
            expires_ms : v1,
            version    : 1,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg0.admin);
        0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::inkray_events::emit_subscription_minted(v0, 0x2::object::uid_to_address(&v2), arg1, v1);
        v3
    }

    public fun renew(arg0: &mut Subscription, arg1: &PlatformService, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.holder == 0x2::tx_context::sender(arg4), 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= *0x1::vector::borrow<u64>(&arg1.monthly_fees, (arg0.plan as u64)), 0);
        arg0.expires_ms = 0x2::clock::timestamp_ms(arg3) + arg1.duration_ms;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg1.admin);
        0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::inkray_events::emit_subscription_extended(arg0.holder, 0x2::object::uid_to_address(&arg0.id), arg0.expires_ms, arg0.expires_ms);
    }

    public fun time_until_expiry(arg0: &Subscription, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.expires_ms) {
            0
        } else {
            arg0.expires_ms - v0
        }
    }

    public fun update_service(arg0: &mut PlatformService, arg1: vector<u64>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 3);
        arg0.monthly_fees = arg1;
        arg0.duration_ms = arg2;
    }

    // decompiled from Move bytecode v6
}

