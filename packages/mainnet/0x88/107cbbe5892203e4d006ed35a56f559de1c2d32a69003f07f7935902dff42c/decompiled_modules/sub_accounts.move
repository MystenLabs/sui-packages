module 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::sub_accounts {
    struct SubAccountUpdateEvent has copy, drop {
        account: address,
        sub_account: address,
        status: bool,
    }

    struct TxIndexerCreationEvent has copy, drop {
        id: 0x2::object::ID,
    }

    struct SubAccounts has key {
        id: 0x2::object::UID,
        map: 0x2::table::Table<address, 0x2::vec_set::VecSet<address>>,
    }

    struct TxIndexer has key {
        id: 0x2::object::UID,
        counter: u128,
        map: 0x2::table::Table<vector<u8>, bool>,
    }

    entry fun create_tx_indexer(arg0: &0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::protocol::ProtocolConfig, arg1: &0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::roles::ExchangeManagerCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::protocol::check_basic(arg0);
        0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::roles::check_manager_validity(arg0, arg1);
        let v0 = TxIndexer{
            id      : 0x2::object::new(arg2),
            counter : 0,
            map     : 0x2::table::new<vector<u8>, bool>(arg2),
        };
        let v1 = TxIndexerCreationEvent{id: 0x2::object::uid_to_inner(&v0.id)};
        0x2::event::emit<TxIndexerCreationEvent>(v1);
        0x2::transfer::share_object<TxIndexer>(v0);
    }

    public(friend) fun increment_tx_index(arg0: &mut TxIndexer) : u128 {
        arg0.counter = arg0.counter + 1;
        arg0.counter
    }

    public(friend) fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SubAccounts{
            id  : 0x2::object::new(arg0),
            map : 0x2::table::new<address, 0x2::vec_set::VecSet<address>>(arg0),
        };
        0x2::transfer::share_object<SubAccounts>(v0);
        let v1 = TxIndexer{
            id      : 0x2::object::new(arg0),
            counter : 0,
            map     : 0x2::table::new<vector<u8>, bool>(arg0),
        };
        0x2::transfer::share_object<TxIndexer>(v1);
    }

    public(friend) fun is_sub_account(arg0: &SubAccounts, arg1: address, arg2: address) : bool {
        let v0 = &arg0.map;
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<address>>(v0, arg1)) {
            return false
        };
        0x2::vec_set::contains<address>(0x2::table::borrow<address, 0x2::vec_set::VecSet<address>>(v0, arg1), &arg2)
    }

    entry fun set_sub_account(arg0: &0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::protocol::ProtocolConfig, arg1: &mut SubAccounts, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::protocol::check_basic(arg0);
        assert!(arg2 != @0x0, 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::error::address_cannot_be_zero());
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = &mut arg1.map;
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<address>>(v1, v0)) {
            0x2::table::add<address, 0x2::vec_set::VecSet<address>>(v1, v0, 0x2::vec_set::empty<address>());
        };
        let v2 = 0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<address>>(v1, v0);
        if (arg3) {
            if (!0x2::vec_set::contains<address>(v2, &arg2)) {
                0x2::vec_set::insert<address>(v2, arg2);
            };
        } else if (0x2::vec_set::contains<address>(v2, &arg2)) {
            0x2::vec_set::remove<address>(v2, &arg2);
        };
        let v3 = SubAccountUpdateEvent{
            account     : v0,
            sub_account : arg2,
            status      : arg3,
        };
        0x2::event::emit<SubAccountUpdateEvent>(v3);
    }

    public(friend) fun validate_unique_tx(arg0: &mut TxIndexer, arg1: vector<u8>) : u128 {
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.map, arg1), 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::error::transaction_replay());
        0x2::table::add<vector<u8>, bool>(&mut arg0.map, arg1, true);
        arg0.counter = arg0.counter + 1;
        arg0.counter
    }

    // decompiled from Move bytecode v6
}

