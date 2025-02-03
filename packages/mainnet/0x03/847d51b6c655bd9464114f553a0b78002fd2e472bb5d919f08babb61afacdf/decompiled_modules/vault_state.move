module 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::vault_state {
    struct VaultStateChangedEvent has copy, drop {
        vaultId: 0x2::object::ID,
        sender: address,
        timestamp: u64,
        final_state: u8,
    }

    public entry fun mark_state_as_ready_for_withdrawal_processing<T0, T1, T2>(arg0: &mut 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::vault::Vault<T0, T1, T2>, arg1: &0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::version::Version, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::version::assert_current_version(arg1);
        0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::vault::assert_address_whitelisted<T0, T1, T2>(arg0, arg3);
        0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::vault::mark_state_as_ready_for_withdrawal_processing<T0, T1, T2>(arg0, arg3);
        let v0 = VaultStateChangedEvent{
            vaultId     : 0x2::object::id<0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::vault::Vault<T0, T1, T2>>(arg0),
            sender      : 0x2::tx_context::sender(arg3),
            timestamp   : 0x2::clock::timestamp_ms(arg2),
            final_state : 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::constants::strategy_active(),
        };
        0x2::event::emit<VaultStateChangedEvent>(v0);
    }

    public entry fun start_strategy<T0, T1, T2>(arg0: &mut 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::vault::Vault<T0, T1, T2>, arg1: &0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::version::Version, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::version::assert_current_version(arg1);
        0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::vault::assert_address_whitelisted<T0, T1, T2>(arg0, arg3);
        0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::vault::start_strategy<T0, T1, T2>(arg0, arg2, arg3);
        let v0 = VaultStateChangedEvent{
            vaultId     : 0x2::object::id<0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::vault::Vault<T0, T1, T2>>(arg0),
            sender      : 0x2::tx_context::sender(arg3),
            timestamp   : 0x2::clock::timestamp_ms(arg2),
            final_state : 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::constants::strategy_paused_and_ready_for_withdrawal_processing(),
        };
        0x2::event::emit<VaultStateChangedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

