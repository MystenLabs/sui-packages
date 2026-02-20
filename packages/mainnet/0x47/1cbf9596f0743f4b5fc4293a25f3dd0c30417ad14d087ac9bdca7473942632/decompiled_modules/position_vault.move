module 0xa13af5dabb62fafc411ceaa81943b52526e53ee6030117d338c5343e467d9466::position_vault {
    struct PositionVault has key {
        id: 0x2::object::UID,
        by_owner: 0x2::table::Table<address, vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>,
    }

    public fun create_vault(arg0: &0xa13af5dabb62fafc411ceaa81943b52526e53ee6030117d338c5343e467d9466::admin_guard_pkg::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PositionVault{
            id       : 0x2::object::new(arg1),
            by_owner : 0x2::table::new<address, vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>(arg1),
        };
        0x2::transfer::share_object<PositionVault>(v0);
    }

    public fun deposit_position(arg0: &0xa13af5dabb62fafc411ceaa81943b52526e53ee6030117d338c5343e467d9466::admin_guard_pkg::AdminCap, arg1: &mut PositionVault, arg2: address, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) {
        if (!0x2::table::contains<address, vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>(&arg1.by_owner, arg2)) {
            let v0 = 0x1::vector::empty<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>();
            0x1::vector::push_back<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut v0, arg3);
            0x2::table::add<address, vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>(&mut arg1.by_owner, arg2, v0);
            return
        };
        0x1::vector::push_back<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(0x2::table::borrow_mut<address, vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>(&mut arg1.by_owner, arg2), arg3);
    }

    public fun has_positions(arg0: &0xa13af5dabb62fafc411ceaa81943b52526e53ee6030117d338c5343e467d9466::admin_guard_pkg::AdminCap, arg1: &PositionVault, arg2: address) : bool {
        0x2::table::contains<address, vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>(&arg1.by_owner, arg2) && 0x1::vector::length<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(0x2::table::borrow<address, vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>(&arg1.by_owner, arg2)) > 0
    }

    public fun position_count(arg0: &0xa13af5dabb62fafc411ceaa81943b52526e53ee6030117d338c5343e467d9466::admin_guard_pkg::AdminCap, arg1: &PositionVault, arg2: address) : u64 {
        if (!0x2::table::contains<address, vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>(&arg1.by_owner, arg2)) {
            return 0
        };
        0x1::vector::length<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(0x2::table::borrow<address, vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>(&arg1.by_owner, arg2))
    }

    public fun position_ids(arg0: &0xa13af5dabb62fafc411ceaa81943b52526e53ee6030117d338c5343e467d9466::admin_guard_pkg::AdminCap, arg1: &PositionVault, arg2: address) : vector<0x2::object::ID> {
        if (!0x2::table::contains<address, vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>(&arg1.by_owner, arg2)) {
            return 0x1::vector::empty<0x2::object::ID>()
        };
        let v0 = 0x2::table::borrow<address, vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>(&arg1.by_owner, arg2);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(0x1::vector::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0, v2)));
            v2 = v2 + 1;
        };
        v1
    }

    public fun withdraw_by_id(arg0: &0xa13af5dabb62fafc411ceaa81943b52526e53ee6030117d338c5343e467d9466::admin_guard_pkg::AdminCap, arg1: &mut PositionVault, arg2: address, arg3: 0x2::object::ID) : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position {
        assert!(0x2::table::contains<address, vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>(&arg1.by_owner, arg2), 1);
        let v0 = 0x2::table::borrow_mut<address, vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>(&mut arg1.by_owner, arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0)) {
            if (0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(0x1::vector::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0, v1)) == arg3) {
                return 0x1::vector::remove<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0, v1)
            };
            v1 = v1 + 1;
        };
        abort 3
    }

    public fun withdraw_first(arg0: &0xa13af5dabb62fafc411ceaa81943b52526e53ee6030117d338c5343e467d9466::admin_guard_pkg::AdminCap, arg1: &mut PositionVault, arg2: address) : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position {
        assert!(0x2::table::contains<address, vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>(&arg1.by_owner, arg2), 1);
        let v0 = 0x2::table::borrow_mut<address, vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>(&mut arg1.by_owner, arg2);
        assert!(0x1::vector::length<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0) > 0, 2);
        0x1::vector::remove<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0, 0)
    }

    // decompiled from Move bytecode v6
}

