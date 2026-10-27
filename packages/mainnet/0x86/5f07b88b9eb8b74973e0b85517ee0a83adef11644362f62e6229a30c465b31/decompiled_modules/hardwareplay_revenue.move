module 0x865f07b88b9eb8b74973e0b85517ee0a83adef11644362f62e6229a30c465b31::hardwareplay_revenue {
    struct RevenueDistributed has copy, drop {
        event_id: 0x1::string::String,
        tag_id: 0x1::string::String,
        policy_id: 0x1::string::String,
        use_case: 0x1::string::String,
        currency: 0x1::string::String,
        gross_amount_minor: u64,
        owner_wallet: address,
        owner_amount_minor: u64,
        project_wallet: address,
        project_amount_minor: u64,
        operations_wallet: address,
        operations_amount_minor: u64,
        purpose_wallet: address,
        purpose_amount_minor: u64,
    }

    entry fun distribute(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: address, arg7: u64, arg8: address, arg9: u64, arg10: address, arg11: u64, arg12: address, arg13: u64) {
        assert!(arg7 + arg9 + arg11 + arg13 == arg5, 1);
        let v0 = RevenueDistributed{
            event_id                : arg0,
            tag_id                  : arg1,
            policy_id               : arg2,
            use_case                : arg3,
            currency                : arg4,
            gross_amount_minor      : arg5,
            owner_wallet            : arg6,
            owner_amount_minor      : arg7,
            project_wallet          : arg8,
            project_amount_minor    : arg9,
            operations_wallet       : arg10,
            operations_amount_minor : arg11,
            purpose_wallet          : arg12,
            purpose_amount_minor    : arg13,
        };
        0x2::event::emit<RevenueDistributed>(v0);
    }

    // decompiled from Move bytecode v7
}

