module 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::admin {
    entry fun migrate(arg0: &0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::package::PackageAdminCap, arg1: &mut 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::lucky_bag::DrawConfig, arg2: &mut 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::treasury::Treasury, arg3: &mut 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::fu::FuMinter, arg4: &mut 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::fu::FuFontConfig) {
        0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::lucky_bag::migrate(arg1);
        0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::treasury::migrate(arg2);
        0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::fu::migrate(arg3, arg4);
        0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::package::emit_migrate_event();
    }

    entry fun set_draw_price(arg0: &0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::treasury::TreasuryAdminCap, arg1: &mut 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::lucky_bag::DrawConfig, arg2: u64) {
        0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::lucky_bag::set_price(arg1, arg2);
    }

    entry fun view_treasury_balance(arg0: &0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::treasury::Treasury) : u64 {
        0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::treasury::balance(arg0)
    }

    entry fun withdraw_from_treasury(arg0: &0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::treasury::TreasuryAdminCap, arg1: &mut 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::treasury::Treasury, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::treasury::balance(arg1) >= arg2, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::treasury::withdraw(arg0, arg1, arg2, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

