module 0x2951965b98e256246b1a97d776cd69d9869c74ba73d57c26bda560704b7951e4::vault_event {
    struct NewVaultEvent<phantom T0, phantom T1> has copy, drop {
        id: 0x2::object::ID,
        supplyLimit: u64,
        supply_decimals: u8,
        performance_fee_rate: u64,
        management_fee_rate: u64,
        is_verified: bool,
        is_individual: bool,
        init_owner: address,
    }

    struct VaultCapTransferEvent has copy, drop {
        vault_id: 0x2::object::ID,
        previous_manager: address,
        new_manager: address,
    }

    struct BuyShareEvent<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        base_amount: u64,
        share_amount: u64,
    }

    struct SellShareEvent<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        base_amount: u64,
        share_amount: u64,
    }

    struct TakeBalanceEvent<phantom T0, phantom T1, phantom T2, phantom T3> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct PutBalanceEvent<phantom T0, phantom T1, phantom T2, phantom T3> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    public fun buy_share_event<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = BuyShareEvent<T0, T1>{
            vault_id     : arg0,
            base_amount  : arg1,
            share_amount : arg2,
        };
        0x2::event::emit<BuyShareEvent<T0, T1>>(v0);
    }

    public fun new_vault_event<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: bool, arg6: bool, arg7: address) {
        let v0 = NewVaultEvent<T0, T1>{
            id                   : arg0,
            supplyLimit          : arg1,
            supply_decimals      : arg2,
            performance_fee_rate : arg3,
            management_fee_rate  : arg4,
            is_verified          : arg5,
            is_individual        : arg6,
            init_owner           : arg7,
        };
        0x2::event::emit<NewVaultEvent<T0, T1>>(v0);
    }

    public fun put_balance_event<T0, T1, T2: drop, T3>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = PutBalanceEvent<T0, T1, T2, T3>{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<PutBalanceEvent<T0, T1, T2, T3>>(v0);
    }

    public fun sell_share_event<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = SellShareEvent<T0, T1>{
            vault_id     : arg0,
            base_amount  : arg1,
            share_amount : arg2,
        };
        0x2::event::emit<SellShareEvent<T0, T1>>(v0);
    }

    public fun take_balance_event<T0, T1, T2: drop, T3>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = TakeBalanceEvent<T0, T1, T2, T3>{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<TakeBalanceEvent<T0, T1, T2, T3>>(v0);
    }

    public fun vault_cap_transfer_event(arg0: 0x2::object::ID, arg1: address, arg2: address) {
        let v0 = VaultCapTransferEvent{
            vault_id         : arg0,
            previous_manager : arg1,
            new_manager      : arg2,
        };
        0x2::event::emit<VaultCapTransferEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

