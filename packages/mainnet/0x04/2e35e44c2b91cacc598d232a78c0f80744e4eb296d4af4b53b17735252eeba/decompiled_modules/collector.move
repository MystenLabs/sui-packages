module 0x42e35e44c2b91cacc598d232a78c0f80744e4eb296d4af4b53b17735252eeba::collector {
    struct FeeCollector has key {
        id: 0x2::object::UID,
        admin: address,
        collected_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        total_tokens_created: u64,
        total_burns: u64,
        total_multisends: u64,
        total_revokes: u64,
        fees: 0x2::table::Table<u8, u64>,
    }

    struct ServiceUsed has copy, drop {
        user: address,
        service_type: u8,
        fee_paid: u64,
        timestamp: u64,
    }

    public fun get_service_fee(arg0: &FeeCollector, arg1: u8) : u64 {
        if (0x2::table::contains<u8, u64>(&arg0.fees, arg1)) {
            *0x2::table::borrow<u8, u64>(&arg0.fees, arg1)
        } else {
            0
        }
    }

    public fun get_stats(arg0: &FeeCollector) : (u64, u64, u64, u64, u64, u64) {
        (arg0.total_tokens_created, arg0.total_burns, arg0.total_multisends, arg0.total_revokes, 0x2::balance::value<0x2::sui::SUI>(&arg0.collected_fees), *0x2::table::borrow<u8, u64>(&arg0.fees, 1))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::new<u8, u64>(arg0);
        0x2::table::add<u8, u64>(&mut v0, 1, 6000000000);
        0x2::table::add<u8, u64>(&mut v0, 2, 3000000000);
        0x2::table::add<u8, u64>(&mut v0, 3, 90000000);
        0x2::table::add<u8, u64>(&mut v0, 4, 2000000000);
        let v1 = FeeCollector{
            id                   : 0x2::object::new(arg0),
            admin                : 0x2::tx_context::sender(arg0),
            collected_fees       : 0x2::balance::zero<0x2::sui::SUI>(),
            total_tokens_created : 0,
            total_burns          : 0,
            total_multisends     : 0,
            total_revokes        : 0,
            fees                 : v0,
        };
        0x2::transfer::share_object<FeeCollector>(v1);
    }

    public entry fun pay_service_fee(arg0: &mut FeeCollector, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u8, u64>(&arg0.fees, arg2), 3);
        let v0 = *0x2::table::borrow<u8, u64>(&arg0.fees, arg2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 >= v0, 1);
        if (v1 > v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v1 - v0, arg3), 0x2::tx_context::sender(arg3));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.collected_fees, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        if (arg2 == 1) {
            arg0.total_tokens_created = arg0.total_tokens_created + 1;
        } else if (arg2 == 2) {
            arg0.total_burns = arg0.total_burns + 1;
        } else if (arg2 == 3) {
            arg0.total_multisends = arg0.total_multisends + 1;
        } else if (arg2 == 4) {
            arg0.total_revokes = arg0.total_revokes + 1;
        };
        let v2 = ServiceUsed{
            user         : 0x2::tx_context::sender(arg3),
            service_type : arg2,
            fee_paid     : v0,
            timestamp    : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<ServiceUsed>(v2);
    }

    public fun service_burn_tokens() : u8 {
        2
    }

    public fun service_multisender() : u8 {
        3
    }

    public fun service_revoke_authority() : u8 {
        4
    }

    public fun service_token_creation() : u8 {
        1
    }

    public entry fun update_service_fee(arg0: &mut FeeCollector, arg1: u8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 2);
        if (0x2::table::contains<u8, u64>(&arg0.fees, arg1)) {
            *0x2::table::borrow_mut<u8, u64>(&mut arg0.fees, arg1) = arg2;
        } else {
            0x2::table::add<u8, u64>(&mut arg0.fees, arg1, arg2);
        };
    }

    public entry fun withdraw_fees(arg0: &mut FeeCollector, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.collected_fees, arg1), arg2), arg0.admin);
    }

    // decompiled from Move bytecode v6
}

