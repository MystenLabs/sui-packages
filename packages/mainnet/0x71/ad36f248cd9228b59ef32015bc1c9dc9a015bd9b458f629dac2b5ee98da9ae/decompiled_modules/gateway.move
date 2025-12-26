module 0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::gateway {
    public fun swap<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::vault::Vault, arg2: &0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::config::ProtocolConfig, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::vault::swap<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::into_balance<T0>(arg5), arg6), arg6), 0x2::tx_context::sender(arg6));
    }

    entry fun increase_supported_package_version(arg0: &0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::config::AdminCap, arg1: &mut 0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::config::ProtocolConfig) {
        0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::config::increase_supported_package_version(arg0, arg1);
    }

    entry fun set_protocol_fee_recipient(arg0: &0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::config::AdminCap, arg1: &mut 0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::config::ProtocolConfig, arg2: address) {
        0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::config::set_protocol_fee_recipient(arg0, arg1, arg2);
    }

    entry fun transfer_admin_cap(arg0: 0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::config::AdminCap, arg1: &0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::config::ProtocolConfig, arg2: address) {
        0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::config::transfer_admin_cap(arg0, arg1, arg2);
    }

    entry fun update_default_protocol_fee_percentage(arg0: &0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::config::AdminCap, arg1: &mut 0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::config::ProtocolConfig, arg2: u64) {
        0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::config::update_default_protocol_fee_percentage(arg0, arg1, arg2);
    }

    entry fun update_protocol_sponsor(arg0: &0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::config::AdminCap, arg1: &mut 0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::config::ProtocolConfig, arg2: address, arg3: bool) {
        0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::config::update_protocol_sponsor(arg0, arg1, arg2, arg3);
    }

    entry fun claim_protocol_fee<T0>(arg0: &mut 0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::vault::Vault, arg1: &0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::config::ProtocolConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::vault::claim_protocol_fee<T0>(arg0, arg1, arg2);
    }

    entry fun create_rfq_vault(arg0: &0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::config::ProtocolConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::vault::create_rfq_vault(arg0, arg1, arg2);
    }

    entry fun deposit<T0>(arg0: &mut 0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::vault::Vault, arg1: &0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::config::ProtocolConfig, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::vault::deposit<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), arg3);
    }

    entry fun set_manager(arg0: &mut 0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::vault::Vault, arg1: &0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::config::ProtocolConfig, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::vault::set_manager(arg0, arg1, arg2, arg3);
    }

    entry fun support_coin<T0>(arg0: &mut 0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::vault::Vault, arg1: &0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::config::ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::vault::support_coin<T0>(arg0, arg1, arg2, arg3);
    }

    public fun swap_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::vault::Vault, arg2: &0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::config::ProtocolConfig, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::vault::swap_v2<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::into_balance<T0>(arg5), arg6, arg7), arg7), 0x2::tx_context::sender(arg7));
    }

    public fun swap_via_partner<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::vault::Vault, arg2: &0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::config::ProtocolConfig, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::coin::Coin<T0>, arg6: address, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::vault::swap_via_partner<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::into_balance<T0>(arg5), arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v0, arg8), 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v1, arg8), arg6);
    }

    public fun swap_via_partner_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::vault::Vault, arg2: &0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::config::ProtocolConfig, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: address, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::vault::swap_via_partner_v2<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::into_balance<T0>(arg5), arg6, arg7, arg8, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v0, arg9), 0x2::tx_context::sender(arg9));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v1, arg9), arg7);
    }

    entry fun update_min_deposit<T0>(arg0: &mut 0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::vault::Vault, arg1: &0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::config::ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::vault::update_min_deposit<T0>(arg0, arg1, arg2, arg3);
    }

    entry fun update_vault_protocol_fee(arg0: &0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::config::AdminCap, arg1: &0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::config::ProtocolConfig, arg2: &mut 0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::vault::Vault, arg3: u64) {
        0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::vault::update_vault_protocol_fee(arg0, arg1, arg2, arg3);
    }

    public fun withdraw<T0>(arg0: &mut 0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::vault::Vault, arg1: &0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::config::ProtocolConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::vault::withdraw<T0>(arg0, arg1, arg2, arg3), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

