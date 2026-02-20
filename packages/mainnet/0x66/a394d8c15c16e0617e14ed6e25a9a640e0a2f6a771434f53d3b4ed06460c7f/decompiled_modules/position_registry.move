module 0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry {
    struct PositionRegistry has key {
        id: 0x2::object::UID,
        by_owner: 0x2::table::Table<address, vector<0x2::object::ID>>,
    }

    struct PositionVault has key {
        id: 0x2::object::UID,
        by_owner: 0x2::table::Table<address, vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>,
    }

    struct CallerAllowlist has key {
        id: 0x2::object::UID,
        admin: address,
        members: 0x2::table::Table<address, bool>,
    }

    public fun add_member(arg0: &mut CallerAllowlist, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        if (!0x2::table::contains<address, bool>(&arg0.members, arg1)) {
            0x2::table::add<address, bool>(&mut arg0.members, arg1, true);
        };
    }

    public fun assert_allowed_sender(arg0: &CallerAllowlist, arg1: &0x2::tx_context::TxContext) {
        assert!(is_allowed(arg0, 0x2::tx_context::sender(arg1)), 2);
    }

    public fun assert_fixed_allowlist_and_sender(arg0: &CallerAllowlist, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<CallerAllowlist>(arg0);
        assert!(0x2::object::id_to_address(&v0) == arg1, 3);
        assert_allowed_sender(arg0, arg2);
    }

    public fun borrow_vault_first_mut(arg0: &mut PositionVault, arg1: address) : &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position {
        0x1::vector::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(0x2::table::borrow_mut<address, vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>(&mut arg0.by_owner, arg1), 0)
    }

    fun contains_id(arg0: &vector<0x2::object::ID>, arg1: &0x2::object::ID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(arg0, v0) == *arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun copy_ids(arg0: &vector<0x2::object::ID>) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v0, *0x1::vector::borrow<0x2::object::ID>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun create_allowlist(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::table::new<address, bool>(arg0);
        0x2::table::add<address, bool>(&mut v1, v0, true);
        let v2 = CallerAllowlist{
            id      : 0x2::object::new(arg0),
            admin   : v0,
            members : v1,
        };
        0x2::transfer::share_object<CallerAllowlist>(v2);
    }

    public fun create_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PositionRegistry{
            id       : 0x2::object::new(arg0),
            by_owner : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
        };
        0x2::transfer::share_object<PositionRegistry>(v0);
    }

    public fun create_vault(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PositionVault{
            id       : 0x2::object::new(arg0),
            by_owner : 0x2::table::new<address, vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>(arg0),
        };
        0x2::transfer::share_object<PositionVault>(v0);
    }

    public fun deposit_position(arg0: &mut PositionVault, arg1: address, arg2: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) {
        if (!0x2::table::contains<address, vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>(&arg0.by_owner, arg1)) {
            let v0 = 0x1::vector::empty<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>();
            0x1::vector::push_back<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut v0, arg2);
            0x2::table::add<address, vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>(&mut arg0.by_owner, arg1, v0);
            return
        };
        0x1::vector::push_back<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(0x2::table::borrow_mut<address, vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>(&mut arg0.by_owner, arg1), arg2);
    }

    public fun get_positions(arg0: &PositionRegistry, arg1: address) : vector<0x2::object::ID> {
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.by_owner, arg1)) {
            return 0x1::vector::empty<0x2::object::ID>()
        };
        copy_ids(0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.by_owner, arg1))
    }

    public fun get_vault_position_ids(arg0: &PositionVault, arg1: address) : vector<0x2::object::ID> {
        if (!0x2::table::contains<address, vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>(&arg0.by_owner, arg1)) {
            return 0x1::vector::empty<0x2::object::ID>()
        };
        let v0 = 0x2::table::borrow<address, vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>(&arg0.by_owner, arg1);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(0x1::vector::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0, v2)));
            v2 = v2 + 1;
        };
        v1
    }

    public fun has_vault_positions(arg0: &PositionVault, arg1: address) : bool {
        0x2::table::contains<address, vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>(&arg0.by_owner, arg1) && 0x1::vector::length<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(0x2::table::borrow<address, vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>(&arg0.by_owner, arg1)) > 0
    }

    public fun is_allowed(arg0: &CallerAllowlist, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.members, arg1)
    }

    public fun register_position(arg0: &mut PositionRegistry, arg1: address, arg2: 0x2::object::ID) {
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.by_owner, arg1)) {
            let v0 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v0, arg2);
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.by_owner, arg1, v0);
            return
        };
        let v1 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.by_owner, arg1);
        if (!contains_id(v1, &arg2)) {
            0x1::vector::push_back<0x2::object::ID>(v1, arg2);
        };
    }

    fun remove_id(arg0: &mut vector<0x2::object::ID>, arg1: &0x2::object::ID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(arg0, v0) == *arg1) {
                0x1::vector::remove<0x2::object::ID>(arg0, v0);
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun remove_member(arg0: &mut CallerAllowlist, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        if (0x2::table::contains<address, bool>(&arg0.members, arg1)) {
            0x2::table::remove<address, bool>(&mut arg0.members, arg1);
        };
    }

    public fun unregister_position(arg0: &mut PositionRegistry, arg1: address, arg2: 0x2::object::ID) {
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.by_owner, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.by_owner, arg1);
        remove_id(v0, &arg2);
    }

    // decompiled from Move bytecode v6
}

