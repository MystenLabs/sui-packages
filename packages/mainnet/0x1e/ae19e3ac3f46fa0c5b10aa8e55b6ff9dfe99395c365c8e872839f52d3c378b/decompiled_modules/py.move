module 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py {
    struct PyStore has store, key {
        id: 0x2::object::UID,
        py: 0x2::bag::Bag,
    }

    struct FlashLoanPosition<phantom T0: drop> has store {
        py_state_id: 0x2::object::ID,
        amount: u64,
    }

    struct PyPosition has store, key {
        id: 0x2::object::UID,
        py_state_id: 0x2::object::ID,
        name: 0x1::ascii::String,
        description: 0x1::ascii::String,
        url: 0x1::ascii::String,
        pt_balance: u64,
        yt_balance: u64,
        expiry: u64,
        index: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64,
        py_index: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64,
        accured: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64,
    }

    struct PyState<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        expiry: u64,
        name: 0x1::ascii::String,
        description: 0x1::ascii::String,
        url: 0x1::ascii::String,
        pt_supply: u64,
        yt_supply: u64,
        sy_balance: 0x2::balance::Balance<T0>,
        first_py_index: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64,
        py_index_last_updated_epoch: u64,
        py_index_stored: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64,
        last_collect_interest_index: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64,
        total_sy_interest_for_treasury: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64,
        last_interest_epoch: u64,
        global_interest_index: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64,
    }

    public(friend) fun borrow_pt_amount<T0: drop>(arg0: &mut PyPosition, arg1: u64, arg2: &mut PyState<T0>, arg3: &mut 0x2::tx_context::TxContext) : (u64, FlashLoanPosition<T0>) {
        mint_py<T0>(arg1, 0, arg0, arg2, arg3);
        let v0 = FlashLoanPosition<T0>{
            py_state_id : 0x2::object::id<PyState<T0>>(arg2),
            amount      : arg1,
        };
        (arg1, v0)
    }

    public(friend) fun burn_pt<T0: drop>(arg0: &mut PyPosition, arg1: &mut PyState<T0>, arg2: u64) : u64 {
        assert!(arg0.pt_balance >= arg2, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::invalid_py_amount());
        arg0.pt_balance = arg0.pt_balance - arg2;
        arg1.pt_supply = arg1.pt_supply - arg2;
        arg2
    }

    public(friend) fun burn_yt<T0: drop>(arg0: &mut PyPosition, arg1: &mut PyState<T0>, arg2: u64) : u64 {
        assert!(arg0.yt_balance >= arg2, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::invalid_py_amount());
        arg0.yt_balance = arg0.yt_balance - arg2;
        arg1.yt_supply = arg1.yt_supply - arg2;
        arg2
    }

    fun calc_interest(arg0: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64, arg1: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64, arg2: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64) : 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64 {
        0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::divDown(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::multiply(arg0, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::sub(arg2, arg1)), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::multiply(arg1, arg2))
    }

    public(friend) fun collect_interest<T0: drop>(arg0: bool, arg1: address, arg2: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64, arg3: &mut PyState<T0>, arg4: &mut 0x2::tx_context::TxContext) : (0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64) {
        let v0 = arg3.last_collect_interest_index;
        let v1 = current_py_index<T0>(arg0, arg3, arg4);
        let v2 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::zero();
        if (!0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::is_zero(v0) && !0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::equal(v0, v1)) {
            let v3 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::one();
            if (is_distributing_interest<T0>(arg3)) {
                v3 = arg2;
            };
            let v4 = calc_interest(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::from_uint64(arg3.yt_supply), v0, v1);
            let v5 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::multiply(v4, v3);
            v2 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::sub(v4, v5);
            transfer_sy<T0>(arg1, arg3, v5, arg4);
        };
        arg3.last_collect_interest_index = v1;
        (v2, v1)
    }

    public(friend) fun create_py<T0: drop>(arg0: &mut PyStore, arg1: u64, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.py, v0)) {
            assert!(arg1 != *0x2::bag::borrow<0x1::type_name::TypeName, u64>(&arg0.py, v0), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::py_contract_exists());
        };
        0x2::bag::add<0x1::type_name::TypeName, u64>(&mut arg0.py, v0, arg1);
        let v1 = PyState<T0>{
            id                             : 0x2::object::new(arg5),
            expiry                         : arg1,
            name                           : arg2,
            description                    : arg3,
            url                            : arg4,
            pt_supply                      : 0,
            yt_supply                      : 0,
            sy_balance                     : 0x2::balance::zero<T0>(),
            first_py_index                 : 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::zero(),
            py_index_last_updated_epoch    : 0,
            py_index_stored                : 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::zero(),
            last_collect_interest_index    : 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::zero(),
            total_sy_interest_for_treasury : 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::zero(),
            last_interest_epoch            : 0,
            global_interest_index          : 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::zero(),
        };
        0x2::transfer::share_object<PyState<T0>>(v1);
    }

    public fun current_py_index<T0: drop>(arg0: bool, arg1: &mut PyState<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64 {
        if (arg0 && arg1.py_index_last_updated_epoch == 0x2::tx_context::epoch(arg2)) {
            arg1.py_index_stored
        } else {
            let v1 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::max(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::oracle::get_exchange_rate<T0>(arg2), arg1.py_index_stored);
            arg1.py_index_stored = v1;
            arg1.py_index_last_updated_epoch = 0x2::tx_context::epoch(arg2);
            v1
        }
    }

    public(friend) fun first_py_index<T0: drop>(arg0: &mut PyState<T0>) : 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64 {
        arg0.first_py_index
    }

    public fun get_py_amount(arg0: &PyPosition) : (u64, u64) {
        (arg0.pt_balance, arg0.yt_balance)
    }

    public fun get_py_index<T0: drop>(arg0: &mut PyState<T0>, arg1: &0x2::tx_context::TxContext) : (0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64, u64, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64, u64, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64) {
        (arg0.py_index_stored, arg0.py_index_last_updated_epoch, arg0.first_py_index, arg0.last_collect_interest_index, arg0.total_sy_interest_for_treasury, arg0.last_interest_epoch, arg0.global_interest_index)
    }

    public fun get_sy_amount_in_for_exact_py_out<T0: drop>(arg0: u64, arg1: bool, arg2: &mut PyState<T0>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::truncate(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::sy::asset_to_sy(current_py_index<T0>(arg1, arg2, arg3), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::from_uint64(arg0)))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PyStore{
            id : 0x2::object::new(arg0),
            py : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<PyStore>(v0);
    }

    public fun init_py_position<T0: drop>(arg0: &PyState<T0>, arg1: &mut 0x2::tx_context::TxContext) : PyPosition {
        PyPosition{
            id          : 0x2::object::new(arg1),
            py_state_id : 0x2::object::id<PyState<T0>>(arg0),
            name        : arg0.name,
            description : arg0.description,
            url         : arg0.url,
            pt_balance  : 0,
            yt_balance  : 0,
            expiry      : arg0.expiry,
            index       : 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::zero(),
            py_index    : 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::zero(),
            accured     : 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::zero(),
        }
    }

    public(friend) fun is_distributing_interest<T0: drop>(arg0: &mut PyState<T0>) : bool {
        0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::is_zero(arg0.first_py_index)
    }

    public(friend) fun join_pt(arg0: &mut PyPosition, arg1: u64) {
        arg0.pt_balance = arg0.pt_balance + arg1;
    }

    public(friend) fun join_sy<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: &mut PyState<T0>, arg2: &0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg1.sy_balance, 0x2::coin::into_balance<T0>(arg0));
    }

    public(friend) fun join_yt(arg0: &mut PyPosition, arg1: u64) {
        arg0.yt_balance = arg0.yt_balance + arg1;
    }

    public(friend) fun mint_py<T0: drop>(arg0: u64, arg1: u64, arg2: &mut PyPosition, arg3: &mut PyState<T0>, arg4: &0x2::tx_context::TxContext) {
        arg3.pt_supply = arg3.pt_supply + arg1;
        arg3.yt_supply = arg3.yt_supply + arg0;
        arg2.pt_balance = arg2.pt_balance + arg1;
        arg2.yt_balance = arg2.yt_balance + arg0;
    }

    public(friend) fun py_exists(arg0: &PyStore, arg1: 0x1::type_name::TypeName, arg2: u64) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&arg0.py, arg1) && 0x2::bag::borrow<0x1::type_name::TypeName, u64>(&arg0.py, arg1) == &arg2
    }

    public(friend) fun py_expiry(arg0: &PyPosition) : u64 {
        arg0.expiry
    }

    public(friend) fun py_state_expiry<T0: drop>(arg0: &PyState<T0>) : u64 {
        arg0.expiry
    }

    public(friend) fun py_state_id(arg0: &PyPosition) : 0x2::object::ID {
        arg0.py_state_id
    }

    public(friend) fun redeem_due_interest<T0: drop>(arg0: address, arg1: &mut PyPosition, arg2: &mut PyState<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64 {
        let v0 = arg1.accured;
        transfer_sy<T0>(arg0, arg2, v0, arg3);
        arg1.accured = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::zero();
        v0
    }

    public(friend) fun repay_pt_amount<T0: drop>(arg0: &mut PyPosition, arg1: &mut PyState<T0>, arg2: FlashLoanPosition<T0>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg2.py_state_id == 0x2::object::id<PyState<T0>>(arg1), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::invalid_flash_loan_position());
        assert!(arg0.py_state_id == arg2.py_state_id, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::invalid_flash_loan_position());
        burn_pt<T0>(arg0, arg1, arg2.amount);
        let FlashLoanPosition {
            py_state_id : _,
            amount      : v1,
        } = arg2;
        v1
    }

    public(friend) fun set_post_expiry_data<T0: drop>(arg0: bool, arg1: address, arg2: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64, arg3: &mut PyState<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        if (!0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::is_zero(arg3.first_py_index)) {
            return
        };
        let (_, _) = update_interest_index<T0>(arg0, arg1, arg2, arg3, arg4);
        let v2 = current_py_index<T0>(arg0, arg3, arg4);
        arg3.first_py_index = v2;
    }

    public(friend) fun split_pt(arg0: &mut PyPosition, arg1: u64) : u64 {
        arg0.pt_balance = arg0.pt_balance - arg1;
        arg1
    }

    public(friend) fun split_sy<T0: drop>(arg0: u64, arg1: &mut PyState<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.sy_balance, arg0), arg2)
    }

    public(friend) fun split_yt(arg0: &mut PyPosition, arg1: u64) : u64 {
        arg0.yt_balance = arg0.yt_balance - arg1;
        arg1
    }

    public(friend) fun transfer_sy<T0: drop>(arg0: address, arg1: &mut PyState<T0>, arg2: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.sy_balance, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::truncate(arg2)), arg3), arg0);
    }

    public(friend) fun update_interest_index<T0: drop>(arg0: bool, arg1: address, arg2: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64, arg3: &mut PyState<T0>, arg4: &mut 0x2::tx_context::TxContext) : (0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64) {
        if (arg3.last_interest_epoch != 0x2::tx_context::epoch(arg4)) {
            arg3.last_interest_epoch = 0x2::tx_context::epoch(arg4);
            let v0 = arg3.yt_supply;
            let (v1, _) = collect_interest<T0>(arg0, arg1, arg2, arg3, arg4);
            let v3 = arg3.global_interest_index;
            let v4 = v3;
            if (0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::is_zero(v3)) {
                v4 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::one();
            };
            if (v0 != 0) {
                v4 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::add(v4, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::divDown(v1, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::from_uint64(v0)));
            };
            arg3.global_interest_index = v4;
        };
        (arg3.global_interest_index, arg3.py_index_stored)
    }

    public(friend) fun update_user_interest<T0: drop>(arg0: bool, arg1: address, arg2: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64, arg3: &mut PyPosition, arg4: &mut PyState<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = update_interest_index<T0>(arg0, arg1, arg2, arg4, arg5);
        let v2 = arg3.index;
        if (0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::equal(v2, v0)) {
            return
        };
        if (0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::is_zero(v2)) {
            arg3.index = v0;
            arg3.py_index = v1;
            return
        };
        arg3.index = v0;
        arg3.py_index = v1;
        arg3.accured = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::multiply(arg3.accured, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::sub(v0, v2));
    }

    // decompiled from Move bytecode v6
}

