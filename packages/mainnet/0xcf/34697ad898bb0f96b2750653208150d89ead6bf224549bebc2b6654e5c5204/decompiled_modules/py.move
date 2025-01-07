module 0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py {
    struct PyStore has store, key {
        id: 0x2::object::UID,
        py: 0x2::bag::Bag,
    }

    struct FlashLoanPosition<phantom T0: drop> {
        py_state_id: 0x2::object::ID,
        amount: u64,
    }

    struct PyState<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        expiry: u64,
        name: 0x1::ascii::String,
        pt_supply: u64,
        yt_supply: u64,
        sy_balance: 0x2::balance::Balance<T0>,
        first_py_index: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64,
        py_index_last_updated_timestamp: u64,
        py_index_stored: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64,
        last_collect_interest_index: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64,
        total_sy_interest_for_treasury: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64,
        last_interest_timestamp: u64,
        global_interest_index: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64,
    }

    public fun borrow_pt_amount<T0: drop>(arg0: &mut 0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::PyPosition, arg1: u64, arg2: &mut PyState<T0>, arg3: &0x2::clock::Clock) : (u64, FlashLoanPosition<T0>) {
        mint_py<T0>(0, arg1, arg0, arg2, arg3);
        let v0 = FlashLoanPosition<T0>{
            py_state_id : 0x2::object::id<PyState<T0>>(arg2),
            amount      : arg1,
        };
        (arg1, v0)
    }

    public(friend) fun burn_py<T0: drop>(arg0: u64, arg1: u64, arg2: &mut 0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::PyPosition, arg3: &mut PyState<T0>, arg4: &0x2::clock::Clock) {
        assert!(0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::pt_balance(arg2) >= arg0 && arg3.pt_supply >= arg0, 0x10c80c1f644a0b53574488dafeead39629edd9debae9a94a10c425ef1c9dcd29::error::invalid_py_amount());
        assert!(0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::yt_balance(arg2) >= arg1 && arg3.yt_supply >= arg1, 0x10c80c1f644a0b53574488dafeead39629edd9debae9a94a10c425ef1c9dcd29::error::invalid_py_amount());
        arg3.pt_supply = arg3.pt_supply - arg0;
        arg3.yt_supply = arg3.yt_supply - arg1;
        0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::set_pt_balance(arg2, 0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::pt_balance(arg2) - arg0, arg4);
        0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::set_yt_balance(arg2, 0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::yt_balance(arg2) - arg1, arg4);
    }

    fun calc_interest(arg0: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, arg1: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, arg2: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64) : 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64 {
        0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::divDown(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::multiply(arg0, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::sub(arg2, arg1)), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::multiply(arg1, arg2))
    }

    public(friend) fun collect_interest<T0: drop>(arg0: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, arg1: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, arg2: &mut PyState<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64) {
        let v0 = arg2.last_collect_interest_index;
        let v1 = current_py_index<T0>(arg1, arg2, arg3);
        let v2 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::zero();
        let v3 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::zero();
        if (!0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::is_zero(v0) && !0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::equal(v0, v1)) {
            let v4 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::one();
            if (is_distributing_interest<T0>(arg2)) {
                v4 = arg0;
            };
            let v5 = calc_interest(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::from_uint64(arg2.yt_supply), v0, v1);
            let v6 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::multiply(v5, v4);
            v2 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::sub(v5, v6);
            v3 = v6;
        };
        arg2.last_collect_interest_index = v1;
        (v2, v1, v3)
    }

    public(friend) fun create_py<T0: drop>(arg0: &mut PyStore, arg1: u64, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!py_exists(arg0, v0, arg1), 0x10c80c1f644a0b53574488dafeead39629edd9debae9a94a10c425ef1c9dcd29::error::py_contract_exists());
        0x2::bag::add<0x1::string::String, u64>(&mut arg0.py, get_py_id(v0, arg1), 1);
        let v1 = PyState<T0>{
            id                              : 0x2::object::new(arg3),
            expiry                          : arg1,
            name                            : arg2,
            pt_supply                       : 0,
            yt_supply                       : 0,
            sy_balance                      : 0x2::balance::zero<T0>(),
            first_py_index                  : 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::zero(),
            py_index_last_updated_timestamp : 0,
            py_index_stored                 : 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::zero(),
            last_collect_interest_index     : 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::zero(),
            total_sy_interest_for_treasury  : 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::zero(),
            last_interest_timestamp         : 0,
            global_interest_index           : 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::zero(),
        };
        0x2::transfer::share_object<PyState<T0>>(v1);
    }

    public(friend) fun current_py_index<T0: drop>(arg0: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, arg1: &mut PyState<T0>, arg2: &0x2::clock::Clock) : 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64 {
        let v0 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::max(arg0, arg1.py_index_stored);
        arg1.py_index_stored = v0;
        arg1.py_index_last_updated_timestamp = 0x2::clock::timestamp_ms(arg2);
        v0
    }

    public fun expiry<T0: drop>(arg0: &PyState<T0>) : u64 {
        arg0.expiry
    }

    public(friend) fun first_py_index<T0: drop>(arg0: &PyState<T0>) : 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64 {
        arg0.first_py_index
    }

    public fun get_py_id(arg0: 0x1::type_name::TypeName, arg1: u64) : 0x1::string::String {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x10c80c1f644a0b53574488dafeead39629edd9debae9a94a10c425ef1c9dcd29::utils::vector_to_hex_string(0x1::hash::sha2_256(v0))
    }

    public fun get_py_index<T0: drop>(arg0: &PyState<T0>) : (0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, u64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, u64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64) {
        (arg0.py_index_stored, arg0.py_index_last_updated_timestamp, arg0.first_py_index, arg0.last_collect_interest_index, arg0.total_sy_interest_for_treasury, arg0.last_interest_timestamp, arg0.global_interest_index)
    }

    public fun get_sy_amount_in_for_exact_py_out<T0: drop>(arg0: u64, arg1: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, arg2: &mut PyState<T0>, arg3: &0x2::clock::Clock) : u64 {
        0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::truncate_up(0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::sy::asset_to_sy(current_py_index<T0>(arg1, arg2, arg3), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::from_uint64(arg0)))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PyStore{
            id : 0x2::object::new(arg0),
            py : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<PyStore>(v0);
    }

    public fun init_py_position<T0: drop>(arg0: &0x10c80c1f644a0b53574488dafeead39629edd9debae9a94a10c425ef1c9dcd29::version::Version, arg1: &PyState<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::PyPosition {
        0x10c80c1f644a0b53574488dafeead39629edd9debae9a94a10c425ef1c9dcd29::version::assert_current_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::mint(0x2::object::id<PyState<T0>>(arg1), 0x1::string::from_ascii(0x1::type_name::get_module(&v0)), arg1.expiry, arg2, arg3)
    }

    public(friend) fun is_distributing_interest<T0: drop>(arg0: &PyState<T0>) : bool {
        0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::is_zero(arg0.first_py_index)
    }

    public(friend) fun join_pt(arg0: &mut 0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::PyPosition, arg1: u64, arg2: &0x2::clock::Clock) {
        0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::set_pt_balance(arg0, 0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::pt_balance(arg0) + arg1, arg2);
    }

    public(friend) fun join_sy<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: &mut PyState<T0>) {
        0x2::balance::join<T0>(&mut arg1.sy_balance, 0x2::coin::into_balance<T0>(arg0));
    }

    public(friend) fun join_yt(arg0: &mut 0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::PyPosition, arg1: u64, arg2: &0x2::clock::Clock) {
        0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::set_yt_balance(arg0, 0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::yt_balance(arg0) + arg1, arg2);
    }

    public(friend) fun mint_py<T0: drop>(arg0: u64, arg1: u64, arg2: &mut 0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::PyPosition, arg3: &mut PyState<T0>, arg4: &0x2::clock::Clock) {
        arg3.pt_supply = arg3.pt_supply + arg1;
        arg3.yt_supply = arg3.yt_supply + arg0;
        0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::set_pt_balance(arg2, 0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::pt_balance(arg2) + arg1, arg4);
        0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::set_yt_balance(arg2, 0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::yt_balance(arg2) + arg0, arg4);
    }

    public fun py_exists(arg0: &PyStore, arg1: 0x1::type_name::TypeName, arg2: u64) : bool {
        0x2::bag::contains<0x1::string::String>(&arg0.py, get_py_id(arg1, arg2))
    }

    public(friend) fun redeem_due_interest<T0: drop>(arg0: &mut 0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::PyPosition, arg1: &mut PyState<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::set_accured(arg0, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::zero());
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.sy_balance, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::truncate(0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::accured(arg0))), arg2)
    }

    public fun repay_pt_amount<T0: drop>(arg0: &mut 0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::PyPosition, arg1: &mut PyState<T0>, arg2: FlashLoanPosition<T0>, arg3: &0x2::clock::Clock) : u64 {
        assert!(0x2::object::id<PyState<T0>>(arg1) == arg2.py_state_id, 0x10c80c1f644a0b53574488dafeead39629edd9debae9a94a10c425ef1c9dcd29::error::invalid_py_amount());
        burn_py<T0>(arg2.amount, 0, arg0, arg1, arg3);
        let FlashLoanPosition {
            py_state_id : _,
            amount      : v1,
        } = arg2;
        v1
    }

    public(friend) fun set_post_expiry_data<T0: drop>(arg0: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, arg1: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, arg2: &mut PyState<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64 {
        if (!0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::is_zero(arg2.first_py_index)) {
            return 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::zero()
        };
        let (_, _, v2) = update_interest_index<T0>(arg0, arg1, arg2, arg3, arg4);
        let v3 = current_py_index<T0>(arg1, arg2, arg3);
        arg2.first_py_index = v3;
        v2
    }

    public(friend) fun split_pt(arg0: &mut 0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::PyPosition, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        assert!(0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::pt_balance(arg0) >= arg1, 0x10c80c1f644a0b53574488dafeead39629edd9debae9a94a10c425ef1c9dcd29::error::invalid_py_amount());
        0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::set_pt_balance(arg0, 0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::pt_balance(arg0) - arg1, arg2);
        arg1
    }

    public(friend) fun split_sy<T0: drop>(arg0: u64, arg1: &mut PyState<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.sy_balance, arg0), arg2)
    }

    public(friend) fun split_sy_balance<T0: drop>(arg0: &mut PyState<T0>, arg1: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.sy_balance, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::truncate(arg1))
    }

    public(friend) fun split_yt(arg0: &mut 0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::PyPosition, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        assert!(0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::yt_balance(arg0) >= arg1, 0x10c80c1f644a0b53574488dafeead39629edd9debae9a94a10c425ef1c9dcd29::error::invalid_py_amount());
        0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::set_yt_balance(arg0, 0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::yt_balance(arg0) - arg1, arg2);
        arg1
    }

    public(friend) fun transfer_sy<T0: drop>(arg0: address, arg1: &mut PyState<T0>, arg2: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.sy_balance, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::truncate(arg2)), arg3), arg0);
    }

    public(friend) fun update_interest_index<T0: drop>(arg0: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, arg1: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, arg2: &mut PyState<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64) {
        arg2.last_interest_timestamp = 0x2::clock::timestamp_ms(arg3);
        let v0 = arg2.yt_supply;
        let (v1, v2, v3) = collect_interest<T0>(arg0, arg1, arg2, arg3, arg4);
        let v4 = arg2.global_interest_index;
        let v5 = v4;
        if (0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::is_zero(v4)) {
            v5 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::one();
        };
        if (v0 != 0) {
            v5 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::add(v5, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::divDown(v1, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::from_uint64(v0)));
        };
        arg2.global_interest_index = v5;
        (v5, v2, v3)
    }

    public(friend) fun update_user_interest<T0: drop>(arg0: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, arg1: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64, arg2: &mut 0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::PyPosition, arg3: &mut PyState<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64 {
        let (v0, v1, v2) = update_interest_index<T0>(arg0, arg1, arg3, arg4, arg5);
        let v3 = 0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::index(arg2);
        if (0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::equal(v3, v0)) {
            return v2
        };
        if (0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::is_zero(v3)) {
            0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::set_index(arg2, v0);
            0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::set_py_index(arg2, v1);
            return v2
        };
        0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::set_index(arg2, v0);
        0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::set_py_index(arg2, v1);
        0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::set_accured(arg2, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::add(0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::accured(arg2), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::multiply(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::from_uint64(0x84d66b2822b810cbacc482490b2b00aa2fa9ba51186fae2bf8c2f2d2b1d3abe0::py_position::yt_balance(arg2)), 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::sub(v0, v3))));
        v2
    }

    // decompiled from Move bytecode v6
}

