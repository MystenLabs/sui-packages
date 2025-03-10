module 0x2973b3f0821ebc2ae9ba59f1a49965fad387fff134d237c4062a27f34b5a521::flashloan {
    struct BalanceRecord has key {
        id: 0x2::object::UID,
    }

    struct BalanceManager<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        fee: u64,
        version: u64,
    }

    struct FlashLoanRecipient<phantom T0> {
        amount: u64,
    }

    struct WithdrawInfo has drop {
        balance_id: 0x2::object::ID,
        amount: u64,
        sender: address,
        version: u64,
    }

    struct SetFeeInfo has drop {
        balance_id: 0x2::object::ID,
        fee: u64,
        sender: address,
        version: u64,
    }

    public fun withdraw<T0>(arg0: &mut BalanceManager<T0>, arg1: u64, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = WithdrawInfo{
            balance_id : 0x2::object::id<BalanceManager<T0>>(arg0),
            amount     : arg1,
            sender     : 0x2::tx_context::sender(arg4),
            version    : arg0.version,
        };
        let v1 = 0x2::bcs::to_bytes<WithdrawInfo>(&v0);
        let v2 = 0x2::hash::keccak256(&v1);
        let v3 = x"27a4e35bea88ed8517159382f01335e8bc2c29c6aaae2b8f73588849fe30b4f0";
        assert!(0x2::ed25519::ed25519_verify(&arg2, &v3, &v2) == true, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg4), 0x2::tx_context::sender(arg4));
        arg0.version = 0x2::clock::timestamp_ms(arg3);
    }

    public fun deposit<T0>(arg0: &mut BalanceManager<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun create_balance_manager<T0>(arg0: &mut BalanceRecord, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = BalanceManager<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::zero<T0>(),
            fee     : arg1,
            version : 0,
        };
        0x2::dynamic_field::add<0x1::ascii::String, 0x2::object::ID>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>()), 0x2::object::id<BalanceManager<T0>>(&v0));
        0x2::transfer::share_object<BalanceManager<T0>>(v0);
    }

    public fun get_balance_manager_id<T0>(arg0: &BalanceRecord) : &0x2::object::ID {
        0x2::dynamic_field::borrow<0x1::ascii::String, 0x2::object::ID>(&arg0.id, 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>()))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BalanceRecord{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<BalanceRecord>(v0);
    }

    public fun loan<T0, T1, T2>(arg0: &mut 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::Vault<T0, T2>, arg1: &mut 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::kai_leverage_supply_pool::Strategy<T0, T1>, arg2: &mut 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::supply_pool::SupplyPool<T0, T1>, arg3: &mut BalanceManager<T2>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoanRecipient<T0>) {
        let v0 = 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::withdraw_t_amt<T0, T2>(arg0, arg4, &mut arg3.balance, arg5);
        0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::kai_leverage_supply_pool::withdraw<T0, T1, T2>(arg1, &mut v0, arg2, arg5);
        let v1 = FlashLoanRecipient<T0>{amount: arg4};
        (0x2::coin::from_balance<T0>(0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::redeem_withdraw_ticket<T0, T2>(arg0, v0), arg6), v1)
    }

    public fun repay<T0, T1>(arg0: &mut 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::Vault<T0, T1>, arg1: &mut BalanceManager<T1>, arg2: 0x2::coin::Coin<T0>, arg3: FlashLoanRecipient<T0>, arg4: &0x2::clock::Clock) {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let FlashLoanRecipient { amount: v1 } = arg3;
        assert!(0x2::balance::value<T0>(&v0) >= v1 + arg1.fee, 9223372779884118015);
        0x2::balance::join<T1>(&mut arg1.balance, 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::deposit<T0, T1>(arg0, v0, arg4));
    }

    public fun set_fee<T0>(arg0: &mut BalanceManager<T0>, arg1: u64, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = SetFeeInfo{
            balance_id : 0x2::object::id<BalanceManager<T0>>(arg0),
            fee        : arg1,
            sender     : 0x2::tx_context::sender(arg4),
            version    : arg0.version,
        };
        let v1 = 0x2::bcs::to_bytes<SetFeeInfo>(&v0);
        let v2 = 0x2::hash::keccak256(&v1);
        let v3 = x"27a4e35bea88ed8517159382f01335e8bc2c29c6aaae2b8f73588849fe30b4f0";
        assert!(0x2::ed25519::ed25519_verify(&arg2, &v3, &v2) == true, 1);
        arg0.fee = arg1;
        arg0.version = 0x2::clock::timestamp_ms(arg3);
    }

    // decompiled from Move bytecode v6
}

