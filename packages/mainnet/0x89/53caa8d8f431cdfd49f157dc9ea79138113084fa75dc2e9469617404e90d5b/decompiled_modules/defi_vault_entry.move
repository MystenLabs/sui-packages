module 0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_vault_entry {
    public entry fun destroy_empty<T0>(arg0: 0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_vault::DeFiVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_vault::destroy_empty<T0>(arg0);
    }

    public entry fun create_defi_vault_sui(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u8, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_vault::DeFiVault<0x2::sui::SUI>>(0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_vault::create_defi_vault_sui(arg0, arg1, arg2, arg3, arg4, arg5), 0x2::tx_context::sender(arg5));
    }

    public entry fun withdraw<T0>(arg0: &mut 0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_vault::DeFiVault<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_vault::withdraw<T0>(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_sui(arg0: &mut 0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_vault::DeFiVault<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_vault::withdraw_sui(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_all<T0>(arg0: &mut 0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_vault::DeFiVault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_vault::total_balance<T0>(arg0);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_vault::withdraw<T0>(arg0, v0, arg1, arg2), 0x2::tx_context::sender(arg2));
        };
    }

    public entry fun withdraw_all_sui(arg0: &mut 0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_vault::DeFiVault<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_vault::total_balance<0x2::sui::SUI>(arg0);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_vault::withdraw_sui(arg0, v0, arg1, arg2), 0x2::tx_context::sender(arg2));
        };
    }

    // decompiled from Move bytecode v6
}

