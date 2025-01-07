module 0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py {
    struct PyStore has store, key {
        id: 0x2::object::UID,
        py: 0x2::bag::Bag,
    }

    struct FlashLoanPosition<phantom T0: drop> has store {
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
        first_py_index: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64,
        py_index_last_updated_epoch: u64,
        py_index_stored: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64,
        last_collect_interest_index: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64,
        total_sy_interest_for_treasury: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64,
        last_interest_epoch: u64,
        global_interest_index: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64,
    }

    public(friend) fun borrow_pt_amount<T0: drop>(arg0: &mut 0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::PyPosition, arg1: u64, arg2: &mut PyState<T0>, arg3: &mut 0x2::tx_context::TxContext) : (u64, FlashLoanPosition<T0>) {
        mint_py<T0>(0, arg1, arg0, arg2, arg3);
        let v0 = FlashLoanPosition<T0>{
            py_state_id : 0x2::object::id<PyState<T0>>(arg2),
            amount      : arg1,
        };
        (arg1, v0)
    }

    public(friend) fun burn_pt<T0: drop>(arg0: &mut 0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::PyPosition, arg1: &mut PyState<T0>, arg2: u64) : u64 {
        assert!(0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::pt_balance(arg0) >= arg2, 0x2851ee8f2b681f842cf9ecc1e82dec43551bf0b940eedfa03a1d50349a316797::error::invalid_py_amount());
        0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::set_pt_balance(arg0, 0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::pt_balance(arg0) - arg2);
        arg1.pt_supply = arg1.pt_supply - arg2;
        arg2
    }

    public(friend) fun burn_yt<T0: drop>(arg0: &mut 0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::PyPosition, arg1: &mut PyState<T0>, arg2: u64) : u64 {
        assert!(0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::yt_balance(arg0) >= arg2, 0x2851ee8f2b681f842cf9ecc1e82dec43551bf0b940eedfa03a1d50349a316797::error::invalid_py_amount());
        0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::set_yt_balance(arg0, 0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::yt_balance(arg0) - arg2);
        arg1.yt_supply = arg1.yt_supply - arg2;
        arg2
    }

    fun calc_interest(arg0: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64, arg1: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64, arg2: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64) : 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64 {
        0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::divDown(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::multiply(arg0, 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::sub(arg2, arg1)), 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::multiply(arg1, arg2))
    }

    public(friend) fun collect_interest<T0: drop>(arg0: bool, arg1: address, arg2: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64, arg3: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64, arg4: &mut PyState<T0>, arg5: &mut 0x2::tx_context::TxContext) : (0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64, 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64) {
        let v0 = arg4.last_collect_interest_index;
        let v1 = current_py_index<T0>(arg0, arg3, arg4, arg5);
        let v2 = 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::zero();
        if (!0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::is_zero(v0) && !0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::equal(v0, v1)) {
            let v3 = 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::one();
            if (is_distributing_interest<T0>(arg4)) {
                v3 = arg2;
            };
            let v4 = calc_interest(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::from_uint64(arg4.yt_supply), v0, v1);
            let v5 = 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::multiply(v4, v3);
            v2 = 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::sub(v4, v5);
            transfer_sy<T0>(arg1, arg4, v5, arg5);
        };
        arg4.last_collect_interest_index = v1;
        (v2, v1)
    }

    public(friend) fun create_py<T0: drop>(arg0: &mut PyStore, arg1: u64, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!py_exists(arg0, v0, arg1), 0x2851ee8f2b681f842cf9ecc1e82dec43551bf0b940eedfa03a1d50349a316797::error::py_contract_exists());
        0x2::bag::add<0x1::string::String, u64>(&mut arg0.py, get_py_id(v0, arg1), 1);
        let v1 = PyState<T0>{
            id                             : 0x2::object::new(arg3),
            expiry                         : arg1,
            name                           : arg2,
            pt_supply                      : 0,
            yt_supply                      : 0,
            sy_balance                     : 0x2::balance::zero<T0>(),
            first_py_index                 : 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::zero(),
            py_index_last_updated_epoch    : 0,
            py_index_stored                : 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::zero(),
            last_collect_interest_index    : 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::zero(),
            total_sy_interest_for_treasury : 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::zero(),
            last_interest_epoch            : 0,
            global_interest_index          : 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::zero(),
        };
        0x2::transfer::share_object<PyState<T0>>(v1);
    }

    public fun current_py_index<T0: drop>(arg0: bool, arg1: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64, arg2: &mut PyState<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64 {
        if (arg0 && arg2.py_index_last_updated_epoch == 0x2::tx_context::epoch(arg3)) {
            arg2.py_index_stored
        } else {
            let v1 = 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::max(arg1, arg2.py_index_stored);
            arg2.py_index_stored = v1;
            arg2.py_index_last_updated_epoch = 0x2::tx_context::epoch(arg3);
            v1
        }
    }

    public(friend) fun first_py_index<T0: drop>(arg0: &PyState<T0>) : 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64 {
        arg0.first_py_index
    }

    public fun get_py_amount(arg0: &0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::PyPosition) : (u64, u64) {
        (0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::pt_balance(arg0), 0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::yt_balance(arg0))
    }

    fun get_py_id(arg0: 0x1::type_name::TypeName, arg1: u64) : 0x1::string::String {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x2851ee8f2b681f842cf9ecc1e82dec43551bf0b940eedfa03a1d50349a316797::utils::vector_to_hex_string(0x1::hash::sha2_256(v0))
    }

    public fun get_py_index<T0: drop>(arg0: &mut PyState<T0>, arg1: &0x2::tx_context::TxContext) : (0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64, u64, 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64, 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64, 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64, u64, 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64) {
        (arg0.py_index_stored, arg0.py_index_last_updated_epoch, arg0.first_py_index, arg0.last_collect_interest_index, arg0.total_sy_interest_for_treasury, arg0.last_interest_epoch, arg0.global_interest_index)
    }

    public fun get_sy_amount_in_for_exact_py_out<T0: drop>(arg0: u64, arg1: bool, arg2: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64, arg3: &mut PyState<T0>, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::truncate_up(0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::sy::asset_to_sy(current_py_index<T0>(arg1, arg2, arg3, arg4), 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::from_uint64(arg0)))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PyStore{
            id : 0x2::object::new(arg0),
            py : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<PyStore>(v0);
    }

    public fun init_py_position<T0: drop>(arg0: &0x2851ee8f2b681f842cf9ecc1e82dec43551bf0b940eedfa03a1d50349a316797::version::Version, arg1: &PyState<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::PyPosition {
        0x2851ee8f2b681f842cf9ecc1e82dec43551bf0b940eedfa03a1d50349a316797::version::assert_current_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::mint(0x2::object::id<PyState<T0>>(arg1), 0x1::string::from_ascii(0x1::type_name::get_module(&v0)), arg1.expiry, arg2)
    }

    public(friend) fun is_distributing_interest<T0: drop>(arg0: &mut PyState<T0>) : bool {
        0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::is_zero(arg0.first_py_index)
    }

    public(friend) fun join_pt(arg0: &mut 0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::PyPosition, arg1: u64) {
        0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::set_pt_balance(arg0, 0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::pt_balance(arg0) + arg1);
    }

    public(friend) fun join_sy<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: &mut PyState<T0>, arg2: &0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg1.sy_balance, 0x2::coin::into_balance<T0>(arg0));
    }

    public(friend) fun join_yt(arg0: &mut 0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::PyPosition, arg1: u64) {
        0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::set_yt_balance(arg0, 0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::yt_balance(arg0) + arg1);
    }

    public(friend) fun mint_py<T0: drop>(arg0: u64, arg1: u64, arg2: &mut 0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::PyPosition, arg3: &mut PyState<T0>, arg4: &0x2::tx_context::TxContext) {
        arg3.pt_supply = arg3.pt_supply + arg1;
        arg3.yt_supply = arg3.yt_supply + arg0;
        0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::set_pt_balance(arg2, 0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::pt_balance(arg2) + arg1);
        0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::set_yt_balance(arg2, 0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::yt_balance(arg2) + arg0);
    }

    public(friend) fun py_exists(arg0: &PyStore, arg1: 0x1::type_name::TypeName, arg2: u64) : bool {
        0x2::bag::contains<0x1::string::String>(&arg0.py, get_py_id(arg1, arg2))
    }

    public(friend) fun py_expiry(arg0: &0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::PyPosition) : u64 {
        0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::expiry(arg0)
    }

    public(friend) fun py_state_expiry<T0: drop>(arg0: &PyState<T0>) : u64 {
        arg0.expiry
    }

    public(friend) fun py_state_id(arg0: &0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::PyPosition) : 0x2::object::ID {
        0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::py_state_id(arg0)
    }

    public(friend) fun redeem_due_interest<T0: drop>(arg0: address, arg1: &mut 0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::PyPosition, arg2: &mut PyState<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64 {
        let v0 = 0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::accured(arg1);
        transfer_sy<T0>(arg0, arg2, v0, arg3);
        0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::set_accured(arg1, 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::zero());
        v0
    }

    public(friend) fun repay_pt_amount<T0: drop>(arg0: &mut 0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::PyPosition, arg1: &mut PyState<T0>, arg2: FlashLoanPosition<T0>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg2.py_state_id == 0x2::object::id<PyState<T0>>(arg1), 0x2851ee8f2b681f842cf9ecc1e82dec43551bf0b940eedfa03a1d50349a316797::error::invalid_flash_loan_position());
        assert!(0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::py_state_id(arg0) == arg2.py_state_id, 0x2851ee8f2b681f842cf9ecc1e82dec43551bf0b940eedfa03a1d50349a316797::error::invalid_flash_loan_position());
        burn_pt<T0>(arg0, arg1, arg2.amount);
        let FlashLoanPosition {
            py_state_id : _,
            amount      : v1,
        } = arg2;
        v1
    }

    public(friend) fun set_post_expiry_data<T0: drop>(arg0: bool, arg1: address, arg2: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64, arg3: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64, arg4: &mut PyState<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        if (!0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::is_zero(arg4.first_py_index)) {
            return
        };
        let (_, _) = update_interest_index<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v2 = current_py_index<T0>(arg0, arg3, arg4, arg5);
        arg4.first_py_index = v2;
    }

    public(friend) fun split_pt(arg0: &mut 0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::PyPosition, arg1: u64) : u64 {
        0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::set_pt_balance(arg0, 0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::pt_balance(arg0) - arg1);
        arg1
    }

    public(friend) fun split_sy<T0: drop>(arg0: u64, arg1: &mut PyState<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.sy_balance, arg0), arg2)
    }

    public(friend) fun split_yt(arg0: &mut 0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::PyPosition, arg1: u64) : u64 {
        0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::set_yt_balance(arg0, 0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::yt_balance(arg0) - arg1);
        arg1
    }

    public(friend) fun transfer_sy<T0: drop>(arg0: address, arg1: &mut PyState<T0>, arg2: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.sy_balance, 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::truncate(arg2)), arg3), arg0);
    }

    public(friend) fun update_interest_index<T0: drop>(arg0: bool, arg1: address, arg2: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64, arg3: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64, arg4: &mut PyState<T0>, arg5: &mut 0x2::tx_context::TxContext) : (0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64, 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64) {
        if (arg4.last_interest_epoch != 0x2::tx_context::epoch(arg5)) {
            arg4.last_interest_epoch = 0x2::tx_context::epoch(arg5);
            let v2 = arg4.yt_supply;
            let (v3, v4) = collect_interest<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
            let v5 = arg4.global_interest_index;
            let v6 = v5;
            if (0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::is_zero(v5)) {
                v6 = 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::one();
            };
            if (v2 != 0) {
                v6 = 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::add(v6, 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::divDown(v3, 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::from_uint64(v2)));
            };
            arg4.global_interest_index = v6;
            (v6, v4)
        } else {
            (arg4.global_interest_index, arg4.py_index_stored)
        }
    }

    public(friend) fun update_user_interest<T0: drop>(arg0: bool, arg1: address, arg2: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64, arg3: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64, arg4: &mut 0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::PyPosition, arg5: &mut PyState<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = update_interest_index<T0>(arg0, arg1, arg2, arg3, arg5, arg6);
        let v2 = 0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::index(arg4);
        if (0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::equal(v2, v0)) {
            return
        };
        if (0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::is_zero(v2)) {
            0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::set_index(arg4, v0);
            0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::set_py_index(arg4, v1);
            return
        };
        0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::set_index(arg4, v0);
        0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::set_py_index(arg4, v1);
        0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::set_accured(arg4, 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::add(0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::accured(arg4), 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::multiply(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::from_uint64(0x6c1c83c6fc163cc73ec53698d69dd96cfff378435e7f731d988a4332d9268ea::py_position::yt_balance(arg4)), 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::sub(v0, v2))));
    }

    // decompiled from Move bytecode v6
}

