module 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::breaker {
    public entry fun toggle_claim_v2(arg0: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::manage::ACL, arg1: &mut 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::manage::is_breaker(arg0, 0x2::tx_context::sender(arg3)), 1);
        0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::assert_version(arg1);
        0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::toggle_claim(arg1, arg2);
    }

    public entry fun toggle_unstake_v2(arg0: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::manage::ACL, arg1: &mut 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::manage::is_breaker(arg0, 0x2::tx_context::sender(arg3)), 1);
        0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::assert_version(arg1);
        0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::toggle_unstake(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

