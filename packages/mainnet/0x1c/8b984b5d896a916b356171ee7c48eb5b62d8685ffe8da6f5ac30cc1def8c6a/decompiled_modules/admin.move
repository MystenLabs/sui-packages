module 0x1c8b984b5d896a916b356171ee7c48eb5b62d8685ffe8da6f5ac30cc1def8c6a::admin {
    struct OwnerChanged has copy, drop {
        old_owner: address,
        new_owner: address,
    }

    struct AdminChanged has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct OracleChanged has copy, drop {
        old_oracle: address,
        new_oracle: address,
    }

    struct OperatorChanged has copy, drop {
        old_operator: address,
        new_operator: address,
    }

    struct Admin has key {
        id: 0x2::object::UID,
        owner: address,
        admin: address,
        oracle: address,
        operator: address,
    }

    struct ADMIN has drop {
        dummy_field: bool,
    }

    public fun admin(arg0: &Admin) : address {
        arg0.admin
    }

    public fun assert_admin(arg0: &Admin, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner || 0x2::tx_context::sender(arg1) == arg0.admin, 0);
    }

    public fun assert_operator(arg0: &Admin, arg1: &0x2::tx_context::TxContext) {
        let v0 = if (0x2::tx_context::sender(arg1) == arg0.owner) {
            true
        } else if (0x2::tx_context::sender(arg1) == arg0.admin) {
            true
        } else {
            0x2::tx_context::sender(arg1) == arg0.operator
        };
        assert!(v0, 0);
    }

    public fun assert_oracle(arg0: &Admin, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.oracle, 0);
    }

    public fun assert_owner(arg0: &Admin, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
    }

    fun init(arg0: ADMIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = Admin{
            id       : 0x2::object::new(arg1),
            owner    : v0,
            admin    : v0,
            oracle   : v0,
            operator : v0,
        };
        0x2::transfer::share_object<Admin>(v1);
    }

    public fun is_admin(arg0: &Admin, arg1: address) : bool {
        arg1 == arg0.admin
    }

    public fun is_operator(arg0: &Admin, arg1: address) : bool {
        arg1 == arg0.operator
    }

    public fun is_oracle(arg0: &Admin, arg1: address) : bool {
        arg1 == arg0.oracle
    }

    public fun is_owner(arg0: &Admin, arg1: address) : bool {
        arg1 == arg0.owner
    }

    public fun operator(arg0: &Admin) : address {
        arg0.operator
    }

    public fun oracle(arg0: &Admin) : address {
        arg0.oracle
    }

    public fun owner(arg0: &Admin) : address {
        arg0.owner
    }

    public entry fun set_admin(arg0: &mut Admin, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert!(arg1 != @0x0, 1);
        arg0.admin = arg1;
        let v0 = AdminChanged{
            old_admin : arg0.admin,
            new_admin : arg1,
        };
        0x2::event::emit<AdminChanged>(v0);
    }

    public entry fun set_operator(arg0: &mut Admin, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert!(arg1 != @0x0, 1);
        arg0.operator = arg1;
        let v0 = OperatorChanged{
            old_operator : arg0.operator,
            new_operator : arg1,
        };
        0x2::event::emit<OperatorChanged>(v0);
    }

    public entry fun set_oracle(arg0: &mut Admin, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert!(arg1 != @0x0, 1);
        arg0.oracle = arg1;
        let v0 = OracleChanged{
            old_oracle : arg0.oracle,
            new_oracle : arg1,
        };
        0x2::event::emit<OracleChanged>(v0);
    }

    public entry fun set_owner(arg0: &mut Admin, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert!(arg1 != @0x0, 1);
        arg0.owner = arg1;
        let v0 = OwnerChanged{
            old_owner : arg0.owner,
            new_owner : arg1,
        };
        0x2::event::emit<OwnerChanged>(v0);
    }

    // decompiled from Move bytecode v6
}

