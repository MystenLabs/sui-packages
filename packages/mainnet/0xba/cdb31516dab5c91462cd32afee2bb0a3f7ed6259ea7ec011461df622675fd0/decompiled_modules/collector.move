module 0xbacdb31516dab5c91462cd32afee2bb0a3f7ed6259ea7ec011461df622675fd0::collector {
    struct FeeCollector has key {
        id: 0x2::object::UID,
        admin: address,
        collected_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        total_tokens_created: u64,
        total_burns: u64,
        total_pools_created: u64,
        total_multisends: u64,
        total_authority_transfers: u64,
        total_authority_revokes: u64,
        total_metadata_updates: u64,
        total_mints: u64,
        total_freezes: u64,
        total_unfreezes: u64,
        total_pauses: u64,
        total_resumes: u64,
        fees: 0x2::table::Table<u8, u64>,
    }

    struct ServiceUsed has copy, drop {
        user: address,
        service_type: u8,
        fee_paid: u64,
        recipient_count: u64,
        timestamp: u64,
    }

    public fun get_full_stats(arg0: &FeeCollector) : (u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64) {
        (arg0.total_tokens_created, arg0.total_burns, arg0.total_pools_created, arg0.total_multisends, arg0.total_authority_transfers, arg0.total_authority_revokes, arg0.total_metadata_updates, arg0.total_mints, arg0.total_freezes, arg0.total_unfreezes, arg0.total_pauses, arg0.total_resumes, 0x2::balance::value<0x2::sui::SUI>(&arg0.collected_fees))
    }

    public fun get_service_fee(arg0: &FeeCollector, arg1: u8) : u64 {
        if (0x2::table::contains<u8, u64>(&arg0.fees, arg1)) {
            *0x2::table::borrow<u8, u64>(&arg0.fees, arg1)
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::new<u8, u64>(arg0);
        0x2::table::add<u8, u64>(&mut v0, 1, 6000000000);
        0x2::table::add<u8, u64>(&mut v0, 2, 3000000000);
        0x2::table::add<u8, u64>(&mut v0, 3, 8000000000);
        0x2::table::add<u8, u64>(&mut v0, 4, 90000000);
        0x2::table::add<u8, u64>(&mut v0, 5, 2000000000);
        0x2::table::add<u8, u64>(&mut v0, 6, 2000000000);
        0x2::table::add<u8, u64>(&mut v0, 7, 1000000000);
        0x2::table::add<u8, u64>(&mut v0, 8, 2000000000);
        0x2::table::add<u8, u64>(&mut v0, 9, 2000000000);
        0x2::table::add<u8, u64>(&mut v0, 10, 2000000000);
        0x2::table::add<u8, u64>(&mut v0, 11, 2000000000);
        0x2::table::add<u8, u64>(&mut v0, 12, 2000000000);
        let v1 = FeeCollector{
            id                        : 0x2::object::new(arg0),
            admin                     : 0x2::tx_context::sender(arg0),
            collected_fees            : 0x2::balance::zero<0x2::sui::SUI>(),
            total_tokens_created      : 0,
            total_burns               : 0,
            total_pools_created       : 0,
            total_multisends          : 0,
            total_authority_transfers : 0,
            total_authority_revokes   : 0,
            total_metadata_updates    : 0,
            total_mints               : 0,
            total_freezes             : 0,
            total_unfreezes           : 0,
            total_pauses              : 0,
            total_resumes             : 0,
            fees                      : v0,
        };
        0x2::transfer::share_object<FeeCollector>(v1);
    }

    public entry fun pay_service_fee(arg0: &mut FeeCollector, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u8, u64>(&arg0.fees, arg2), 3);
        let v0 = if (arg2 == 4) {
            assert!(arg3 > 0, 4);
            *0x2::table::borrow<u8, u64>(&arg0.fees, arg2) * arg3
        } else {
            *0x2::table::borrow<u8, u64>(&arg0.fees, arg2)
        };
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 >= v0, 1);
        if (v1 > v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v1 - v0, arg4), 0x2::tx_context::sender(arg4));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.collected_fees, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        if (arg2 == 1) {
            arg0.total_tokens_created = arg0.total_tokens_created + 1;
        } else if (arg2 == 2) {
            arg0.total_burns = arg0.total_burns + 1;
        } else if (arg2 == 3) {
            arg0.total_pools_created = arg0.total_pools_created + 1;
        } else if (arg2 == 4) {
            arg0.total_multisends = arg0.total_multisends + 1;
        } else if (arg2 == 5) {
            arg0.total_authority_transfers = arg0.total_authority_transfers + 1;
        } else if (arg2 == 6) {
            arg0.total_authority_revokes = arg0.total_authority_revokes + 1;
        } else if (arg2 == 7) {
            arg0.total_metadata_updates = arg0.total_metadata_updates + 1;
        } else if (arg2 == 8) {
            arg0.total_mints = arg0.total_mints + 1;
        } else if (arg2 == 9) {
            arg0.total_freezes = arg0.total_freezes + 1;
        } else if (arg2 == 10) {
            arg0.total_unfreezes = arg0.total_unfreezes + 1;
        } else if (arg2 == 11) {
            arg0.total_pauses = arg0.total_pauses + 1;
        } else if (arg2 == 12) {
            arg0.total_resumes = arg0.total_resumes + 1;
        };
        let v2 = ServiceUsed{
            user            : 0x2::tx_context::sender(arg4),
            service_type    : arg2,
            fee_paid        : v0,
            recipient_count : arg3,
            timestamp       : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<ServiceUsed>(v2);
    }

    public fun service_burn_tokens() : u8 {
        2
    }

    public fun service_create_pool() : u8 {
        3
    }

    public fun service_freeze_address() : u8 {
        9
    }

    public fun service_mint_tokens() : u8 {
        8
    }

    public fun service_multisender() : u8 {
        4
    }

    public fun service_pause_token() : u8 {
        11
    }

    public fun service_resume_token() : u8 {
        12
    }

    public fun service_revoke_authority() : u8 {
        6
    }

    public fun service_token_creation() : u8 {
        1
    }

    public fun service_transfer_authority() : u8 {
        5
    }

    public fun service_unfreeze_address() : u8 {
        10
    }

    public fun service_update_metadata() : u8 {
        7
    }

    public entry fun transfer_admin(arg0: &mut FeeCollector, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        arg0.admin = arg1;
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

