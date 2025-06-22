module 0xf036f6dbc51890486b88955f08441b45b28a6ed34405201a11c863bb51eb49bf::dex_kriya {
    struct KriyaSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        fee_tier: u64,
        method: vector<u8>,
        package: address,
        timestamp: u64,
    }

    public fun get_kriya_amm_contract() : address {
        0xf036f6dbc51890486b88955f08441b45b28a6ed34405201a11c863bb51eb49bf::constants::kriya_amm_contract()
    }

    public fun get_kriya_package() : address {
        0xf036f6dbc51890486b88955f08441b45b28a6ed34405201a11c863bb51eb49bf::constants::kriya_package()
    }

    public fun validate_sui_usdc_swap(arg0: u64, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : bool {
        assert!(arg0 > 0, 5001);
        assert!(arg1 > 0, 5002);
        assert!(arg2 != @0x0, 5003);
        let v0 = KriyaSwapExecuted{
            sender         : 0x2::tx_context::sender(arg4),
            amount_in      : arg0,
            min_amount_out : arg1,
            pool_id        : arg2,
            fee_tier       : 300,
            method         : b"ptb_validation_call",
            package        : 0xf036f6dbc51890486b88955f08441b45b28a6ed34405201a11c863bb51eb49bf::constants::kriya_package(),
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<KriyaSwapExecuted>(v0);
        true
    }

    // decompiled from Move bytecode v6
}

