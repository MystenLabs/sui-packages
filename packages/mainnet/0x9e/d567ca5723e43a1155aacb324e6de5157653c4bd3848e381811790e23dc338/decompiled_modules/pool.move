module 0x9ed567ca5723e43a1155aacb324e6de5157653c4bd3848e381811790e23dc338::pool {
    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
    }

    struct FlashSwapReceipt<phantom T0, phantom T1> {
        pool_id: 0x2::object::ID,
        a2b: bool,
        partner_id: 0x2::object::ID,
        pay_amount: u64,
        ref_fee_amount: u64,
    }

    public fun flash_swap<T0, T1>(arg0: &0x9ed567ca5723e43a1155aacb324e6de5157653c4bd3848e381811790e23dc338::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: bool, arg3: bool, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        abort 0
    }

    public fun repay_flash_swap<T0, T1>(arg0: &0x9ed567ca5723e43a1155aacb324e6de5157653c4bd3848e381811790e23dc338::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: FlashSwapReceipt<T0, T1>) {
        abort 0
    }

    // decompiled from Move bytecode v7
}

