module 0x37d37efe9e1ed958aaa8b817c0fc1c66400a8b949b5c3ae6f5d205e17a63bad4::nft_burn {
    struct PONZI has drop {
        dummy_field: bool,
    }

    struct BurnManager has key {
        id: 0x2::object::UID,
        admin: address,
        ponzi_balance: 0x2::balance::Balance<PONZI>,
    }

    struct Claimed has copy, drop, store {
        dummy_field: bool,
    }

    public entry fun add_ponzi_tokens(arg0: &mut BurnManager, arg1: 0x2::coin::Coin<PONZI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        0x2::balance::join<PONZI>(&mut arg0.ponzi_balance, 0x2::coin::into_balance<PONZI>(arg1));
    }

    public entry fun burn_and_claim(arg0: &mut BurnManager, arg1: &0x75163e4841a873246a0bfdf3a4eb3fb78cc168a141ee221f1eac824efdd3fd7f::fundraise::Config, arg2: 0x75163e4841a873246a0bfdf3a4eb3fb78cc168a141ee221f1eac824efdd3fd7f::fundraise::AllocationNFT, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x75163e4841a873246a0bfdf3a4eb3fb78cc168a141ee221f1eac824efdd3fd7f::fundraise::is_claim_live(arg1), 2);
        let v0 = 0x2::object::id<0x75163e4841a873246a0bfdf3a4eb3fb78cc168a141ee221f1eac824efdd3fd7f::fundraise::AllocationNFT>(&arg2);
        assert!(!0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, v0), 4);
        assert!(arg3 > 0, 3);
        let v1 = arg3 * 1000000000;
        assert!(0x2::balance::value<PONZI>(&arg0.ponzi_balance) >= v1, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<PONZI>>(0x2::coin::from_balance<PONZI>(0x2::balance::split<PONZI>(&mut arg0.ponzi_balance, v1), arg4), 0x2::tx_context::sender(arg4));
        let v2 = Claimed{dummy_field: false};
        0x2::dynamic_field::add<0x2::object::ID, Claimed>(&mut arg0.id, v0, v2);
        0x75163e4841a873246a0bfdf3a4eb3fb78cc168a141ee221f1eac824efdd3fd7f::fundraise::claim(arg1, arg2, arg4);
    }

    public entry fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BurnManager{
            id            : 0x2::object::new(arg0),
            admin         : 0x2::tx_context::sender(arg0),
            ponzi_balance : 0x2::balance::zero<PONZI>(),
        };
        0x2::transfer::share_object<BurnManager>(v0);
    }

    public fun is_claimed(arg0: &BurnManager, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1)
    }

    public fun remaining_balance(arg0: &BurnManager) : u64 {
        0x2::balance::value<PONZI>(&arg0.ponzi_balance)
    }

    public entry fun update_admin(arg0: &mut BurnManager, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.admin = arg1;
    }

    public fun verify_allocation(arg0: u64) : bool {
        arg0 > 0
    }

    // decompiled from Move bytecode v6
}

