module 0xc92d1cbfae6db08e9304d7fefa8187e1c859f4f3708e034f3429bac63306702d::dao {
    struct DAO<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        start_time: u64,
        end_time: u64,
        cap: u64,
        owner: address,
        whitelisted_addresses: vector<address>,
        is_whitelist: bool,
        is_finalized: bool,
        funded_amount: u64,
        raised_balance: 0x2::balance::Balance<T0>,
        payment_balance: 0x2::balance::Balance<T1>,
    }

    struct DAOVoucher<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        owned_amount: u64,
    }

    public fun claim_dao<T0, T1>(arg0: &mut DAO<T0, T1>, arg1: DAOVoucher<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_finalized, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.payment_balance, arg1.owned_amount, arg2), 0x2::tx_context::sender(arg2));
        let DAOVoucher {
            id           : v0,
            owned_amount : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public entry fun create_dao<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: vector<address>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = DAO<T0, T1>{
            id                    : 0x2::object::new(arg6),
            start_time            : arg0,
            end_time              : arg1,
            cap                   : arg2,
            owner                 : 0x2::tx_context::sender(arg6),
            whitelisted_addresses : arg3,
            is_whitelist          : arg5,
            is_finalized          : false,
            funded_amount         : 0,
            raised_balance        : 0x2::balance::zero<T0>(),
            payment_balance       : 0x2::coin::into_balance<T1>(arg4),
        };
        0x2::transfer::share_object<DAO<T0, T1>>(v0);
    }

    public entry fun finalize_dao<T0, T1>(arg0: &mut DAO<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 4);
        assert!(!arg0.is_finalized, 6);
        assert!(0x2::balance::value<T0>(&arg0.raised_balance) == arg0.funded_amount, 5);
        arg0.is_finalized = true;
    }

    public entry fun fund_dao<T0, T1>(arg0: &mut DAO<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_whitelisted<T0, T1>(arg0, v0), 1);
        assert!(!arg0.is_finalized, 6);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= arg0.start_time && v1 <= arg0.end_time, 2);
        let v2 = 0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg1));
        assert!(arg0.funded_amount + v2 <= arg0.cap, 3);
        arg0.funded_amount = arg0.funded_amount + v2;
        0x2::balance::join<T0>(&mut arg0.raised_balance, 0x2::coin::into_balance<T0>(arg1));
        let v3 = DAOVoucher<T0, T1>{
            id           : 0x2::object::new(arg3),
            owned_amount : v2,
        };
        0x2::transfer::public_transfer<DAOVoucher<T0, T1>>(v3, v0);
    }

    public fun is_whitelisted<T0, T1>(arg0: &DAO<T0, T1>, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.whitelisted_addresses, &arg1)
    }

    public entry fun transfer_dao_funds<T0, T1>(arg0: &mut DAO<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.raised_balance, 0x2::balance::value<T0>(&arg0.raised_balance)), arg2), arg1);
    }

    // decompiled from Move bytecode v6
}

