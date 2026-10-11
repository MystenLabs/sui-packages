module 0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::devlock {
    struct DevLock has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>,
        beneficiary: address,
        start_ms: u64,
        unlock_ms: u64,
        initial_amount: u64,
        withdrawn: u64,
    }

    struct DevWithdrawn has copy, drop {
        devlock_id: 0x2::object::ID,
        beneficiary: address,
        amount: u64,
        timestamp_ms: u64,
    }

    public(friend) fun new(arg0: 0x2::balance::Balance<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : DevLock {
        assert!(0x2::balance::value<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>(&arg0) == 100000000000000000, 104);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        DevLock{
            id             : 0x2::object::new(arg3),
            balance        : arg0,
            beneficiary    : arg1,
            start_ms       : v0,
            unlock_ms      : v0 + 31536000000,
            initial_amount : 100000000000000000,
            withdrawn      : 0,
        }
    }

    public fun beneficiary(arg0: &DevLock) : address {
        arg0.beneficiary
    }

    public fun dev_total() : u64 {
        100000000000000000
    }

    public fun initial_amount(arg0: &DevLock) : u64 {
        arg0.initial_amount
    }

    public fun is_unlocked(arg0: &DevLock, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.unlock_ms
    }

    public fun lock_duration_ms() : u64 {
        31536000000
    }

    public fun locked_balance(arg0: &DevLock) : u64 {
        0x2::balance::value<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>(&arg0.balance)
    }

    public(friend) fun share(arg0: DevLock) {
        0x2::transfer::share_object<DevLock>(arg0);
    }

    public fun start_ms(arg0: &DevLock) : u64 {
        arg0.start_ms
    }

    public fun unlock_ms(arg0: &DevLock) : u64 {
        arg0.unlock_ms
    }

    public fun withdraw(arg0: &mut DevLock, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.beneficiary, 101);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.unlock_ms, 102);
        let v1 = 0x2::balance::value<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>(&arg0.balance);
        assert!(v1 > 0, 103);
        arg0.withdrawn = arg0.withdrawn + v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>>(0x2::coin::from_balance<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>(0x2::balance::withdraw_all<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::plays::PLAYS>(&mut arg0.balance), arg2), arg0.beneficiary);
        let v2 = DevWithdrawn{
            devlock_id   : 0x2::object::id<DevLock>(arg0),
            beneficiary  : arg0.beneficiary,
            amount       : v1,
            timestamp_ms : v0,
        };
        0x2::event::emit<DevWithdrawn>(v2);
    }

    public fun withdrawn(arg0: &DevLock) : u64 {
        arg0.withdrawn
    }

    // decompiled from Move bytecode v7
}

