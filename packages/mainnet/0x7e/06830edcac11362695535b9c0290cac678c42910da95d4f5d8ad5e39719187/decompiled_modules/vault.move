module 0x7e06830edcac11362695535b9c0290cac678c42910da95d4f5d8ad5e39719187::vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        funds: 0x2::balance::Balance<T0>,
        used: 0x2::table::Table<vector<u8>, bool>,
        deposit_paused: bool,
        withdrawal_paused: bool,
        max_withdrawal: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
    }

    struct Receipt<phantom T0> has key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
        operation: vector<u8>,
        kind: u8,
        amount: u64,
        sender: address,
        recipient: address,
        timestamp_ms: u64,
    }

    struct Movement<phantom T0> has copy, drop {
        vault: 0x2::object::ID,
        operation: vector<u8>,
        kind: u8,
        amount: u64,
        sender: address,
        recipient: address,
        timestamp_ms: u64,
    }

    public fun configure<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: bool, arg3: bool, arg4: u64) {
        assert!(arg0.vault == 0x2::object::id<Vault<T0>>(arg1), 1);
        assert!(arg4 <= 1000000000000000, 3);
        arg1.deposit_paused = arg2;
        arg1.withdrawal_paused = arg3;
        arg1.max_withdrawal = arg4;
    }

    fun consume<T0>(arg0: &mut Vault<T0>, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 4);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.used, arg1), 5);
        0x2::table::add<vector<u8>, bool>(&mut arg0.used, arg1, true);
    }

    public fun create<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id                : 0x2::object::new(arg0),
            funds             : 0x2::balance::zero<T0>(),
            used              : 0x2::table::new<vector<u8>, bool>(arg0),
            deposit_paused    : true,
            withdrawal_paused : true,
            max_withdrawal    : 0,
        };
        let v1 = AdminCap{
            id    : 0x2::object::new(arg0),
            vault : 0x2::object::id<Vault<T0>>(&v0),
        };
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.deposit_paused, 2);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0 && v0 <= 1000000000000000, 3);
        consume<T0>(arg0, arg2);
        fund<T0>(arg0, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        record<T0>(arg0, arg2, 0, v0, v1, arg3, arg4);
    }

    public fun fund<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.funds, 0x2::coin::into_balance<T0>(arg1));
        assert!(0x2::balance::value<T0>(&arg0.funds) <= 1000000000000000, 3);
    }

    public fun inventory<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    public fun receipt_amount<T0>(arg0: &Receipt<T0>) : u64 {
        arg0.amount
    }

    public fun receipt_kind<T0>(arg0: &Receipt<T0>) : u8 {
        arg0.kind
    }

    public fun receipt_recipient<T0>(arg0: &Receipt<T0>) : address {
        arg0.recipient
    }

    public fun receipt_timestamp<T0>(arg0: &Receipt<T0>) : u64 {
        arg0.timestamp_ms
    }

    fun record<T0>(arg0: &Vault<T0>, arg1: vector<u8>, arg2: u8, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::object::id<Vault<T0>>(arg0);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        let v3 = Movement<T0>{
            vault        : v1,
            operation    : arg1,
            kind         : arg2,
            amount       : arg3,
            sender       : v0,
            recipient    : arg4,
            timestamp_ms : v2,
        };
        0x2::event::emit<Movement<T0>>(v3);
        let v4 = Receipt<T0>{
            id           : 0x2::object::new(arg6),
            vault        : v1,
            operation    : arg1,
            kind         : arg2,
            amount       : arg3,
            sender       : v0,
            recipient    : arg4,
            timestamp_ms : v2,
        };
        0x2::transfer::freeze_object<Receipt<T0>>(v4);
    }

    public fun rotate_admin(arg0: AdminCap, arg1: address) {
        assert!(arg1 != @0x0, 1);
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun withdraw<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: u64, arg3: address, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.vault == 0x2::object::id<Vault<T0>>(arg1), 1);
        assert!(!arg1.withdrawal_paused, 2);
        let v0 = if (arg2 > 0) {
            if (arg2 <= arg1.max_withdrawal) {
                arg3 != @0x0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3);
        assert!(0x2::balance::value<T0>(&arg1.funds) >= arg2, 6);
        consume<T0>(arg1, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.funds, arg2), arg6), arg3);
        record<T0>(arg1, arg4, 1, arg2, arg3, arg5, arg6);
    }

    // decompiled from Move bytecode v7
}

