module 0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::fee_collector {
    struct FeeCollector<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        fees: 0x2::balance::Balance<T0>,
    }

    public(friend) fun new<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : FeeCollector<T0> {
        FeeCollector<T0>{
            id      : 0x2::object::new(arg1),
            version : arg0,
            fees    : 0x2::balance::zero<T0>(),
        }
    }

    public(friend) fun add_fee<T0>(arg0: &mut FeeCollector<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::put<T0>(&mut arg0.fees, arg1);
    }

    public(friend) fun claim_fees<T0>(arg0: &mut FeeCollector<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg0.fees) >= arg1, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.fees, arg1, arg3), arg2);
    }

    public fun get_version<T0>(arg0: &FeeCollector<T0>) : u64 {
        arg0.version
    }

    public(friend) fun set_version<T0>(arg0: &mut FeeCollector<T0>, arg1: u64) {
        arg0.version = arg1;
    }

    // decompiled from Move bytecode v6
}

