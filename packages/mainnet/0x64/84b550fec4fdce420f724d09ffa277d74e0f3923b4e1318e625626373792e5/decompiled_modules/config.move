module 0x6484b550fec4fdce420f724d09ffa277d74e0f3923b4e1318e625626373792e5::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DistributeConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        operators: 0x2::vec_map::VecMap<address, bool>,
        paused: bool,
        distributed_ids: 0x2::table::Table<0x1::ascii::String, bool>,
        total_distributed_by_token: 0x2::vec_map::VecMap<0x1::ascii::String, u128>,
    }

    struct OperatorUpsertedEvent has copy, drop, store {
        operator: address,
        allowed: bool,
    }

    struct PausedEvent has copy, drop, store {
        paused: bool,
    }

    public(friend) fun assert_operator(arg0: &DistributeConfig, arg1: address) {
        assert!(0x2::vec_map::contains<address, bool>(&arg0.operators, &arg1), 101);
    }

    public(friend) fun assert_paused(arg0: &DistributeConfig) {
        assert!(!arg0.paused, 103);
    }

    public(friend) fun assert_version(arg0: &DistributeConfig) {
        assert!(arg0.version == 1, 102);
    }

    public fun check_distributed_id_existed(arg0: &mut DistributeConfig, arg1: 0x1::ascii::String) : bool {
        0x2::table::contains<0x1::ascii::String, bool>(&arg0.distributed_ids, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = DistributeConfig{
            id                         : 0x2::object::new(arg0),
            version                    : 1,
            operators                  : 0x2::vec_map::empty<address, bool>(),
            paused                     : false,
            distributed_ids            : 0x2::table::new<0x1::ascii::String, bool>(arg0),
            total_distributed_by_token : 0x2::vec_map::empty<0x1::ascii::String, u128>(),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<DistributeConfig>(v1);
    }

    entry fun migrate(arg0: &AdminCap, arg1: &mut DistributeConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version < 1, 100);
        arg1.version = 1;
    }

    entry fun set_operator(arg0: &AdminCap, arg1: &mut DistributeConfig, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        if (!arg3 && 0x2::vec_map::contains<address, bool>(&arg1.operators, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<address, bool>(&mut arg1.operators, &arg2);
            let v2 = OperatorUpsertedEvent{
                operator : arg2,
                allowed  : arg3,
            };
            0x2::event::emit<OperatorUpsertedEvent>(v2);
        } else if (arg3 && !0x2::vec_map::contains<address, bool>(&arg1.operators, &arg2)) {
            0x2::vec_map::insert<address, bool>(&mut arg1.operators, arg2, true);
            let v3 = OperatorUpsertedEvent{
                operator : arg2,
                allowed  : arg3,
            };
            0x2::event::emit<OperatorUpsertedEvent>(v3);
        };
    }

    entry fun set_paused(arg0: &AdminCap, arg1: &mut DistributeConfig, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.paused = arg2;
        let v0 = PausedEvent{paused: arg2};
        0x2::event::emit<PausedEvent>(v0);
    }

    public(friend) fun update_distributed_id(arg0: &mut DistributeConfig, arg1: 0x1::ascii::String, arg2: &0x2::tx_context::TxContext) {
        assert_operator(arg0, 0x2::tx_context::sender(arg2));
        if (!0x2::table::contains<0x1::ascii::String, bool>(&arg0.distributed_ids, arg1)) {
            0x2::table::add<0x1::ascii::String, bool>(&mut arg0.distributed_ids, arg1, true);
        };
    }

    public(friend) fun update_total_distributed(arg0: &mut DistributeConfig, arg1: 0x1::ascii::String, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_operator(arg0, 0x2::tx_context::sender(arg3));
        if (!0x2::vec_map::contains<0x1::ascii::String, u128>(&arg0.total_distributed_by_token, &arg1)) {
            0x2::vec_map::insert<0x1::ascii::String, u128>(&mut arg0.total_distributed_by_token, arg1, (arg2 as u128));
        } else {
            let v0 = 0x2::vec_map::get_mut<0x1::ascii::String, u128>(&mut arg0.total_distributed_by_token, &arg1);
            *v0 = *v0 + (arg2 as u128);
        };
    }

    // decompiled from Move bytecode v6
}

