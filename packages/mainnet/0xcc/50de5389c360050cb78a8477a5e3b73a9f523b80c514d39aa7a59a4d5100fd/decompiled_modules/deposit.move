module 0xcc50de5389c360050cb78a8477a5e3b73a9f523b80c514d39aa7a59a4d5100fd::deposit {
    struct TimeDeposit<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        depositor: address,
        recipient: address,
        start_time: u64,
        duration: u64,
        unlock_time: u64,
    }

    struct DepositCreated<phantom T0> has copy, drop, store {
        deposit_id: 0x2::object::ID,
        depositor: address,
        recipient: address,
        amount: u64,
        start_time: u64,
        duration: u64,
        unlock_time: u64,
    }

    struct DepositWithdrawn<phantom T0> has copy, drop, store {
        deposit_id: 0x2::object::ID,
        withdrawer: address,
        withdraw_time: u64,
        amount_withdrawn: u64,
        withdrawn_by: u8,
    }

    public fun can_recipient_withdraw<T0>(arg0: &TimeDeposit<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.unlock_time
    }

    public fun create_deposit<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg2 > 0, 0);
        assert!(arg2 <= 525600, 3);
        assert!(arg1 != v0, 5);
        let v1 = 0x2::coin::into_balance<T0>(arg0);
        let v2 = 0x2::balance::value<T0>(&v1);
        assert!(v2 > 0, 2);
        let v3 = 0x2::clock::timestamp_ms(arg3);
        let v4 = arg2 * 60000;
        let v5 = v3 + v4;
        let v6 = 0x2::object::new(arg4);
        let v7 = TimeDeposit<T0>{
            id          : v6,
            balance     : v1,
            depositor   : v0,
            recipient   : arg1,
            start_time  : v3,
            duration    : v4,
            unlock_time : v5,
        };
        0x2::transfer::share_object<TimeDeposit<T0>>(v7);
        let v8 = DepositCreated<T0>{
            deposit_id  : 0x2::object::uid_to_inner(&v6),
            depositor   : v0,
            recipient   : arg1,
            amount      : v2,
            start_time  : v3,
            duration    : v4,
            unlock_time : v5,
        };
        0x2::event::emit<DepositCreated<T0>>(v8);
    }

    public fun get_deposit_info<T0>(arg0: &TimeDeposit<T0>, arg1: &0x2::clock::Clock) : (address, address, u64, u64, u64, u64, u64) {
        (arg0.depositor, arg0.recipient, 0x2::balance::value<T0>(&arg0.balance), arg0.start_time, arg0.duration, arg0.unlock_time, 0x2::clock::timestamp_ms(arg1))
    }

    public fun time_until_unlock<T0>(arg0: &TimeDeposit<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.unlock_time) {
            0
        } else {
            arg0.unlock_time - v0
        }
    }

    public fun withdraw_by_depositor<T0>(arg0: TimeDeposit<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.depositor, 4);
        let TimeDeposit {
            id          : v1,
            balance     : v2,
            depositor   : _,
            recipient   : _,
            start_time  : _,
            duration    : _,
            unlock_time : _,
        } = arg0;
        let v8 = v2;
        let v9 = 0x2::balance::value<T0>(&v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v8, v9, arg2), v0);
        let v10 = DepositWithdrawn<T0>{
            deposit_id       : 0x2::object::uid_to_inner(&arg0.id),
            withdrawer       : v0,
            withdraw_time    : 0x2::clock::timestamp_ms(arg1),
            amount_withdrawn : v9,
            withdrawn_by     : 0,
        };
        0x2::event::emit<DepositWithdrawn<T0>>(v10);
        0x2::balance::destroy_zero<T0>(v8);
        0x2::object::delete(v1);
    }

    public fun withdraw_by_recipient<T0>(arg0: TimeDeposit<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 == arg0.recipient, 4);
        assert!(v1 >= arg0.unlock_time, 1);
        let TimeDeposit {
            id          : v2,
            balance     : v3,
            depositor   : _,
            recipient   : _,
            start_time  : _,
            duration    : _,
            unlock_time : _,
        } = arg0;
        let v9 = v3;
        let v10 = 0x2::balance::value<T0>(&v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v9, v10, arg2), v0);
        let v11 = DepositWithdrawn<T0>{
            deposit_id       : 0x2::object::uid_to_inner(&arg0.id),
            withdrawer       : v0,
            withdraw_time    : v1,
            amount_withdrawn : v10,
            withdrawn_by     : 1,
        };
        0x2::event::emit<DepositWithdrawn<T0>>(v11);
        0x2::balance::destroy_zero<T0>(v9);
        0x2::object::delete(v2);
    }

    // decompiled from Move bytecode v6
}

