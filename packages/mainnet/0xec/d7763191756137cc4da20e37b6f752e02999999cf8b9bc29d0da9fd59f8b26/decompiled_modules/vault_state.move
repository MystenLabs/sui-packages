module 0xecd7763191756137cc4da20e37b6f752e02999999cf8b9bc29d0da9fd59f8b26::vault_state {
    struct VaultStateChangedEvent has copy, drop {
        vaultId: 0x2::object::ID,
        sender: address,
        timestamp: u64,
        final_state: u8,
    }

    public entry fun mark_state_as_ready_for_withdrawal_processing<T0, T1, T2>(arg0: &mut 0xecd7763191756137cc4da20e37b6f752e02999999cf8b9bc29d0da9fd59f8b26::vault::Vault<T0, T1, T2>, arg1: &0xecd7763191756137cc4da20e37b6f752e02999999cf8b9bc29d0da9fd59f8b26::version::Version, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xecd7763191756137cc4da20e37b6f752e02999999cf8b9bc29d0da9fd59f8b26::version::assert_current_version(arg1);
        0xecd7763191756137cc4da20e37b6f752e02999999cf8b9bc29d0da9fd59f8b26::vault::assert_address_whitelisted<T0, T1, T2>(arg0, arg3);
        0xecd7763191756137cc4da20e37b6f752e02999999cf8b9bc29d0da9fd59f8b26::vault::mark_state_as_ready_for_withdrawal_processing<T0, T1, T2>(arg0, arg3);
        let v0 = VaultStateChangedEvent{
            vaultId     : 0x2::object::id<0xecd7763191756137cc4da20e37b6f752e02999999cf8b9bc29d0da9fd59f8b26::vault::Vault<T0, T1, T2>>(arg0),
            sender      : 0x2::tx_context::sender(arg3),
            timestamp   : 0x2::clock::timestamp_ms(arg2),
            final_state : 0xecd7763191756137cc4da20e37b6f752e02999999cf8b9bc29d0da9fd59f8b26::constants::strategy_active(),
        };
        0x2::event::emit<VaultStateChangedEvent>(v0);
    }

    public entry fun start_strategy<T0, T1, T2>(arg0: &mut 0xecd7763191756137cc4da20e37b6f752e02999999cf8b9bc29d0da9fd59f8b26::vault::Vault<T0, T1, T2>, arg1: &0xecd7763191756137cc4da20e37b6f752e02999999cf8b9bc29d0da9fd59f8b26::version::Version, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xecd7763191756137cc4da20e37b6f752e02999999cf8b9bc29d0da9fd59f8b26::version::assert_current_version(arg1);
        0xecd7763191756137cc4da20e37b6f752e02999999cf8b9bc29d0da9fd59f8b26::vault::assert_address_whitelisted<T0, T1, T2>(arg0, arg3);
        0xecd7763191756137cc4da20e37b6f752e02999999cf8b9bc29d0da9fd59f8b26::vault::start_strategy<T0, T1, T2>(arg0, arg2, arg3);
        let v0 = VaultStateChangedEvent{
            vaultId     : 0x2::object::id<0xecd7763191756137cc4da20e37b6f752e02999999cf8b9bc29d0da9fd59f8b26::vault::Vault<T0, T1, T2>>(arg0),
            sender      : 0x2::tx_context::sender(arg3),
            timestamp   : 0x2::clock::timestamp_ms(arg2),
            final_state : 0xecd7763191756137cc4da20e37b6f752e02999999cf8b9bc29d0da9fd59f8b26::constants::strategy_paused_and_ready_for_withdrawal_processing(),
        };
        0x2::event::emit<VaultStateChangedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

