module 0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::lock {
    struct OperatorLock<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        balance: 0x2::balance::Balance<T0>,
        unlock_ms: u64,
        beneficiary: address,
    }

    struct ReleasedEvent has copy, drop {
        to: address,
        amount: u64,
    }

    public(friend) fun assert_version<T0>(arg0: &OperatorLock<T0>) {
        assert!(arg0.version == 0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::distributor::version(), 0);
    }

    public fun balance_value<T0>(arg0: &OperatorLock<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun beneficiary<T0>(arg0: &OperatorLock<T0>) : address {
        arg0.beneficiary
    }

    public(friend) fun create<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = OperatorLock<T0>{
            id          : 0x2::object::new(arg3),
            version     : 0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::distributor::version(),
            balance     : arg0,
            unlock_ms   : arg1,
            beneficiary : arg2,
        };
        0x2::transfer::share_object<OperatorLock<T0>>(v0);
        0x2::object::id<OperatorLock<T0>>(&v0)
    }

    public(friend) fun locked_value<T0>(arg0: &OperatorLock<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public(friend) fun migrate<T0>(arg0: &mut OperatorLock<T0>) {
        assert!(arg0.version < 0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::distributor::version(), 0);
        arg0.version = 0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::distributor::version();
    }

    public fun release<T0>(arg0: &mut OperatorLock<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.unlock_ms, 1);
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        if (v0 == 0) {
            return
        };
        let v1 = arg0.beneficiary;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance), arg2), v1);
        let v2 = ReleasedEvent{
            to     : v1,
            amount : v0,
        };
        0x2::event::emit<ReleasedEvent>(v2);
    }

    public fun unlock_ms<T0>(arg0: &OperatorLock<T0>) : u64 {
        arg0.unlock_ms
    }

    // decompiled from Move bytecode v7
}

