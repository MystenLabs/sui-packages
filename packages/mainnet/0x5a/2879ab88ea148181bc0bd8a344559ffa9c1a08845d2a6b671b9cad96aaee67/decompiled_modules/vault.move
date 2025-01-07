module 0x496518924e115e1637fe743c4ec0ae94862e2bbadaa208ca43b1d1cf96e1bd08::vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        coins: 0x2::bag::Bag,
        deepbook_account: 0xdee9::custodian_v2::AccountCap,
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

    public(friend) fun deepbook_account(arg0: &Vault) : &0xdee9::custodian_v2::AccountCap {
        &arg0.deepbook_account
    }

    public entry fun deposit<T0>(arg0: &mut Vault, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
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
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Vault{
            id               : 0x2::object::new(arg0),
            coins            : 0x2::bag::new(arg0),
            deepbook_account : 0xdee9::clob_v2::create_account(arg0),
        };
        0x2::transfer::public_share_object<Vault>(v1);
    }

    public entry fun withdraw<T0>(arg0: &AdminCap, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg1.coins, v0), 1);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg1.coins, v0);
        let v2 = if (0x2::coin::value<T0>(v1) > arg2) {
            0x2::coin::value<T0>(v1)
        } else {
            arg2
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(v1, v2, arg3), 0x2::tx_context::sender(arg3));
        let v3 = WithdrawEvent{
            coin_type : v0,
            amount    : v2,
        };
        0x2::event::emit<WithdrawEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

