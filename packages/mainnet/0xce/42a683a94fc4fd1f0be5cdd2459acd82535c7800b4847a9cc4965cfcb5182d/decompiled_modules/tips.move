module 0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::tips {
    struct TipSent has copy, drop {
        from: address,
        to_creator: address,
        amount: u64,
        platform_fee: u64,
    }

    entry fun tip_creator(arg0: &0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::PlatformConfig, arg1: &mut 0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::PlatformTreasury, arg2: &mut 0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::creator_treasury::CreatorTreasury, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::is_paused(arg0), 1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v0 > 0, 1);
        let v1 = v0 * 0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::tip_fee_bps(arg0) / 10000;
        if (v1 > 0) {
            0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::deposit_usde(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut arg3, v1, arg4));
        };
        0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::creator_treasury::deposit_usde(arg2, arg3);
        let v2 = TipSent{
            from         : 0x2::tx_context::sender(arg4),
            to_creator   : 0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::creator_treasury::owner(arg2),
            amount       : v0,
            platform_fee : v1,
        };
        0x2::event::emit<TipSent>(v2);
    }

    // decompiled from Move bytecode v6
}

