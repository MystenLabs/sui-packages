module 0xe7410af2d2ed8b5c418790c1371d30b3b529958f5718fbc99c5e841144550cb5::liquidity_pool {
    struct Bank<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        sweep_accounts: 0x2::object_table::ObjectTable<address, SweepAccount>,
        swap_requests: 0x2::object_table::ObjectTable<0x2::object::ID, SwapRequest>,
    }

    struct BankOwnerCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        bank_id: 0x2::object::ID,
    }

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct BankBalance<phantom T0> has store {
        amount: 0x2::balance::Balance<T0>,
    }

    struct SweepAccount has store, key {
        id: 0x2::object::UID,
        user: address,
    }

    struct SwapRequest has store, key {
        id: 0x2::object::UID,
        user: address,
        valid_till: u64,
        coin_type_in: 0x1::type_name::TypeName,
        coin_type_out: 0x1::type_name::TypeName,
        expected_input_amount: u64,
        minimum_output_amount: u64,
    }

    struct SweepCoinEvent has copy, drop {
        user: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct WithdrawCoinEvent has copy, drop {
        user_withdrawal_address: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct SwapEvent has copy, drop {
        user: address,
        input_coin_type: 0x1::type_name::TypeName,
        output_coin_type: 0x1::type_name::TypeName,
        input_amount: u64,
        output_amount: u64,
    }

    struct LIQUIDITY_POOL has drop {
        dummy_field: bool,
    }

    public fun create_swap_request<T0, T1, T2>(arg0: &BankOwnerCap<T0>, arg1: &mut Bank<T0>, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1);
        let v0 = SwapRequest{
            id                    : 0x2::object::new(arg6),
            user                  : arg2,
            valid_till            : arg3,
            coin_type_in          : 0x1::type_name::get<T1>(),
            coin_type_out         : 0x1::type_name::get<T2>(),
            expected_input_amount : arg4,
            minimum_output_amount : arg5,
        };
        0x2::object_table::add<0x2::object::ID, SwapRequest>(&mut arg1.swap_requests, 0x2::object::id<SwapRequest>(&v0), v0);
    }

    public fun create_sweep_account_for_user<T0>(arg0: address, arg1: &mut Bank<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1);
        let v0 = SweepAccount{
            id   : 0x2::object::new(arg2),
            user : arg0,
        };
        0x2::object_table::add<address, SweepAccount>(&mut arg1.sweep_accounts, arg0, v0);
    }

    public fun fulfill_swap_request<T0, T1, T2>(arg0: &BankOwnerCap<T0>, arg1: &mut Bank<T0>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T2>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg1.version == 1, 1);
        let v0 = 0x2::object_table::remove<0x2::object::ID, SwapRequest>(&mut arg1.swap_requests, arg2);
        assert!(v0.valid_till > 0x2::clock::timestamp_ms(arg3), 2);
        assert!(arg5 > v0.expected_input_amount, 4);
        let v1 = 0x2::coin::value<T2>(&arg4);
        assert!(v1 >= v0.minimum_output_amount, 3);
        let v2 = BalanceKey<T2>{dummy_field: false};
        0x2::balance::join<T2>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey<T2>, BankBalance<T2>>(&mut arg1.id, v2).amount, 0x2::coin::into_balance<T2>(arg4));
        let v3 = BalanceKey<T1>{dummy_field: false};
        let v4 = SwapEvent{
            user             : v0.user,
            input_coin_type  : 0x1::type_name::get<T1>(),
            output_coin_type : 0x1::type_name::get<T2>(),
            input_amount     : arg5,
            output_amount    : v1,
        };
        0x2::event::emit<SwapEvent>(v4);
        let SwapRequest {
            id                    : v5,
            user                  : _,
            valid_till            : _,
            coin_type_in          : _,
            coin_type_out         : _,
            expected_input_amount : _,
            minimum_output_amount : _,
        } = v0;
        0x2::object::delete(v5);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey<T1>, BankBalance<T1>>(&mut arg1.id, v3).amount, arg5), arg6)
    }

    fun init(arg0: LIQUIDITY_POOL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<LIQUIDITY_POOL>(arg0, arg1);
        let (v0, v1) = init_bank<LIQUIDITY_POOL>(arg1);
        0x2::transfer::share_object<Bank<LIQUIDITY_POOL>>(v0);
        0x2::transfer::transfer<BankOwnerCap<LIQUIDITY_POOL>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun init_balance_for_coin<T0, T1>(arg0: &BankOwnerCap<T0>, arg1: &mut Bank<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1);
        let v0 = BalanceKey<T1>{dummy_field: false};
        let v1 = BankBalance<T1>{amount: 0x2::balance::zero<T1>()};
        0x2::dynamic_field::add<BalanceKey<T1>, BankBalance<T1>>(&mut arg1.id, v0, v1);
    }

    fun init_bank<T0>(arg0: &mut 0x2::tx_context::TxContext) : (Bank<T0>, BankOwnerCap<T0>) {
        let v0 = Bank<T0>{
            id             : 0x2::object::new(arg0),
            version        : 1,
            sweep_accounts : 0x2::object_table::new<address, SweepAccount>(arg0),
            swap_requests  : 0x2::object_table::new<0x2::object::ID, SwapRequest>(arg0),
        };
        let v1 = BankOwnerCap<T0>{
            id      : 0x2::object::new(arg0),
            bank_id : 0x2::object::id<Bank<T0>>(&v0),
        };
        (v0, v1)
    }

    public fun sweep_coin<T0, T1>(arg0: &mut Bank<T0>, arg1: address, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T1>>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T1>>(&mut 0x2::object_table::borrow_mut<address, SweepAccount>(&mut arg0.sweep_accounts, arg1).id, arg2);
        let v1 = BalanceKey<T1>{dummy_field: false};
        let v2 = SweepCoinEvent{
            user      : arg1,
            coin_type : 0x1::type_name::get<T1>(),
            amount    : 0x2::coin::value<T1>(&v0),
        };
        0x2::event::emit<SweepCoinEvent>(v2);
        0x2::balance::join<T1>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey<T1>, BankBalance<T1>>(&mut arg0.id, v1).amount, 0x2::coin::into_balance<T1>(v0));
    }

    public fun withdraw_tokens<T0, T1>(arg0: &BankOwnerCap<T0>, arg1: &mut Bank<T0>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1);
        let v0 = BalanceKey<T1>{dummy_field: false};
        let v1 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey<T1>, BankBalance<T1>>(&mut arg1.id, v0).amount, arg3), arg4);
        let v2 = WithdrawCoinEvent{
            user_withdrawal_address : arg2,
            coin_type               : 0x1::type_name::get<T1>(),
            amount                  : 0x2::coin::value<T1>(&v1),
        };
        0x2::event::emit<WithdrawCoinEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, arg2);
    }

    // decompiled from Move bytecode v6
}

