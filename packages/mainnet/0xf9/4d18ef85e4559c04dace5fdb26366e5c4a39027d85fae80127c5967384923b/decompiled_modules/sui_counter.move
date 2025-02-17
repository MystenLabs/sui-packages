module 0xf94d18ef85e4559c04dace5fdb26366e5c4a39027d85fae80127c5967384923b::sui_counter {
    struct Locker has store, key {
        id: 0x2::object::UID,
        owner: address,
        lock_till_timestamp: u64,
        balance: u64,
        native_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun create_locker(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) > 0, 1);
        let v0 = Locker{
            id                  : 0x2::object::new(arg3),
            owner               : 0x2::tx_context::sender(arg3),
            lock_till_timestamp : 0x2::clock::timestamp_ms(arg1) + arg2,
            balance             : 0x2::coin::value<0x2::sui::SUI>(&arg0),
            native_balance      : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::balance::join<0x2::sui::SUI>(&mut v0.native_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        0x2::transfer::transfer<Locker>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun deposit(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut Locker, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.balance = arg1.balance + 0x2::coin::value<0x2::sui::SUI>(&arg0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.native_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
    }

    public fun withdraw_all(arg0: &mut Locker, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.lock_till_timestamp, 3);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.native_balance);
        assert!(v0 > 0, 1);
        arg0.balance = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.native_balance, v0, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

