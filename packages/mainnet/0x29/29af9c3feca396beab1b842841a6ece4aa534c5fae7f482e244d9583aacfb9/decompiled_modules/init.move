module 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::init {
    public fun initialize<T0, T1>(arg0: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::version::Version, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : (0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::vault::Vault<T0, T1>, 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::vault::OwnerKey) {
        0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::vault::initialize<T0, T1>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

