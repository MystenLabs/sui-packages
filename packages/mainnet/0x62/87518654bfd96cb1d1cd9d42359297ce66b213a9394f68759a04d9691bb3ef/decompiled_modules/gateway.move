module 0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::gateway {
    public fun swap<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::vault::Vault, arg2: &0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::ProtocolConfig, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::vault::swap<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::into_balance<T0>(arg5), arg6), arg6), 0x2::tx_context::sender(arg6));
    }

    entry fun increase_supported_package_version(arg0: &0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::AdminCap, arg1: &mut 0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::ProtocolConfig) {
        0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::increase_supported_package_version(arg0, arg1);
    }

    entry fun set_protocol_fee_recipient(arg0: &0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::AdminCap, arg1: &mut 0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::ProtocolConfig, arg2: address) {
        0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::set_protocol_fee_recipient(arg0, arg1, arg2);
    }

    entry fun transfer_admin_cap(arg0: 0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::AdminCap, arg1: &0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::ProtocolConfig, arg2: address) {
        0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::transfer_admin_cap(arg0, arg1, arg2);
    }

    entry fun update_default_protocol_fee_percentage(arg0: &0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::AdminCap, arg1: &mut 0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::ProtocolConfig, arg2: u64) {
        0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::update_default_protocol_fee_percentage(arg0, arg1, arg2);
    }

    entry fun claim_protocol_fee<T0>(arg0: &mut 0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::vault::Vault, arg1: &0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::ProtocolConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::vault::claim_protocol_fee<T0>(arg0, arg1, arg2);
    }

    entry fun create_rfq_vault(arg0: &0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::ProtocolConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::vault::create_rfq_vault(arg0, arg1, arg2);
    }

    entry fun deposit<T0>(arg0: &mut 0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::vault::Vault, arg1: &0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::ProtocolConfig, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::vault::deposit<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), arg3);
    }

    entry fun set_manager(arg0: &mut 0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::vault::Vault, arg1: &0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::ProtocolConfig, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::vault::set_manager(arg0, arg1, arg2, arg3);
    }

    entry fun support_coin<T0>(arg0: &mut 0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::vault::Vault, arg1: &0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::vault::support_coin<T0>(arg0, arg1, arg2, arg3);
    }

    entry fun update_min_deposit<T0>(arg0: &mut 0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::vault::Vault, arg1: &0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::vault::update_min_deposit<T0>(arg0, arg1, arg2, arg3);
    }

    public fun withdraw<T0>(arg0: &mut 0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::vault::Vault, arg1: &0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::ProtocolConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::vault::withdraw<T0>(arg0, arg1, arg2, arg3), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

