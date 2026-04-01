module 0x4aadd5f89216aca635d54a3f7a6ea3598d11108629351566c06ecc66c4fc0b25::vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        balances: 0x2::bag::Bag,
        operators: 0x2::vec_set::VecSet<address>,
    }

    struct FlashLoanReceipt<phantom T0> {
        vault_id: 0x2::object::ID,
        borrow_amount: u64,
    }

    struct DepositEvent has copy, drop {
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct FlashLoanEvent has copy, drop {
        coin_type: 0x1::ascii::String,
        borrow_amount: u64,
        repay_amount: u64,
        profit: u64,
    }

    struct AclEvent has copy, drop {
        operator: address,
        authorized: bool,
    }

    public fun authorize(arg0: &AdminCap, arg1: &mut Vault, arg2: address) {
        assert!(!0x2::vec_set::contains<address>(&arg1.operators, &arg2), 4);
        0x2::vec_set::insert<address>(&mut arg1.operators, arg2);
        let v0 = AclEvent{
            operator   : arg2,
            authorized : true,
        };
        0x2::event::emit<AclEvent>(v0);
    }

    public fun balance_of<T0>(arg0: &Vault) : u64 {
        let v0 = type_key<T0>();
        if (!0x2::bag::contains<0x1::ascii::String>(&arg0.balances, v0)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::ascii::String, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
    }

    public fun deposit<T0>(arg0: &AdminCap, arg1: &mut Vault, arg2: 0x2::coin::Coin<T0>) {
        let v0 = type_key<T0>();
        if (!0x2::bag::contains<0x1::ascii::String>(&arg1.balances, v0)) {
            0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg1.balances, v0, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg1.balances, v0), 0x2::coin::into_balance<T0>(arg2));
        let v1 = DepositEvent{
            coin_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            amount    : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    public fun flash_loan<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoanReceipt<T0>) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.operators, &v0), 3);
        let v1 = type_key<T0>();
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg0.balances, v1), 2);
        let v2 = 0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.balances, v1);
        assert!(0x2::balance::value<T0>(v2) >= arg1, 0);
        let v3 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v2, arg1), arg2);
        let v4 = FlashLoanReceipt<T0>{
            vault_id      : 0x2::object::id<Vault>(arg0),
            borrow_amount : arg1,
        };
        (v3, v4)
    }

    public fun flash_repay<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>, arg2: FlashLoanReceipt<T0>) {
        let FlashLoanReceipt {
            vault_id      : v0,
            borrow_amount : v1,
        } = arg2;
        assert!(0x2::object::id<Vault>(arg0) == v0, 2);
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(v2 >= v1, 1);
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.balances, type_key<T0>()), 0x2::coin::into_balance<T0>(arg1));
        let v3 = FlashLoanEvent{
            coin_type     : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            borrow_amount : v1,
            repay_amount  : v2,
            profit        : v2 - v1,
        };
        0x2::event::emit<FlashLoanEvent>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Vault{
            id        : 0x2::object::new(arg0),
            balances  : 0x2::bag::new(arg0),
            operators : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<Vault>(v1);
    }

    public fun is_authorized(arg0: &Vault, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.operators, &arg1)
    }

    public fun revoke(arg0: &AdminCap, arg1: &mut Vault, arg2: address) {
        assert!(0x2::vec_set::contains<address>(&arg1.operators, &arg2), 3);
        0x2::vec_set::remove<address>(&mut arg1.operators, &arg2);
        let v0 = AclEvent{
            operator   : arg2,
            authorized : false,
        };
        0x2::event::emit<AclEvent>(v0);
    }

    fun type_key<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())
    }

    public fun withdraw<T0>(arg0: &AdminCap, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = type_key<T0>();
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg1.balances, v0), 2);
        let v1 = 0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg1.balances, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg2, 0);
        let v2 = WithdrawEvent{
            coin_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            amount    : arg2,
        };
        0x2::event::emit<WithdrawEvent>(v2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

