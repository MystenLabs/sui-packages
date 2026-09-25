module 0x8f70ad5db84e1a99b542f86ccfb1a932ca7ba010a2fa12a1504d839ff4c111c6::moonbags_token_lock {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Configuration has store, key {
        id: 0x2::object::UID,
        lock_fee: u64,
        admin: address,
    }

    struct LockContract<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        amount: u64,
        start_time: u64,
        end_time: u64,
        locker: address,
        recipient: address,
        closed: bool,
    }

    struct LockCreatedEvent has copy, drop {
        contract_id: address,
        token_address: 0x1::ascii::String,
        locker: address,
        recipient: address,
        amount: u64,
        fee: u64,
        start_time: u64,
        end_time: u64,
    }

    struct TokensWithdrawnEvent has copy, drop {
        contract_id: address,
        sender: address,
        recipient: address,
        amount: u64,
    }

    struct UpdateLockContractEvent has copy, drop {
        contract_id: address,
        token_address: 0x1::ascii::String,
        old_locker: 0x1::ascii::String,
        new_locker: 0x1::ascii::String,
        old_recipient: 0x1::ascii::String,
        new_recipient: 0x1::ascii::String,
        updated_by: 0x1::ascii::String,
    }

    public entry fun create_lock<T0>(arg0: &Configuration, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun extend_lock<T0>(arg0: &mut LockContract<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun update_config(arg0: &AdminCap, arg1: &mut Configuration, arg2: u64, arg3: address) {
        abort 0
    }

    public entry fun update_lock_contract<T0>(arg0: &AdminCap, arg1: &mut LockContract<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun withdraw<T0>(arg0: &Configuration, arg1: &mut LockContract<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    // decompiled from Move bytecode v7
}

