module 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_kriya_real {
    struct RealKriyaSwapExecuted has copy, drop {
        pool: address,
        amount_in: u64,
        amount_out: u64,
        success: bool,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
    }

    public fun get_kriya_pool_info() : (address, address) {
        (@0x5eb2dfcdd1b15d2021328258f6d5ec081e9a0cdcfa9e13a0eaeb9b5f7505ca78, @0x18d871e3c3da99046dfc0d3de612c5d88859bc03b8f0568bd127d0e70dbc58be)
    }

    public fun get_quote_real(arg0: address, arg1: u64, arg2: bool) : u64 {
        arg1 - arg1 * 30 / 10000
    }

    public fun prepare_kriya_swap<T0, T1>(arg0: u64, arg1: bool) : (address, address, u64, bool) {
        (@0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66, @0x18d871e3c3da99046dfc0d3de612c5d88859bc03b8f0568bd127d0e70dbc58be, arg0, arg1)
    }

    public fun swap_real<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 602);
        let v1 = RealKriyaSwapExecuted{
            pool       : arg0,
            amount_in  : v0,
            amount_out : arg2,
            success    : false,
        };
        0x2::event::emit<RealKriyaSwapExecuted>(v1);
        0x2::coin::destroy_zero<T0>(arg1);
        0x2::coin::zero<T1>(arg4)
    }

    // decompiled from Move bytecode v6
}

