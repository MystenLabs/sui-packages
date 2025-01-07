module 0xe42c6196e06176e333771a5a9f0b3ab9c12006eab4b652d2d2c58c6d347d30d8::vault {
    struct Vault has store, key {
        id: 0x2::object::UID,
        coins: 0x2::bag::Bag,
    }

    struct FlashLoanReceipt<phantom T0> {
        borrow_amount: u64,
        repay_amount: u64,
    }

    struct DepositEvent has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun deposit<T0>(arg0: &mut Vault, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(arg1) >= arg2, 0);
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.coins, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.coins, v0, 0x2::coin::zero<T0>(arg3));
        };
        0x2::coin::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.coins, v0), 0x2::coin::split<T0>(arg1, arg2, arg3));
        let v1 = DepositEvent{
            coin_type : v0,
            amount    : arg2,
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    public fun flash_loan<T0>(arg0: &mut Vault, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoanReceipt<T0>) {
        assert!(arg2 > arg1, 0);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.coins, v0), 1);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.coins, v0);
        assert!(0x2::coin::value<T0>(v1) > arg1, 2);
        let v2 = FlashLoanReceipt<T0>{
            borrow_amount : arg1,
            repay_amount  : arg2,
        };
        (0x2::coin::split<T0>(v1, arg1, arg3), v2)
    }

    public fun flash_repay<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>, arg2: FlashLoanReceipt<T0>) {
        assert!(0x2::coin::value<T0>(&arg1) >= arg2.repay_amount, 0);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.coins, v0), 1);
        0x2::coin::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.coins, v0), arg1);
        let FlashLoanReceipt {
            borrow_amount : _,
            repay_amount  : _,
        } = arg2;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id    : 0x2::object::new(arg0),
            coins : 0x2::bag::new(arg0),
        };
        0x2::transfer::public_share_object<Vault>(v0);
    }

    public fun join_coin<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::put<T0>(0x2::coin::balance_mut<T0>(arg0), arg1);
    }

    public(friend) fun withdraw<T0>(arg0: &0xe42c6196e06176e333771a5a9f0b3ab9c12006eab4b652d2d2c58c6d347d30d8::dolphin_cap::DolphinCap, arg1: &mut Vault, arg2: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg1.coins, v0), 1);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg1.coins, v0);
        let v2 = if (0x2::coin::value<T0>(v1) > arg2) {
            0x2::coin::value<T0>(v1)
        } else {
            arg2
        };
        let v3 = WithdrawEvent{
            coin_type : v0,
            amount    : v2,
        };
        0x2::event::emit<WithdrawEvent>(v3);
        0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(v1), v2)
    }

    // decompiled from Move bytecode v6
}

