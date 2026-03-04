module 0x117f8bfdde26b5ece4fd88b0afa862468e2bf7106563b1033edcc1037734901::vault_entry {
    public entry fun destroy_empty<T0>(arg0: 0x117f8bfdde26b5ece4fd88b0afa862468e2bf7106563b1033edcc1037734901::vault::Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x117f8bfdde26b5ece4fd88b0afa862468e2bf7106563b1033edcc1037734901::vault::destroy_empty<T0>(arg0, arg1);
    }

    public entry fun deposit<T0>(arg0: &mut 0x117f8bfdde26b5ece4fd88b0afa862468e2bf7106563b1033edcc1037734901::vault::Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x117f8bfdde26b5ece4fd88b0afa862468e2bf7106563b1033edcc1037734901::vault::deposit<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun withdraw<T0>(arg0: &mut 0x117f8bfdde26b5ece4fd88b0afa862468e2bf7106563b1033edcc1037734901::vault::Vault<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x117f8bfdde26b5ece4fd88b0afa862468e2bf7106563b1033edcc1037734901::vault::withdraw<T0>(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_all<T0>(arg0: &mut 0x117f8bfdde26b5ece4fd88b0afa862468e2bf7106563b1033edcc1037734901::vault::Vault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x117f8bfdde26b5ece4fd88b0afa862468e2bf7106563b1033edcc1037734901::vault::withdraw_all<T0>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun create<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x117f8bfdde26b5ece4fd88b0afa862468e2bf7106563b1033edcc1037734901::vault::Vault<T0>>(0x117f8bfdde26b5ece4fd88b0afa862468e2bf7106563b1033edcc1037734901::vault::create_vault<T0>(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun extend_lock<T0>(arg0: &mut 0x117f8bfdde26b5ece4fd88b0afa862468e2bf7106563b1033edcc1037734901::vault::Vault<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x117f8bfdde26b5ece4fd88b0afa862468e2bf7106563b1033edcc1037734901::vault::extend_lock_duration<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

