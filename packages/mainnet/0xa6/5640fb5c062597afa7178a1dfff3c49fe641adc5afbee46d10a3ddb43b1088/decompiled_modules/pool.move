module 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool {
    struct DegenPool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T1>,
        sheet: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Sheet<DEGEN_POOL<T0>, T1>,
    }

    struct DEGEN_POOL<phantom T0> has drop {
        dummy_field: bool,
    }

    struct StakeRequest<phantom T0> {
        pool_id: 0x2::object::ID,
        account: address,
        amount: u64,
        asset_type: 0x1::type_name::TypeName,
        witnesses: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct UnstakeRequest<phantom T0> {
        pool_id: 0x2::object::ID,
        account: address,
        amount: u64,
        asset_type: 0x1::type_name::TypeName,
        witnesses: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct StakeResponse<phantom T0> {
        pool_id: 0x2::object::ID,
        account: address,
        amount: u64,
        asset_type: 0x1::type_name::TypeName,
        witnesses: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct UnstakeResponse<phantom T0> {
        pool_id: 0x2::object::ID,
        account: address,
        amount: u64,
        asset_type: 0x1::type_name::TypeName,
        witnesses: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct POOL has drop {
        dummy_field: bool,
    }

    public fun balance<T0, T1>(arg0: &DegenPool<T0, T1>) : &0x2::balance::Balance<T1> {
        &arg0.balance
    }

    public(friend) fun new<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) : DegenPool<T0, T1> {
        DegenPool<T0, T1>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<T1>(),
            sheet   : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::new<DEGEN_POOL<T0>, T1>(stamp<T0>()),
        }
    }

    public fun collect<T0, T1, T2>(arg0: &mut DegenPool<T0, T1>, arg1: 0x1::option::Option<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<DEGEN_POOL<T0>, T2, T1>>) {
        if (0x1::option::is_some<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<DEGEN_POOL<T0>, T2, T1>>(&arg1)) {
            0x2::balance::join<T1>(&mut arg0.balance, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::collect<DEGEN_POOL<T0>, T2, T1>(&mut arg0.sheet, 0x1::option::destroy_some<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<DEGEN_POOL<T0>, T2, T1>>(arg1), stamp<T0>()));
        } else {
            0x1::option::destroy_none<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<DEGEN_POOL<T0>, T2, T1>>(arg1);
        };
    }

    public fun sheet<T0, T1>(arg0: &DegenPool<T0, T1>) : &0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Sheet<DEGEN_POOL<T0>, T1> {
        &arg0.sheet
    }

    public fun credit_value<T0, T1>(arg0: &DegenPool<T0, T1>) : u64 {
        let v0 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::credits<DEGEN_POOL<T0>, T1>(sheet<T0, T1>(arg0));
        let v1 = 0x2::vec_map::keys<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Debtor, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Credit<T1>>(v0);
        let v2 = &v1;
        let v3 = vector[];
        let v4 = 0;
        while (v4 < 0x1::vector::length<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Debtor>(v2)) {
            0x1::vector::push_back<u64>(&mut v3, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::credit_value<T1>(0x2::vec_map::get<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Debtor, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Credit<T1>>(v0, 0x1::vector::borrow<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Debtor>(v2, v4))));
            v4 = v4 + 1;
        };
        let v5 = 0;
        0x1::vector::reverse<u64>(&mut v3);
        let v6 = 0;
        while (v6 < 0x1::vector::length<u64>(&v3)) {
            v5 = v5 + 0x1::vector::pop_back<u64>(&mut v3);
            v6 = v6 + 1;
        };
        0x1::vector::destroy_empty<u64>(v3);
        v5
    }

    public(friend) fun destroy_stake_res<T0>(arg0: StakeResponse<T0>) : (0x2::object::ID, address, u64, 0x1::type_name::TypeName) {
        let StakeResponse {
            pool_id    : v0,
            account    : v1,
            amount     : v2,
            asset_type : v3,
            witnesses  : _,
        } = arg0;
        (v0, v1, v2, v3)
    }

    public(friend) fun destroy_unstake_res<T0>(arg0: UnstakeResponse<T0>) : (0x2::object::ID, address, u64, 0x1::type_name::TypeName) {
        let UnstakeResponse {
            pool_id    : v0,
            account    : v1,
            amount     : v2,
            asset_type : v3,
            witnesses  : _,
        } = arg0;
        (v0, v1, v2, v3)
    }

    public fun dun_by_admin<T0, T1, T2>(arg0: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>, arg1: u64) : 0x1::option::Option<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<DEGEN_POOL<T0>, T2, T1>> {
        let v0 = DEGEN_POOL<T0>{dummy_field: false};
        0x1::option::some<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<DEGEN_POOL<T0>, T2, T1>>(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::dun<DEGEN_POOL<T0>, T2, T1>(arg1, v0))
    }

    public fun dun_by_unstake_req<T0, T1, T2>(arg0: &DegenPool<T0, T1>, arg1: &mut UnstakeRequest<T0>) : 0x1::option::Option<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<DEGEN_POOL<T0>, T2, T1>> {
        let v0 = 0x1::type_name::get<DEGEN_POOL<T0>>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(unstake_req_witness<T0>(arg1), &v0)) {
            err_request_already_handled();
        };
        unstake_req_add_witness<T0, DEGEN_POOL<T0>>(arg1, stamp<T0>());
        if (0x2::balance::value<T1>(balance<T0, T1>(arg0)) >= arg1.amount) {
            return 0x1::option::none<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<DEGEN_POOL<T0>, T2, T1>>()
        };
        let v1 = arg1.amount - 0x2::balance::value<T1>(balance<T0, T1>(arg0));
        let v2 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debtor<T2>();
        if (0x2::vec_map::contains<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Debtor, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Credit<T1>>(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::credits<DEGEN_POOL<T0>, T1>(sheet<T0, T1>(arg0)), &v2) && 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::credit_value<T1>(0x2::vec_map::get<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Debtor, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Credit<T1>>(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::credits<DEGEN_POOL<T0>, T1>(sheet<T0, T1>(arg0)), &v2)) >= v1) {
            0x1::option::some<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<DEGEN_POOL<T0>, T2, T1>>(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::dun<DEGEN_POOL<T0>, T2, T1>(v1, stamp<T0>()))
        } else {
            0x1::option::none<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<DEGEN_POOL<T0>, T2, T1>>()
        }
    }

    fun err_invalid_debtor() {
        abort 2
    }

    fun err_pool_balance_not_enough() {
        abort 1
    }

    fun err_request_already_handled() {
        abort 3
    }

    fun err_response_already_handled() {
        abort 4
    }

    fun err_stake_request_not_fulfilled() {
        abort 0
    }

    public fun fulfill_stake<T0, T1>(arg0: &mut DegenPool<T0, T1>, arg1: StakeRequest<T0>, arg2: 0x2::coin::Coin<T1>) : StakeResponse<T0> {
        let StakeRequest {
            pool_id    : v0,
            account    : v1,
            amount     : v2,
            asset_type : v3,
            witnesses  : _,
        } = arg1;
        if (v2 != 0x2::coin::value<T1>(&arg2)) {
            err_stake_request_not_fulfilled();
        };
        0x2::balance::join<T1>(&mut arg0.balance, 0x2::coin::into_balance<T1>(arg2));
        StakeResponse<T0>{
            pool_id    : v0,
            account    : v1,
            amount     : v2,
            asset_type : v3,
            witnesses  : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        }
    }

    public fun fulfill_unstake<T0, T1>(arg0: &mut DegenPool<T0, T1>, arg1: UnstakeRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, UnstakeResponse<T0>) {
        let UnstakeRequest {
            pool_id    : v0,
            account    : v1,
            amount     : v2,
            asset_type : v3,
            witnesses  : _,
        } = arg1;
        if (0x2::balance::value<T1>(balance<T0, T1>(arg0)) < v2) {
            err_pool_balance_not_enough();
        };
        let v5 = UnstakeResponse<T0>{
            pool_id    : v0,
            account    : v1,
            amount     : v2,
            asset_type : v3,
            witnesses  : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        (0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance, v2), arg2), v5)
    }

    fun init(arg0: POOL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<POOL>(arg0, arg1);
    }

    public fun loan_by_admin<T0, T1, T2>(arg0: &mut DegenPool<T0, T1>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>, arg2: u64) : 0x1::option::Option<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Loan<DEGEN_POOL<T0>, T2, T1>> {
        0x1::option::some<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Loan<DEGEN_POOL<T0>, T2, T1>>(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::loan<DEGEN_POOL<T0>, T2, T1>(&mut arg0.sheet, 0x2::balance::split<T1>(&mut arg0.balance, arg2), stamp<T0>()))
    }

    public fun loan_by_stake_res<T0, T1, T2>(arg0: &mut DegenPool<T0, T1>, arg1: &mut StakeResponse<T0>) : 0x1::option::Option<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Loan<DEGEN_POOL<T0>, T2, T1>> {
        let v0 = 0x1::type_name::get<DEGEN_POOL<T0>>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(stake_res_witness<T0>(arg1), &v0)) {
            err_response_already_handled();
        };
        stake_res_add_witness<T0, DEGEN_POOL<T0>>(arg1, stamp<T0>());
        let v1 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debtor<T2>();
        if (!0x2::vec_map::contains<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Debtor, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Credit<T1>>(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::credits<DEGEN_POOL<T0>, T1>(sheet<T0, T1>(arg0)), &v1)) {
            err_invalid_debtor();
        };
        if (arg1.amount > 10) {
            0x1::option::some<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Loan<DEGEN_POOL<T0>, T2, T1>>(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::loan<DEGEN_POOL<T0>, T2, T1>(&mut arg0.sheet, 0x2::balance::split<T1>(&mut arg0.balance, arg1.amount), stamp<T0>()))
        } else {
            0x1::option::none<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Loan<DEGEN_POOL<T0>, T2, T1>>()
        }
    }

    public fun remove_debtor<T0, T1, T2>(arg0: &mut DegenPool<T0, T1>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>) {
        0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::remove_debtor<DEGEN_POOL<T0>, T1, T2>(&mut arg0.sheet, stamp<T0>());
    }

    public fun request_stake<T0, T1>(arg0: &DegenPool<T0, T1>, arg1: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::AccountRequest, arg2: u64) : StakeRequest<T0> {
        StakeRequest<T0>{
            pool_id    : 0x2::object::id<DegenPool<T0, T1>>(arg0),
            account    : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::destroy(arg1),
            amount     : arg2,
            asset_type : 0x1::type_name::get<T1>(),
            witnesses  : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        }
    }

    public fun request_unstake<T0, T1>(arg0: &DegenPool<T0, T1>, arg1: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::AccountRequest, arg2: u64) : UnstakeRequest<T0> {
        UnstakeRequest<T0>{
            pool_id    : 0x2::object::id<DegenPool<T0, T1>>(arg0),
            account    : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::destroy(arg1),
            amount     : arg2,
            asset_type : 0x1::type_name::get<T1>(),
            witnesses  : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        }
    }

    public fun stake_req_add_witness<T0, T1: drop>(arg0: &mut StakeRequest<T0>, arg1: T1) {
        let v0 = 0x1::type_name::get<T1>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(stake_req_witness<T0>(arg0), &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.witnesses, v0);
        };
    }

    public fun stake_req_data<T0>(arg0: &StakeRequest<T0>) : (0x2::object::ID, address, u64, 0x1::type_name::TypeName) {
        (arg0.pool_id, arg0.account, arg0.amount, arg0.asset_type)
    }

    public fun stake_req_witness<T0>(arg0: &StakeRequest<T0>) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.witnesses
    }

    public fun stake_res_add_witness<T0, T1: drop>(arg0: &mut StakeResponse<T0>, arg1: T1) {
        let v0 = 0x1::type_name::get<T1>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(stake_res_witness<T0>(arg0), &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.witnesses, v0);
        };
    }

    public fun stake_res_data<T0>(arg0: &StakeResponse<T0>) : (0x2::object::ID, address, u64, 0x1::type_name::TypeName) {
        (arg0.pool_id, arg0.account, arg0.amount, arg0.asset_type)
    }

    public fun stake_res_witness<T0>(arg0: &StakeResponse<T0>) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.witnesses
    }

    fun stamp<T0>() : DEGEN_POOL<T0> {
        DEGEN_POOL<T0>{dummy_field: false}
    }

    public fun total_value<T0, T1>(arg0: &DegenPool<T0, T1>) : u64 {
        0x2::balance::value<T1>(balance<T0, T1>(arg0)) + credit_value<T0, T1>(arg0)
    }

    public fun unstake_req_add_witness<T0, T1: drop>(arg0: &mut UnstakeRequest<T0>, arg1: T1) {
        let v0 = 0x1::type_name::get<T1>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(unstake_req_witness<T0>(arg0), &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.witnesses, v0);
        };
    }

    public fun unstake_req_data<T0>(arg0: &UnstakeRequest<T0>) : (0x2::object::ID, address, u64, 0x1::type_name::TypeName) {
        (arg0.pool_id, arg0.account, arg0.amount, arg0.asset_type)
    }

    public fun unstake_req_witness<T0>(arg0: &UnstakeRequest<T0>) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.witnesses
    }

    public fun unstake_res_add_witness<T0, T1: drop>(arg0: &mut UnstakeResponse<T0>, arg1: T1) {
        let v0 = 0x1::type_name::get<T1>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(unstake_res_witness<T0>(arg0), &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.witnesses, v0);
        };
    }

    public fun unstake_res_data<T0>(arg0: &UnstakeResponse<T0>) : (0x2::object::ID, address, u64, 0x1::type_name::TypeName) {
        (arg0.pool_id, arg0.account, arg0.amount, arg0.asset_type)
    }

    public fun unstake_res_witness<T0>(arg0: &UnstakeResponse<T0>) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.witnesses
    }

    // decompiled from Move bytecode v6
}

