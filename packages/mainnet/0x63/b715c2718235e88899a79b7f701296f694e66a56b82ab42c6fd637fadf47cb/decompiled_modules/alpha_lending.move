module 0x63b715c2718235e88899a79b7f701296f694e66a56b82ab42c6fd637fadf47cb::alpha_lending {
    struct LendingProtocol has store, key {
        id: 0x2::object::UID,
        dummy: vector<u8>,
    }

    struct Promise {
        dummy: bool,
    }

    public fun add_collateral<T0>(arg0: &mut LendingProtocol, arg1: &mut 0x63b715c2718235e88899a79b7f701296f694e66a56b82ab42c6fd637fadf47cb::position::PositionCap, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun create_dummy_promise() : Promise {
        Promise{dummy: true}
    }

    public fun fulfill_promise<T0>(arg0: &mut LendingProtocol, arg1: Promise, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 0
    }

    public fun remove_collateral<T0>(arg0: &mut LendingProtocol, arg1: &mut 0x63b715c2718235e88899a79b7f701296f694e66a56b82ab42c6fd637fadf47cb::position::PositionCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Promise {
        abort 0
    }

    // decompiled from Move bytecode v6
}

