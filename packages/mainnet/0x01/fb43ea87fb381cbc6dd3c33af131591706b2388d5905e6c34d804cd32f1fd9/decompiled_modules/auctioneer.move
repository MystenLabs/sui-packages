module 0x1fb43ea87fb381cbc6dd3c33af131591706b2388d5905e6c34d804cd32f1fd9::auctioneer {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalState has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: 0x2::object::ID,
        fee_vault: 0x2::balance::Balance<0x2::sui::SUI>,
        fee_operators: vector<address>,
    }

    public entry fun add_fee_operator(arg0: &mut GlobalState, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        ensure_global_state(arg0);
        assert!(arg0.admin == 0x2::object::id<AdminCap>(arg1), 403);
        0x1::vector::push_back<address>(&mut arg0.fee_operators, arg2);
    }

    public fun collect_fee(arg0: &mut GlobalState, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        ensure_global_state(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.fee_operators, &v0), 403);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.fee_vault, arg1), arg2)
    }

    fun ensure_global_state(arg0: &GlobalState) {
        assert!(arg0.version <= 1, 400);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, 0x2::tx_context::sender(arg0));
        let v2 = GlobalState{
            id            : 0x2::object::new(arg0),
            version       : 1,
            admin         : 0x2::object::id<AdminCap>(&v0),
            fee_vault     : 0x2::balance::zero<0x2::sui::SUI>(),
            fee_operators : v1,
        };
        0x2::transfer::share_object<GlobalState>(v2);
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun new_global_state(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalState{
            id            : 0x2::object::new(arg1),
            version       : 1,
            admin         : 0x2::object::id<AdminCap>(arg0),
            fee_vault     : 0x2::balance::zero<0x2::sui::SUI>(),
            fee_operators : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<GlobalState>(v0);
    }

    entry fun remove_fee_operator(arg0: &mut GlobalState, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        ensure_global_state(arg0);
        assert!(arg0.admin == 0x2::object::id<AdminCap>(arg1), 403);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.fee_operators, &arg2);
        assert!(v0, 500);
        0x1::vector::remove<address>(&mut arg0.fee_operators, v1);
    }

    public fun submit_bid(arg0: &mut GlobalState, arg1: u64, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        ensure_global_state(arg0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg2) >= arg1, 506);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_vault, arg2);
    }

    // decompiled from Move bytecode v6
}

