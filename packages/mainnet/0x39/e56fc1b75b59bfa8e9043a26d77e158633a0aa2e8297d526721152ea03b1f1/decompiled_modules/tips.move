module 0x39e56fc1b75b59bfa8e9043a26d77e158633a0aa2e8297d526721152ea03b1f1::tips {
    struct TipSent has copy, drop {
        tipper: address,
        creator: address,
        amount: u64,
        fee: u64,
    }

    entry fun tip_creator(arg0: &0x39e56fc1b75b59bfa8e9043a26d77e158633a0aa2e8297d526721152ea03b1f1::platform::PlatformConfig, arg1: &mut 0x39e56fc1b75b59bfa8e9043a26d77e158633a0aa2e8297d526721152ea03b1f1::platform::PlatformTreasury, arg2: &mut 0x39e56fc1b75b59bfa8e9043a26d77e158633a0aa2e8297d526721152ea03b1f1::creator_treasury::CreatorTreasury, arg3: address, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x39e56fc1b75b59bfa8e9043a26d77e158633a0aa2e8297d526721152ea03b1f1::platform::is_paused(arg0), 1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        assert!(v0 > 0, 2);
        let v1 = v0 * 0x39e56fc1b75b59bfa8e9043a26d77e158633a0aa2e8297d526721152ea03b1f1::platform::tip_fee_bps(arg0) / 10000;
        if (v1 > 0) {
            0x39e56fc1b75b59bfa8e9043a26d77e158633a0aa2e8297d526721152ea03b1f1::platform::deposit_sui(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut arg4, v1, arg5));
        };
        0x39e56fc1b75b59bfa8e9043a26d77e158633a0aa2e8297d526721152ea03b1f1::creator_treasury::deposit_sui(arg2, arg4);
        let v2 = TipSent{
            tipper  : 0x2::tx_context::sender(arg5),
            creator : arg3,
            amount  : v0,
            fee     : v1,
        };
        0x2::event::emit<TipSent>(v2);
    }

    // decompiled from Move bytecode v6
}

