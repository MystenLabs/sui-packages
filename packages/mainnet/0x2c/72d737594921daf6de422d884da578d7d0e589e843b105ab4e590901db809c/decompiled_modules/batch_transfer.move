module 0x2c72d737594921daf6de422d884da578d7d0e589e843b105ab4e590901db809c::batch_transfer {
    struct BatchTransferEvent has copy, drop {
        sender: address,
        token_type: vector<u8>,
        recipient_count: u64,
        total_amount: u64,
        service_fee: u64,
    }

    struct Factory has store, key {
        id: 0x2::object::UID,
        service_fee: u64,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun batch_transfer<T0>(arg0: &Factory, arg1: &mut Treasury, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<T0>, arg4: vector<address>, arg5: vector<u64>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg4);
        assert!(v0 > 0, 4);
        assert!(v0 <= 200, 1);
        assert!(v0 == 0x1::vector::length<u64>(&arg5), 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg0.service_fee, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        if (0x2::balance::value<0x2::sui::SUI>(&arg1.balance) >= 5000000000) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, 4900000000), arg6), @0x3bc44c92f693a7e02ac587b6c221abe3084285f47c271e0d13b4d4599b22788);
        };
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 + *0x1::vector::borrow<u64>(&arg5, v2);
            v2 = v2 + 1;
        };
        let v3 = 0x2::tx_context::sender(arg6);
        let v4 = 0;
        while (v4 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, *0x1::vector::borrow<u64>(&arg5, v4), arg6), *0x1::vector::borrow<address>(&arg4, v4));
            v4 = v4 + 1;
        };
        if (0x2::coin::value<T0>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v3);
        };
        let v5 = BatchTransferEvent{
            sender          : v3,
            token_type      : b"generic",
            recipient_count : v0,
            total_amount    : v1,
            service_fee     : arg0.service_fee,
        };
        0x2::event::emit<BatchTransferEvent>(v5);
    }

    public fun batch_transfer_sui(arg0: &Factory, arg1: &mut Treasury, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: vector<address>, arg5: vector<u64>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg4);
        assert!(v0 > 0, 4);
        assert!(v0 <= 200, 1);
        assert!(v0 == 0x1::vector::length<u64>(&arg5), 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg0.service_fee, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        if (0x2::balance::value<0x2::sui::SUI>(&arg1.balance) >= 5000000000) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, 4900000000), arg6), @0x3bc44c92f693a7e02ac587b6c221abe3084285f47c271e0d13b4d4599b22788);
        };
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 + *0x1::vector::borrow<u64>(&arg5, v2);
            v2 = v2 + 1;
        };
        let v3 = 0x2::tx_context::sender(arg6);
        let v4 = 0;
        while (v4 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, *0x1::vector::borrow<u64>(&arg5, v4), arg6), *0x1::vector::borrow<address>(&arg4, v4));
            v4 = v4 + 1;
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v3);
        };
        let v5 = BatchTransferEvent{
            sender          : v3,
            token_type      : b"SUI",
            recipient_count : v0,
            total_amount    : v1,
            service_fee     : arg0.service_fee,
        };
        0x2::event::emit<BatchTransferEvent>(v5);
    }

    public fun get_max_addresses() : u64 {
        200
    }

    public fun get_platform_address() : address {
        @0x3bc44c92f693a7e02ac587b6c221abe3084285f47c271e0d13b4d4599b22788
    }

    public fun get_service_fee(arg0: &Factory) : u64 {
        arg0.service_fee
    }

    public fun get_treasury_balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Factory{
            id          : 0x2::object::new(arg0),
            service_fee : 150000000,
        };
        0x2::transfer::share_object<Factory>(v0);
        let v1 = Treasury{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Treasury>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    entry fun update_service_fee(arg0: &mut Factory, arg1: &AdminCap, arg2: u64) {
        arg0.service_fee = arg2;
    }

    public fun withdraw(arg0: &mut Treasury, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg2, 5);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg2), arg3)
    }

    entry fun withdraw_all_to_platform(arg0: &mut Treasury, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v0), arg2), @0x3bc44c92f693a7e02ac587b6c221abe3084285f47c271e0d13b4d4599b22788);
        };
    }

    entry fun withdraw_to_platform(arg0: &mut Treasury, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(withdraw(arg0, arg1, arg2, arg3), @0x3bc44c92f693a7e02ac587b6c221abe3084285f47c271e0d13b4d4599b22788);
    }

    // decompiled from Move bytecode v6
}

