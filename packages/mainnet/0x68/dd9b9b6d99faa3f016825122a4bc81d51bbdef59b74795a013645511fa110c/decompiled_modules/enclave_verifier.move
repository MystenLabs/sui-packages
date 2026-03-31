module 0x68dd9b9b6d99faa3f016825122a4bc81d51bbdef59b74795a013645511fa110c::enclave_verifier {
    struct EnclaveRegistry has key {
        id: 0x2::object::UID,
        trusted_public_key: vector<u8>,
    }

    struct EnclaveKeyUpdatedEvent has copy, drop {
        old_key: vector<u8>,
        new_key: vector<u8>,
    }

    struct EnclavePayload has copy, drop {
        strategy_id: u8,
        apy: u64,
        tvl: u64,
        timestamp_ms: u64,
    }

    struct WithdrawPayload has copy, drop {
        strategy_id: u8,
        expected_usdc: u64,
        expected_harvest_usdc: u64,
        timestamp_ms: u64,
    }

    struct YieldPayload has copy, drop {
        strategy_id: u8,
        asset_amount: u64,
        timestamp_ms: u64,
    }

    public fun create_registry(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = EnclaveRegistry{
            id                 : 0x2::object::new(arg1),
            trusted_public_key : arg0,
        };
        0x2::transfer::share_object<EnclaveRegistry>(v0);
    }

    public fun get_apy(arg0: &EnclavePayload) : u64 {
        arg0.apy
    }

    public fun get_strategy_id(arg0: &EnclavePayload) : u8 {
        arg0.strategy_id
    }

    public fun get_timestamp_ms(arg0: &EnclavePayload) : u64 {
        arg0.timestamp_ms
    }

    public fun get_tvl(arg0: &EnclavePayload) : u64 {
        arg0.tvl
    }

    public fun get_withdraw_expected_harvest_usdc(arg0: &WithdrawPayload) : u64 {
        arg0.expected_harvest_usdc
    }

    public fun get_withdraw_expected_usdc(arg0: &WithdrawPayload) : u64 {
        arg0.expected_usdc
    }

    public fun get_withdraw_strategy_id(arg0: &WithdrawPayload) : u8 {
        arg0.strategy_id
    }

    public fun get_withdraw_timestamp_ms(arg0: &WithdrawPayload) : u64 {
        arg0.timestamp_ms
    }

    public fun get_yield_asset_amount(arg0: &YieldPayload) : u64 {
        arg0.asset_amount
    }

    public fun get_yield_strategy_id(arg0: &YieldPayload) : u8 {
        arg0.strategy_id
    }

    public fun get_yield_timestamp_ms(arg0: &YieldPayload) : u64 {
        arg0.timestamp_ms
    }

    public fun update_trusted_key(arg0: &0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::AdminCap, arg1: &mut EnclaveRegistry, arg2: vector<u8>) {
        arg1.trusted_public_key = arg2;
        let v0 = EnclaveKeyUpdatedEvent{
            old_key : arg1.trusted_public_key,
            new_key : arg2,
        };
        0x2::event::emit<EnclaveKeyUpdatedEvent>(v0);
    }

    public fun verify_and_decode(arg0: &EnclaveRegistry, arg1: vector<u8>, arg2: vector<u8>) : EnclavePayload {
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg0.trusted_public_key, &arg1), 600);
        let v0 = 0x2::bcs::new(arg1);
        EnclavePayload{
            strategy_id  : 0x2::bcs::peel_u8(&mut v0),
            apy          : 0x2::bcs::peel_u64(&mut v0),
            tvl          : 0x2::bcs::peel_u64(&mut v0),
            timestamp_ms : 0x2::bcs::peel_u64(&mut v0),
        }
    }

    public fun verify_and_decode_withdraw(arg0: &EnclaveRegistry, arg1: vector<u8>, arg2: vector<u8>) : WithdrawPayload {
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg0.trusted_public_key, &arg1), 600);
        let v0 = 0x2::bcs::new(arg1);
        WithdrawPayload{
            strategy_id           : 0x2::bcs::peel_u8(&mut v0),
            expected_usdc         : 0x2::bcs::peel_u64(&mut v0),
            expected_harvest_usdc : 0x2::bcs::peel_u64(&mut v0),
            timestamp_ms          : 0x2::bcs::peel_u64(&mut v0),
        }
    }

    public fun verify_and_decode_yield_receipt(arg0: &EnclaveRegistry, arg1: vector<u8>, arg2: vector<u8>) : YieldPayload {
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg0.trusted_public_key, &arg1), 600);
        let v0 = 0x2::bcs::new(arg1);
        YieldPayload{
            strategy_id  : 0x2::bcs::peel_u8(&mut v0),
            asset_amount : 0x2::bcs::peel_u64(&mut v0),
            timestamp_ms : 0x2::bcs::peel_u64(&mut v0),
        }
    }

    // decompiled from Move bytecode v6
}

