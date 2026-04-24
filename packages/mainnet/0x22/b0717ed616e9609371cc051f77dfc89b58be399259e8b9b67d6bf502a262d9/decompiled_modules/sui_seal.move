module 0x22b0717ed616e9609371cc051f77dfc89b58be399259e8b9b67d6bf502a262d9::sui_seal {
    struct SealedTradeIntent has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        leader: address,
        encrypted_data: vector<u8>,
        decrypt_after: u64,
        expires_at: u64,
        executed: bool,
        created_at: u64,
    }

    struct TradeIntentSealed has copy, drop {
        vault_id: 0x2::object::ID,
        intent_id: 0x2::object::ID,
        leader: address,
        decrypt_after: u64,
        expires_at: u64,
    }

    struct TradeIntentRevealed has copy, drop {
        vault_id: 0x2::object::ID,
        intent_id: 0x2::object::ID,
    }

    struct TradeIntentExecuted has copy, drop {
        vault_id: 0x2::object::ID,
        intent_id: 0x2::object::ID,
    }

    public fun create_sealed_intent<T0>(arg0: &0x22b0717ed616e9609371cc051f77dfc89b58be399259e8b9b67d6bf502a262d9::sui_vault::SuiVault<T0>, arg1: &0x22b0717ed616e9609371cc051f77dfc89b58be399259e8b9b67d6bf502a262d9::sui_vault::SuiLeaderCap, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::id<0x22b0717ed616e9609371cc051f77dfc89b58be399259e8b9b67d6bf502a262d9::sui_vault::SuiVault<T0>>(arg0);
        assert!(0x22b0717ed616e9609371cc051f77dfc89b58be399259e8b9b67d6bf502a262d9::sui_vault::leader_cap_vault_id(arg1) == v0, 200);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg3 > v1, 202);
        let v2 = SealedTradeIntent{
            id             : 0x2::object::new(arg6),
            vault_id       : v0,
            leader         : 0x2::tx_context::sender(arg6),
            encrypted_data : arg2,
            decrypt_after  : arg3,
            expires_at     : arg3 + arg4,
            executed       : false,
            created_at     : v1,
        };
        let v3 = 0x2::object::id<SealedTradeIntent>(&v2);
        let v4 = TradeIntentSealed{
            vault_id      : v0,
            intent_id     : v3,
            leader        : 0x2::tx_context::sender(arg6),
            decrypt_after : arg3,
            expires_at    : arg3 + arg4,
        };
        0x2::event::emit<TradeIntentSealed>(v4);
        0x2::transfer::share_object<SealedTradeIntent>(v2);
        v3
    }

    public fun intent_decrypt_after(arg0: &SealedTradeIntent) : u64 {
        arg0.decrypt_after
    }

    public fun intent_encrypted_data(arg0: &SealedTradeIntent) : &vector<u8> {
        &arg0.encrypted_data
    }

    public fun intent_executed(arg0: &SealedTradeIntent) : bool {
        arg0.executed
    }

    public fun intent_expires_at(arg0: &SealedTradeIntent) : u64 {
        arg0.expires_at
    }

    public fun intent_leader(arg0: &SealedTradeIntent) : address {
        arg0.leader
    }

    public fun intent_vault_id(arg0: &SealedTradeIntent) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun mark_intent_executed<T0>(arg0: &0x22b0717ed616e9609371cc051f77dfc89b58be399259e8b9b67d6bf502a262d9::sui_vault::SuiVault<T0>, arg1: &0x22b0717ed616e9609371cc051f77dfc89b58be399259e8b9b67d6bf502a262d9::sui_vault::SuiLeaderCap, arg2: &mut SealedTradeIntent, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<0x22b0717ed616e9609371cc051f77dfc89b58be399259e8b9b67d6bf502a262d9::sui_vault::SuiVault<T0>>(arg0);
        assert!(0x22b0717ed616e9609371cc051f77dfc89b58be399259e8b9b67d6bf502a262d9::sui_vault::leader_cap_vault_id(arg1) == v0, 200);
        assert!(arg2.vault_id == v0, 200);
        assert!(!arg2.executed, 203);
        assert!(0x2::clock::timestamp_ms(arg3) <= arg2.expires_at, 204);
        arg2.executed = true;
        let v1 = TradeIntentExecuted{
            vault_id  : v0,
            intent_id : 0x2::object::id<SealedTradeIntent>(arg2),
        };
        0x2::event::emit<TradeIntentExecuted>(v1);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 202);
        assert!(0x2::clock::timestamp_ms(arg1) >= 0x2::bcs::peel_u64(&mut v0), 201);
    }

    entry fun seal_approve_vault_member<T0>(arg0: vector<u8>, arg1: &0x22b0717ed616e9609371cc051f77dfc89b58be399259e8b9b67d6bf502a262d9::sui_vault::SuiVault<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 202);
        let v2 = 0x2::object::id<0x22b0717ed616e9609371cc051f77dfc89b58be399259e8b9b67d6bf502a262d9::sui_vault::SuiVault<T0>>(arg1);
        assert!(0x2::object::id_to_address(&v2) == 0x2::bcs::peel_address(&mut v0), 200);
        assert!(0x2::clock::timestamp_ms(arg2) >= 0x2::bcs::peel_u64(&mut v0), 201);
    }

    // decompiled from Move bytecode v6
}

