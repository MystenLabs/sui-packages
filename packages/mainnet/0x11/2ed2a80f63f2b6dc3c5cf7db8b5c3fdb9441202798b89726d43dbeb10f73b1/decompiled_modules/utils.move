module 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::utils {
    public fun check_amount<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::error::slippage_too_little_input());
    }

    public fun get_balance<T0>(arg0: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::account::TraderAccount, arg1: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::account::assert_owner(arg0, arg3);
        0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::assert_status<T0>(arg1);
        assert!(arg2 > 0, 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::error::is_zero());
        0x2::coin::into_balance<T0>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::withdraw<T0>(arg1, arg2, arg3))
    }

    public fun get_coin<T0>(arg0: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::account::TraderAccount, arg1: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::account::assert_owner(arg0, arg3);
        0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::assert_status<T0>(arg1);
        assert!(arg2 > 0, 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::error::is_zero());
        0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::withdraw<T0>(arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

