module 0xd50a32ae860628d7f941e2b00dcb993661b2b2c87c2e4c3c0141422bc358528e::defi_verifier {
    fun max(arg0: u8, arg1: u8) : u8 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun verify_defi_coin<T0>(arg0: &0x2::coin::Coin<T0>) : u8 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        max(0, 0xd50a32ae860628d7f941e2b00dcb993661b2b2c87c2e4c3c0141422bc358528e::scallop_checker::check(&v0, 0x2::coin::value<T0>(arg0)))
    }

    public fun verify_navi_any(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &0x2::tx_context::TxContext) : u8 {
        0xd50a32ae860628d7f941e2b00dcb993661b2b2c87c2e4c3c0141422bc358528e::navi_checker::check_any_asset(arg0, 0x2::tx_context::sender(arg1))
    }

    public fun verify_navi_usdc(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &0x2::tx_context::TxContext) : u8 {
        0xd50a32ae860628d7f941e2b00dcb993661b2b2c87c2e4c3c0141422bc358528e::navi_checker::check_usdc(arg0, 0x2::tx_context::sender(arg1))
    }

    // decompiled from Move bytecode v6
}

