module 0x6c432b21ce4922c83365b18134715b7aae02577c38d9cf7d2368670a1692dd97::penalty_treasury {
    struct PenaltyTreasuryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PenaltyTreasuryCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PenaltyTreasury has key {
        id: 0x2::object::UID,
        version: u64,
        pool_id: 0x2::object::ID,
        balance: 0x2::balance::Balance<0x6c432b21ce4922c83365b18134715b7aae02577c38d9cf7d2368670a1692dd97::parchment::PARCHMENT>,
        total_deposited: u64,
        total_withdrawn: u64,
    }

    struct PenaltyTreasuryCap has key {
        id: 0x2::object::UID,
        treasury_id: 0x2::object::ID,
    }

    public fun balance(arg0: &PenaltyTreasury) : u64 {
        0x2::balance::value<0x6c432b21ce4922c83365b18134715b7aae02577c38d9cf7d2368670a1692dd97::parchment::PARCHMENT>(&arg0.balance)
    }

    fun assert_version(arg0: &PenaltyTreasury) {
        assert!(arg0.version == 2, 13835058738181963777);
    }

    public fun cap_treasury_id(arg0: &PenaltyTreasuryCap) : 0x2::object::ID {
        arg0.treasury_id
    }

    public(friend) fun create_and_share(arg0: &mut 0x2::object::UID, arg1: 0x2::balance::Balance<0x6c432b21ce4922c83365b18134715b7aae02577c38d9cf7d2368670a1692dd97::parchment::PARCHMENT>, arg2: address) : 0x2::object::ID {
        let v0 = PenaltyTreasuryKey{dummy_field: false};
        assert!(!0x2::derived_object::exists<PenaltyTreasuryKey>(arg0, v0), 13836465747993952267);
        let v1 = 0x2::object::uid_to_inner(arg0);
        let v2 = PenaltyTreasuryKey{dummy_field: false};
        let v3 = PenaltyTreasury{
            id              : 0x2::derived_object::claim<PenaltyTreasuryKey>(arg0, v2),
            version         : 2,
            pool_id         : v1,
            balance         : 0x2::balance::zero<0x6c432b21ce4922c83365b18134715b7aae02577c38d9cf7d2368670a1692dd97::parchment::PARCHMENT>(),
            total_deposited : 0,
            total_withdrawn : 0,
        };
        let v4 = 0x2::object::id<PenaltyTreasury>(&v3);
        let v5 = PenaltyTreasuryCapKey{dummy_field: false};
        let v6 = PenaltyTreasuryCap{
            id          : 0x2::derived_object::claim<PenaltyTreasuryCapKey>(&mut v3.id, v5),
            treasury_id : v4,
        };
        0x6c432b21ce4922c83365b18134715b7aae02577c38d9cf7d2368670a1692dd97::events::emit_create_penalty_treasury_event(v4, v1, 0x2::object::id<PenaltyTreasuryCap>(&v6), arg2);
        let v7 = &mut v3;
        deposit(v7, arg1, 1);
        0x2::transfer::share_object<PenaltyTreasury>(v3);
        0x2::transfer::transfer<PenaltyTreasuryCap>(v6, arg2);
        v4
    }

    fun deposit(arg0: &mut PenaltyTreasury, arg1: 0x2::balance::Balance<0x6c432b21ce4922c83365b18134715b7aae02577c38d9cf7d2368670a1692dd97::parchment::PARCHMENT>, arg2: u8) {
        assert_version(arg0);
        let v0 = 0x2::balance::value<0x6c432b21ce4922c83365b18134715b7aae02577c38d9cf7d2368670a1692dd97::parchment::PARCHMENT>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<0x6c432b21ce4922c83365b18134715b7aae02577c38d9cf7d2368670a1692dd97::parchment::PARCHMENT>(arg1);
            return
        };
        0x2::balance::join<0x6c432b21ce4922c83365b18134715b7aae02577c38d9cf7d2368670a1692dd97::parchment::PARCHMENT>(&mut arg0.balance, arg1);
        arg0.total_deposited = arg0.total_deposited + v0;
        0x6c432b21ce4922c83365b18134715b7aae02577c38d9cf7d2368670a1692dd97::events::emit_deposit_penalty_treasury_event(0x2::object::id<PenaltyTreasury>(arg0), v0, arg2, 0x2::balance::value<0x6c432b21ce4922c83365b18134715b7aae02577c38d9cf7d2368670a1692dd97::parchment::PARCHMENT>(&arg0.balance));
    }

    public(friend) fun deposit_exit_penalty(arg0: &mut PenaltyTreasury, arg1: 0x2::balance::Balance<0x6c432b21ce4922c83365b18134715b7aae02577c38d9cf7d2368670a1692dd97::parchment::PARCHMENT>) {
        deposit(arg0, arg1, 0);
    }

    public(friend) fun derived_id(arg0: 0x2::object::ID) : 0x2::object::ID {
        let v0 = PenaltyTreasuryKey{dummy_field: false};
        0x2::object::id_from_address(0x2::derived_object::derive_address<PenaltyTreasuryKey>(arg0, v0))
    }

    public(friend) fun exists_for(arg0: &0x2::object::UID) : bool {
        let v0 = PenaltyTreasuryKey{dummy_field: false};
        0x2::derived_object::exists<PenaltyTreasuryKey>(arg0, v0)
    }

    public fun pool_id(arg0: &PenaltyTreasury) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun total_deposited(arg0: &PenaltyTreasury) : u64 {
        arg0.total_deposited
    }

    public fun total_withdrawn(arg0: &PenaltyTreasury) : u64 {
        arg0.total_withdrawn
    }

    entry fun transfer_cap(arg0: PenaltyTreasuryCap, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 13836184539305082889);
        0x6c432b21ce4922c83365b18134715b7aae02577c38d9cf7d2368670a1692dd97::events::emit_transfer_penalty_treasury_cap_event(arg0.treasury_id, 0x2::object::id<PenaltyTreasuryCap>(&arg0), 0x2::tx_context::sender(arg2), arg1);
        0x2::transfer::transfer<PenaltyTreasuryCap>(arg0, arg1);
    }

    public fun version(arg0: &PenaltyTreasury) : u64 {
        arg0.version
    }

    public fun withdraw(arg0: &mut PenaltyTreasury, arg1: &PenaltyTreasuryCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x6c432b21ce4922c83365b18134715b7aae02577c38d9cf7d2368670a1692dd97::parchment::PARCHMENT> {
        assert_version(arg0);
        assert!(arg1.treasury_id == 0x2::object::id<PenaltyTreasury>(arg0), 13835340058539982851);
        assert!(arg2 > 0, 13835621537811791877);
        assert!(arg2 <= 0x2::balance::value<0x6c432b21ce4922c83365b18134715b7aae02577c38d9cf7d2368670a1692dd97::parchment::PARCHMENT>(&arg0.balance), 13835903017083600903);
        arg0.total_withdrawn = arg0.total_withdrawn + arg2;
        0x6c432b21ce4922c83365b18134715b7aae02577c38d9cf7d2368670a1692dd97::events::emit_withdraw_penalty_treasury_event(0x2::object::id<PenaltyTreasury>(arg0), arg2, 0x2::tx_context::sender(arg3), 0x2::balance::value<0x6c432b21ce4922c83365b18134715b7aae02577c38d9cf7d2368670a1692dd97::parchment::PARCHMENT>(&arg0.balance));
        0x2::coin::from_balance<0x6c432b21ce4922c83365b18134715b7aae02577c38d9cf7d2368670a1692dd97::parchment::PARCHMENT>(0x2::balance::split<0x6c432b21ce4922c83365b18134715b7aae02577c38d9cf7d2368670a1692dd97::parchment::PARCHMENT>(&mut arg0.balance, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

