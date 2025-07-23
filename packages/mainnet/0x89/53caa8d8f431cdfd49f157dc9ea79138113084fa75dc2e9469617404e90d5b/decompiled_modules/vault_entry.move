module 0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::vault_entry {
    public entry fun destroy_empty<T0>(arg0: 0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::vault::Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::vault::destroy_empty<T0>(arg0, arg1);
    }

    public entry fun deposit<T0>(arg0: &mut 0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::vault::Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::vault::deposit<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun withdraw<T0>(arg0: &mut 0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::vault::Vault<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::vault::withdraw<T0>(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_all<T0>(arg0: &mut 0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::vault::Vault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::vault::withdraw_all<T0>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun create<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::vault::Vault<T0>>(0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::vault::create_vault<T0>(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun extend_lock<T0>(arg0: &mut 0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::vault::Vault<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::vault::extend_lock_duration<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

