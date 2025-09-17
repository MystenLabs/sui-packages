module 0xe506cdb0ecf053a0676539aab1164dafc932ba5c02200b12e27f9145f344c9af::typus_adapter_event {
    struct NewTypusVaultEvent has copy, drop {
        id: 0x2::object::ID,
        of: 0x2::object::ID,
    }

    struct TypusDepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        lp_amount: u64,
    }

    struct TypusWithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        lp_amount: u64,
        amount: u64,
    }

    public fun deposit_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = TypusDepositEvent{
            vault_id  : arg0,
            amount    : arg1,
            lp_amount : arg2,
        };
        0x2::event::emit<TypusDepositEvent>(v0);
    }

    public fun new_typus_vault_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = NewTypusVaultEvent{
            id : arg0,
            of : arg1,
        };
        0x2::event::emit<NewTypusVaultEvent>(v0);
    }

    public fun withdraw_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = TypusWithdrawEvent{
            vault_id  : arg0,
            lp_amount : arg1,
            amount    : arg2,
        };
        0x2::event::emit<TypusWithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

