module 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::contract_depositor_demo {
    struct Depositor<phantom T0> has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        cap: 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::VaultDepositCap<T0>,
        deposits_made: u64,
    }

    public fun new<T0>(arg0: 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::VaultDepositCap<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : Depositor<T0> {
        Depositor<T0>{
            id            : 0x2::object::new(arg2),
            vault_id      : arg1,
            cap           : arg0,
            deposits_made : 0,
        }
    }

    public fun deposit_for_user<T0>(arg0: &mut Depositor<T0>, arg1: &mut 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::Vault<T0>, arg2: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::LotusConfig, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::VaultShare<T0> {
        assert!(arg0.vault_id == 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::id<T0>(arg1), 0);
        arg0.deposits_made = arg0.deposits_made + 1;
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::deposit_with_cap<T0>(arg1, arg2, &arg0.cap, arg3, arg4, arg5, arg6)
    }

    public fun deposits_made<T0>(arg0: &Depositor<T0>) : u64 {
        arg0.deposits_made
    }

    public fun share<T0>(arg0: Depositor<T0>) {
        0x2::transfer::share_object<Depositor<T0>>(arg0);
    }

    // decompiled from Move bytecode v7
}

