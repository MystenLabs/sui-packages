module 0x620cd663334de4e7b1d51b3a1de495410129aa7db5025202695b02b5d9cce57a::lp_referral {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct LpReferral has key {
        id: 0x2::object::UID,
        last_claimed_timestamp: 0x2::table::Table<address, u64>,
        verifier: vector<u8>,
        sui_vault: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct DepositEvent has copy, drop {
        depositor: address,
        amount: u64,
    }

    struct ClaimEvent has copy, drop {
        user: address,
        amount: u64,
        from_ts: u64,
        to_ts: u64,
    }

    struct WithdrawEvent has copy, drop {
        admin: address,
        amount: u64,
    }

    struct LpReferralCreated has copy, drop {
        id: 0x2::object::ID,
    }

    public fun claim(arg0: &mut LpReferral, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let (v0, v1, v2, v3) = verify_signature(&arg0.verifier, &arg1, &arg2);
        claim_internal(arg0, v0, v1, v2, v3, arg3, arg4)
    }

    fun claim_internal(arg0: &mut LpReferral, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg2 > 0, 3);
        assert!(0x2::tx_context::sender(arg6) == arg1, 2);
        assert!(arg3 < arg4, 4);
        assert!(arg3 == get_last_claimed_timestamp(arg0, arg1), 0);
        assert!(arg4 <= 0x2::clock::timestamp_ms(arg5), 4);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_vault) >= arg2, 1);
        if (0x2::table::contains<address, u64>(&arg0.last_claimed_timestamp, arg1)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.last_claimed_timestamp, arg1) = arg4;
        } else {
            0x2::table::add<address, u64>(&mut arg0.last_claimed_timestamp, arg1, arg4);
        };
        let v0 = ClaimEvent{
            user    : arg1,
            amount  : arg2,
            from_ts : arg3,
            to_ts   : arg4,
        };
        0x2::event::emit<ClaimEvent>(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_vault, arg2), arg6)
    }

    public fun deposit(arg0: &mut LpReferral, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_vault, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = DepositEvent{
            depositor : 0x2::tx_context::sender(arg2),
            amount    : v0,
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    public fun get_last_claimed_timestamp(arg0: &LpReferral, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.last_claimed_timestamp, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.last_claimed_timestamp, arg1)
        } else {
            0
        }
    }

    public fun get_verifier(arg0: &LpReferral) : vector<u8> {
        arg0.verifier
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = LpReferral{
            id                     : 0x2::object::new(arg0),
            last_claimed_timestamp : 0x2::table::new<address, u64>(arg0),
            verifier               : 0x1::vector::empty<u8>(),
            sui_vault              : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<LpReferral>(v1);
        let v2 = LpReferralCreated{id: 0x2::object::id<LpReferral>(&v1)};
        0x2::event::emit<LpReferralCreated>(v2);
    }

    public fun set_verifier(arg0: &mut LpReferral, arg1: vector<u8>, arg2: &AdminCap) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 5);
        arg0.verifier = arg1;
    }

    public fun transfer_capability(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun vault_balance(arg0: &LpReferral) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_vault)
    }

    fun verify_signature(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) : (address, u64, u64, u64) {
        let v0 = 0x2::bcs::new(*arg1);
        assert!(0x2::ed25519::ed25519_verify(arg2, arg1, arg0), 2);
        (0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    public fun withdraw_sui(arg0: &mut LpReferral, arg1: u64, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg1 > 0, 3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_vault) >= arg1, 1);
        let v0 = WithdrawEvent{
            admin  : 0x2::tx_context::sender(arg3),
            amount : arg1,
        };
        0x2::event::emit<WithdrawEvent>(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_vault, arg1), arg3)
    }

    // decompiled from Move bytecode v6
}

