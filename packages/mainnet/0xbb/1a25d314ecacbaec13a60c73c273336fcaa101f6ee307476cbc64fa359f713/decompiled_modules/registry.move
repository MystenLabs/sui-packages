module 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::registry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        predict_id: 0x1::option::Option<0x2::object::ID>,
        oracle_ids: 0x2::table::Table<0x2::object::ID, vector<0x2::object::ID>>,
        trading_paused: bool,
        withdrawals_paused: bool,
    }

    public fun create_oracle<T0>(arg0: &mut Registry, arg1: &AdminCap, arg2: &0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::OracleCapSVI, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::create_oracle<T0>(arg2, arg3, arg4);
        let v1 = 0x2::object::id<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::OracleCapSVI>(arg2);
        if (!0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(&arg0.oracle_ids, v1)) {
            0x2::table::add<0x2::object::ID, vector<0x2::object::ID>>(&mut arg0.oracle_ids, v1, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<0x2::object::ID, vector<0x2::object::ID>>(&mut arg0.oracle_ids, v1), v0);
        v0
    }

    public fun create_oracle_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::OracleCapSVI {
        0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::create_oracle_cap(arg1)
    }

    public fun create_predict<T0>(arg0: &mut Registry, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.predict_id), 0);
        let v0 = 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::predict::create<T0>(arg2);
        arg0.predict_id = 0x1::option::some<0x2::object::ID>(v0);
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id                 : 0x2::object::new(arg0),
            predict_id         : 0x1::option::none<0x2::object::ID>(),
            oracle_ids         : 0x2::table::new<0x2::object::ID, vector<0x2::object::ID>>(arg0),
            trading_paused     : false,
            withdrawals_paused : false,
        };
        0x2::transfer::share_object<Registry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun is_trading_paused(arg0: &Registry) : bool {
        arg0.trading_paused
    }

    public(friend) fun is_withdrawals_paused(arg0: &Registry) : bool {
        arg0.withdrawals_paused
    }

    // decompiled from Move bytecode v6
}

