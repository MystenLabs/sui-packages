module 0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::dao_treasury {
    struct DaoTreasury<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        coins: 0x2::bag::Bag,
        dao: 0x2::object::ID,
    }

    struct FlashLoan<phantom T0, phantom T1> {
        amount: u64,
        fee: u64,
        type: 0x1::type_name::TypeName,
    }

    struct Donate<phantom T0, phantom T1> has copy, drop {
        value: u64,
        donator: address,
    }

    struct Transfer<phantom T0, phantom T1> has copy, drop {
        value: u64,
        sender: address,
    }

    struct TransferLinearWallet<phantom T0, phantom T1> has copy, drop {
        value: u64,
        sender: address,
        wallet_id: 0x2::object::ID,
        start: u64,
        duration: u64,
    }

    struct FlashLoanRequest<phantom T0, phantom T1> has copy, drop {
        borrower: address,
        treasury_id: 0x2::object::ID,
        value: u64,
        type: 0x1::type_name::TypeName,
    }

    public(friend) fun new<T0: drop>(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : DaoTreasury<T0> {
        DaoTreasury<T0>{
            id    : 0x2::object::new(arg1),
            coins : 0x2::bag::new(arg1),
            dao   : arg0,
        }
    }

    public fun balance<T0: drop, T1>(arg0: &DaoTreasury<T0>) : u64 {
        let v0 = 0x1::type_name::get<T1>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.coins, v0)) {
            return 0
        };
        0x2::balance::value<T1>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.coins, v0))
    }

    public fun amount<T0: drop, T1>(arg0: &FlashLoan<T0, T1>) : u64 {
        arg0.amount
    }

    public fun dao<T0: drop>(arg0: &DaoTreasury<T0>) : 0x2::object::ID {
        arg0.dao
    }

    public fun donate<T0: drop, T1>(arg0: &mut DaoTreasury<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T1>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.coins, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.coins, v0, 0x2::coin::into_balance<T1>(arg1));
        } else {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.coins, v0), 0x2::coin::into_balance<T1>(arg1));
        };
        let v1 = Donate<T0, T1>{
            value   : 0x2::coin::value<T1>(&arg1),
            donator : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Donate<T0, T1>>(v1);
    }

    public fun fee<T0: drop, T1>(arg0: &FlashLoan<T0, T1>) : u64 {
        arg0.fee
    }

    public fun flash_loan<T0: drop, T1>(arg0: &mut DaoTreasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, FlashLoan<T0, T1>) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = FlashLoanRequest<T0, T1>{
            borrower    : 0x2::tx_context::sender(arg2),
            treasury_id : 0x2::object::id<DaoTreasury<T0>>(arg0),
            value       : arg1,
            type        : v0,
        };
        0x2::event::emit<FlashLoanRequest<T0, T1>>(v1);
        let v2 = FlashLoan<T0, T1>{
            amount : 0x2::balance::value<T1>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.coins, v0)),
            fee    : 0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::fixed_point_roll::mul_up(arg1, 5000000),
            type   : v0,
        };
        (0x2::coin::take<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.coins, v0), arg1, arg2), v2)
    }

    public fun repay_flash_loan<T0: drop, T1>(arg0: &mut DaoTreasury<T0>, arg1: FlashLoan<T0, T1>, arg2: 0x2::coin::Coin<T1>) {
        let FlashLoan {
            amount : v0,
            fee    : v1,
            type   : v2,
        } = arg1;
        assert!(0x2::coin::value<T1>(&arg2) >= v0 + v1, 0);
        0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.coins, v2), 0x2::coin::into_balance<T1>(arg2));
    }

    public fun transfer<T0: drop, T1, T2>(arg0: &mut DaoTreasury<T0>, arg1: &0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::dao_admin::DaoAdmin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = Transfer<T0, T1>{
            value  : arg2,
            sender : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<Transfer<T0, T1>>(v0);
        0x2::coin::take<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.coins, 0x1::type_name::get<T2>()), arg2, arg3)
    }

    public fun transfer_linear_vesting_wallet<T0: drop, T1, T2>(arg0: &mut DaoTreasury<T0>, arg1: &0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::dao_admin::DaoAdmin<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::linear_vesting_wallet::Wallet<T1> {
        let v0 = 0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::linear_vesting_wallet::new<T1>(0x2::coin::take<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.coins, 0x1::type_name::get<T2>()), arg3, arg6), arg2, arg4, arg5, arg6);
        let v1 = TransferLinearWallet<T0, T1>{
            value     : arg3,
            sender    : 0x2::tx_context::sender(arg6),
            wallet_id : 0x2::object::id<0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::linear_vesting_wallet::Wallet<T1>>(&v0),
            start     : arg4,
            duration  : arg5,
        };
        0x2::event::emit<TransferLinearWallet<T0, T1>>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

