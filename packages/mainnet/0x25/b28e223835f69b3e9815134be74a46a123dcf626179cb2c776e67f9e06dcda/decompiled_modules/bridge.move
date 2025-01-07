module 0x908c65c9be54883fd28d1f3e65de06496d66ae579d66e174af2ad9c1d180076b::bridge {
    struct Bridge<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        fee_balance: 0x2::balance::Balance<T0>,
        gas_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        gas_amount: u64,
        version: u64,
        nonce: u64,
        fee_rate: u64,
    }

    struct LockEvent has copy, drop {
        bridge: 0x2::object::ID,
        amount: u64,
        time: u64,
        version: u64,
        to: vector<u8>,
        gas_amount: u64,
        fee_amount: u64,
        nonce: u64,
        sender: address,
    }

    struct UnockEvent has copy, drop {
        bridge: 0x2::object::ID,
        amount: u64,
        time: u64,
        version: u64,
        type: u64,
        recever: address,
    }

    fun bcs_params(arg0: vector<u8>, arg1: address, arg2: u64, arg3: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<vector<u8>>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg3));
        v0
    }

    entry fun change_fee_rate<T0>(arg0: &mut Bridge<T0>, arg1: &0x908c65c9be54883fd28d1f3e65de06496d66ae579d66e174af2ad9c1d180076b::admin::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.fee_rate = arg2;
    }

    entry fun change_gas_rate<T0>(arg0: &mut Bridge<T0>, arg1: &0x908c65c9be54883fd28d1f3e65de06496d66ae579d66e174af2ad9c1d180076b::admin::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.gas_amount = arg2;
    }

    public fun create_bridge<T0>(arg0: &0x908c65c9be54883fd28d1f3e65de06496d66ae579d66e174af2ad9c1d180076b::admin::AdminCap, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Bridge<T0>{
            id          : 0x2::object::new(arg3),
            balance     : 0x2::balance::zero<T0>(),
            fee_balance : 0x2::balance::zero<T0>(),
            gas_balance : 0x2::balance::zero<0x2::sui::SUI>(),
            gas_amount  : arg2,
            version     : 1,
            nonce       : 0,
            fee_rate    : arg1,
        };
        0x2::transfer::public_share_object<Bridge<T0>>(v0);
    }

    entry fun emergency_deposit<T0>(arg0: &mut Bridge<T0>, arg1: &0x908c65c9be54883fd28d1f3e65de06496d66ae579d66e174af2ad9c1d180076b::admin::AdminCap, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg2));
    }

    entry fun emergency_withdraw<T0>(arg0: &mut Bridge<T0>, arg1: &0x908c65c9be54883fd28d1f3e65de06496d66ae579d66e174af2ad9c1d180076b::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, 0x2::balance::value<T0>(&arg0.balance)), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun lock<T0>(arg0: &mut Bridge<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1003);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg0.gas_amount, 1002);
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let v1 = arg0.fee_rate * 0x2::balance::value<T0>(&v0) / 10000;
        0x2::balance::join<T0>(&mut arg0.balance, v0);
        0x2::balance::join<T0>(&mut arg0.fee_balance, 0x2::balance::split<T0>(&mut v0, v1));
        arg0.nonce = arg0.nonce + 1;
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.gas_balance, v2);
        let v3 = LockEvent{
            bridge     : 0x2::object::id<Bridge<T0>>(arg0),
            amount     : 0x2::balance::value<T0>(&v0) - v1,
            time       : 0x2::clock::timestamp_ms(arg4),
            version    : arg0.version,
            to         : arg3,
            gas_amount : 0x2::balance::value<0x2::sui::SUI>(&v2),
            fee_amount : v1,
            nonce      : arg0.nonce,
            sender     : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<LockEvent>(v3);
    }

    entry fun migrate<T0>(arg0: &mut Bridge<T0>, arg1: &0x908c65c9be54883fd28d1f3e65de06496d66ae579d66e174af2ad9c1d180076b::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.version = 1;
    }

    entry fun take_fee<T0>(arg0: &mut Bridge<T0>, arg1: &0x908c65c9be54883fd28d1f3e65de06496d66ae579d66e174af2ad9c1d180076b::admin::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.fee_balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    entry fun take_gas<T0>(arg0: &mut Bridge<T0>, arg1: &0x908c65c9be54883fd28d1f3e65de06496d66ae579d66e174af2ad9c1d180076b::admin::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.gas_balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun unlock<T0>(arg0: &mut Bridge<T0>, arg1: &0x908c65c9be54883fd28d1f3e65de06496d66ae579d66e174af2ad9c1d180076b::multipleSign::MultipleSigner, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: vector<vector<u8>>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1003);
        let v0 = bcs_params(b"private", arg3, arg2, arg4);
        0x1::debug::print<vector<u8>>(&v0);
        0x908c65c9be54883fd28d1f3e65de06496d66ae579d66e174af2ad9c1d180076b::multipleSign::verifySignatures(arg1, arg6, v0);
        assert!(arg0.nonce + 1 == arg4, 1001);
        arg0.nonce = arg4;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg8), arg3);
        let v1 = if (arg5 == 3) {
            3
        } else {
            2
        };
        let v2 = UnockEvent{
            bridge  : 0x2::object::id<Bridge<T0>>(arg0),
            amount  : arg2,
            time    : 0x2::clock::timestamp_ms(arg7),
            version : arg0.version,
            type    : v1,
            recever : arg3,
        };
        0x2::event::emit<UnockEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

