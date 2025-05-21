module 0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::swap {
    public fun borrow_treasury_cap_by_admin<T0>(arg0: &0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::AdminCap, arg1: &mut 0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::ProjectRecord) : &0x2::coin::TreasuryCap<T0> {
        assert!(has_key(arg1, b"coin_type"), 103);
        treasury<T0>(arg1)
    }

    public fun borrow_treasury_cap_by_project_admin<T0>(arg0: &mut 0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::ProjectRecord, arg1: &0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::ProjectAdminCap) : &0x2::coin::TreasuryCap<T0> {
        0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::check_project_cap(arg0, arg1);
        assert!(has_key(arg0, b"coin_type"), 103);
        treasury<T0>(arg0)
    }

    public fun coin_to_sr<T0>(arg0: &mut 0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::ProjectRecord, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::SupporterReward {
        assert!(has_key(arg0, b"coin_type"), 103);
        let v0 = treasury_mut<T0>(arg0);
        let v1 = 0x2::coin::burn<T0>(v0, arg1);
        assert!(v1 > 0, 105);
        let v2 = storage_mut(arg0);
        if (0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::sr_amount(0x1::vector::borrow<0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::SupporterReward>(v2, 0)) == v1) {
            0x1::vector::pop_back<0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::SupporterReward>(v2)
        } else {
            0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::do_split(0x1::vector::borrow_mut<0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::SupporterReward>(v2, 0), v1, arg2)
        }
    }

    public fun coin_to_sr_swap<T0>(arg0: &mut 0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::ProjectRecord, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = coin_to_sr<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::SupporterReward>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun get_coin_type(arg0: &0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::ProjectRecord) : &0x1::ascii::String {
        0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::borrow_in_project<0x1::ascii::String, 0x1::ascii::String>(arg0, 0x1::ascii::string(b"coin_type"))
    }

    public fun get_total_supply<T0>(arg0: &0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::ProjectRecord) : u64 {
        0x2::coin::total_supply<T0>(0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::borrow_in_project<0x1::ascii::String, 0x2::coin::TreasuryCap<T0>>(arg0, 0x1::ascii::string(b"treasury")))
    }

    fun has_key(arg0: &0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::ProjectRecord, arg1: vector<u8>) : bool {
        0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::exists_in_project<0x1::ascii::String>(arg0, 0x1::ascii::string(arg1))
    }

    fun init_swap<T0>(arg0: &mut 0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::ProjectRecord, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin::CoinMetadata<T0>) {
        assert!(!has_key(arg0, b"coin_type"), 100);
        assert!(0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::project_begin_status(arg0), 106);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 102);
        assert!(0x2::coin::get_decimals<T0>(arg2) == 0, 101);
        0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::add_df_in_project<0x1::ascii::String, 0x1::ascii::String>(arg0, 0x1::ascii::string(b"coin_type"), 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>()));
        0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::add_df_in_project<0x1::ascii::String, 0x2::coin::TreasuryCap<T0>>(arg0, 0x1::ascii::string(b"treasury"), arg1);
        0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::add_df_in_project<0x1::ascii::String, vector<0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::SupporterReward>>(arg0, 0x1::ascii::string(b"storage_sr"), 0x1::vector::empty<0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::SupporterReward>());
    }

    public fun init_swap_by_admin<T0>(arg0: &0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::AdminCap, arg1: &mut 0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::ProjectRecord, arg2: 0x2::coin::TreasuryCap<T0>, arg3: &0x2::coin::CoinMetadata<T0>) {
        init_swap<T0>(arg1, arg2, arg3);
    }

    public fun init_swap_by_project_admin<T0>(arg0: &0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::ProjectAdminCap, arg1: &mut 0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::ProjectRecord, arg2: 0x2::coin::TreasuryCap<T0>, arg3: &0x2::coin::CoinMetadata<T0>) {
        0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::check_project_cap(arg1, arg0);
        init_swap<T0>(arg1, arg2, arg3);
    }

    public fun sr_to_coin<T0>(arg0: &mut 0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::ProjectRecord, arg1: 0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::SupporterReward, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(has_key(arg0, b"coin_type"), 103);
        assert!(0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::project_name(arg0) == 0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::sr_name(&arg1), 104);
        let v0 = storage_mut(arg0);
        if (0x1::vector::is_empty<0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::SupporterReward>(v0)) {
            0x1::vector::push_back<0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::SupporterReward>(v0, arg1);
        } else {
            0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::do_merge(0x1::vector::borrow_mut<0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::SupporterReward>(v0, 0), arg1);
        };
        0x2::coin::mint<T0>(treasury_mut<T0>(arg0), 0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::sr_amount(&arg1), arg2)
    }

    public fun sr_to_coin_swap<T0>(arg0: &mut 0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::ProjectRecord, arg1: 0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::SupporterReward, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = sr_to_coin<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    fun storage_mut(arg0: &mut 0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::ProjectRecord) : &mut vector<0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::SupporterReward> {
        0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::borrow_mut_in_project<0x1::ascii::String, vector<0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::SupporterReward>>(arg0, 0x1::ascii::string(b"storage_sr"))
    }

    fun treasury<T0>(arg0: &0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::ProjectRecord) : &0x2::coin::TreasuryCap<T0> {
        0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::borrow_in_project<0x1::ascii::String, 0x2::coin::TreasuryCap<T0>>(arg0, 0x1::ascii::string(b"treasury"))
    }

    fun treasury_mut<T0>(arg0: &mut 0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::ProjectRecord) : &mut 0x2::coin::TreasuryCap<T0> {
        0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::borrow_mut_in_project<0x1::ascii::String, 0x2::coin::TreasuryCap<T0>>(arg0, 0x1::ascii::string(b"treasury"))
    }

    // decompiled from Move bytecode v6
}

