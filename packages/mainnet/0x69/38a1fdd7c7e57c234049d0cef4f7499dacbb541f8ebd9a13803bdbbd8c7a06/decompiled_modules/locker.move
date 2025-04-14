module 0x6938a1fdd7c7e57c234049d0cef4f7499dacbb541f8ebd9a13803bdbbd8c7a06::locker {
    struct LockBox has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        unlock_time: u64,
    }

    public entry fun deposit(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0x2::clock::timestamp_ms(arg2), 0);
        let v0 = LockBox{
            id          : 0x2::object::new(arg3),
            balance     : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            unlock_time : arg1,
        };
        0x2::transfer::public_transfer<LockBox>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw(arg0: LockBox, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.unlock_time, 1);
        let LockBox {
            id          : v0,
            balance     : v1,
            unlock_time : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

