module 0x7d9e2326f429527b6fbadd0e2b19546878521bd23d5439214f2652a48de1e86f::settlement {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TreasuryConfig has key {
        id: 0x2::object::UID,
        treasury: address,
        update_count: u64,
    }

    struct SettlementEvent has copy, drop {
        intent_id: 0x2::object::ID,
        buyer: address,
        provider: address,
        amount_paid: u64,
        toll: u64,
        refunded: u64,
        audit_hash: vector<u8>,
        settled_at: u64,
    }

    struct TreasuryUpdated has copy, drop {
        old_treasury: address,
        new_treasury: address,
        update_count: u64,
    }

    fun build_settlement_message(arg0: 0x2::object::ID, arg1: u64, arg2: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, *arg2);
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun init_treasury(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = TreasuryConfig{
            id           : 0x2::object::new(arg2),
            treasury     : arg1,
            update_count : 0,
        };
        0x2::transfer::share_object<TreasuryConfig>(v0);
    }

    public entry fun settle(arg0: &mut 0x7d9e2326f429527b6fbadd0e2b19546878521bd23d5439214f2652a48de1e86f::intent::Intent, arg1: &mut 0x7d9e2326f429527b6fbadd0e2b19546878521bd23d5439214f2652a48de1e86f::intent::DIDState, arg2: &TreasuryConfig, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x7d9e2326f429527b6fbadd0e2b19546878521bd23d5439214f2652a48de1e86f::intent::state(arg0) == 0x7d9e2326f429527b6fbadd0e2b19546878521bd23d5439214f2652a48de1e86f::intent::state_fulfilled(), 6);
        assert!(0x2::clock::timestamp_ms(arg5) < 0x7d9e2326f429527b6fbadd0e2b19546878521bd23d5439214f2652a48de1e86f::intent::expires_at(arg0), 7);
        assert!(!0x1::vector::is_empty<u8>(&arg4), 15);
        let v0 = build_settlement_message(0x2::object::id<0x7d9e2326f429527b6fbadd0e2b19546878521bd23d5439214f2652a48de1e86f::intent::Intent>(arg0), 0x7d9e2326f429527b6fbadd0e2b19546878521bd23d5439214f2652a48de1e86f::intent::bid_amount(arg0), &arg4);
        let v1 = 0x7d9e2326f429527b6fbadd0e2b19546878521bd23d5439214f2652a48de1e86f::intent::evaluator(arg0);
        assert!(0x2::ed25519::ed25519_verify(&arg3, &v1, &v0), 13);
        let v2 = 0x7d9e2326f429527b6fbadd0e2b19546878521bd23d5439214f2652a48de1e86f::intent::bid_amount(arg0) * 10 / 10000;
        let (v3, v4, v5, v6) = 0x7d9e2326f429527b6fbadd0e2b19546878521bd23d5439214f2652a48de1e86f::intent::settle_escrow(arg0, arg4, arg6);
        let v7 = v4;
        let v8 = v3;
        let v9 = 0x2::coin::value<0x7d9e2326f429527b6fbadd0e2b19546878521bd23d5439214f2652a48de1e86f::intent::USDC>(&v7);
        0x7d9e2326f429527b6fbadd0e2b19546878521bd23d5439214f2652a48de1e86f::intent::decrement_open(arg1);
        0x7d9e2326f429527b6fbadd0e2b19546878521bd23d5439214f2652a48de1e86f::intent::increment_settled(arg1);
        let v10 = SettlementEvent{
            intent_id   : 0x2::object::id<0x7d9e2326f429527b6fbadd0e2b19546878521bd23d5439214f2652a48de1e86f::intent::Intent>(arg0),
            buyer       : v6,
            provider    : v5,
            amount_paid : 0x2::coin::value<0x7d9e2326f429527b6fbadd0e2b19546878521bd23d5439214f2652a48de1e86f::intent::USDC>(&v8),
            toll        : v2,
            refunded    : v9,
            audit_hash  : *0x7d9e2326f429527b6fbadd0e2b19546878521bd23d5439214f2652a48de1e86f::intent::audit_hash_ref(arg0),
            settled_at  : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<SettlementEvent>(v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7d9e2326f429527b6fbadd0e2b19546878521bd23d5439214f2652a48de1e86f::intent::USDC>>(0x2::coin::split<0x7d9e2326f429527b6fbadd0e2b19546878521bd23d5439214f2652a48de1e86f::intent::USDC>(&mut v8, v2, arg6), arg2.treasury);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7d9e2326f429527b6fbadd0e2b19546878521bd23d5439214f2652a48de1e86f::intent::USDC>>(v8, v5);
        if (v9 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x7d9e2326f429527b6fbadd0e2b19546878521bd23d5439214f2652a48de1e86f::intent::USDC>>(v7, v6);
        } else {
            0x2::coin::destroy_zero<0x7d9e2326f429527b6fbadd0e2b19546878521bd23d5439214f2652a48de1e86f::intent::USDC>(v7);
        };
    }

    public fun treasury_address(arg0: &TreasuryConfig) : address {
        arg0.treasury
    }

    public fun treasury_update_count(arg0: &TreasuryConfig) : u64 {
        arg0.update_count
    }

    public entry fun update_treasury(arg0: &AdminCap, arg1: &mut TreasuryConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.treasury = arg2;
        arg1.update_count = arg1.update_count + 1;
        let v0 = TreasuryUpdated{
            old_treasury : arg1.treasury,
            new_treasury : arg2,
            update_count : arg1.update_count,
        };
        0x2::event::emit<TreasuryUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

