module 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::predict_account {
    struct PredictApp has drop {
        dummy_field: bool,
    }

    struct PositionKey has copy, drop, store {
        expiry_market_id: 0x2::object::ID,
        order_id: u256,
    }

    struct Position has store {
        root_id: u256,
        opened_at_ms: u64,
    }

    struct PredictData has store {
        positions: 0x2::table::Table<PositionKey, Position>,
        builder_code_id: 0x1::option::Option<0x2::object::ID>,
    }

    public(friend) fun add_position(arg0: &mut 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::Account, arg1: 0x2::object::ID, arg2: u256, arg3: u256, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = data_mut(arg0, arg5);
        let v1 = position_key(arg1, arg2);
        assert!(!0x2::table::contains<PositionKey, Position>(&v0.positions, v1), 0);
        let v2 = Position{
            root_id      : arg3,
            opened_at_ms : arg4,
        };
        0x2::table::add<PositionKey, Position>(&mut v0.positions, v1, v2);
    }

    public fun builder_code_id(arg0: &0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::Account) : 0x1::option::Option<0x2::object::ID> {
        if (!0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::has_data<PredictApp>(arg0)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        data(arg0).builder_code_id
    }

    fun data(arg0: &0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::Account) : &PredictData {
        0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::borrow_data<PredictApp, PredictData>(arg0)
    }

    fun data_mut(arg0: &mut 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::Account, arg1: &mut 0x2::tx_context::TxContext) : &mut PredictData {
        if (!0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::has_data<PredictApp>(arg0)) {
            0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::attach<PredictApp, PredictData>(arg0, 0x1::internal::permit<PredictApp>(), new_data(arg1));
        };
        0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::borrow_data_mut<PredictApp, PredictData>(arg0, 0x1::internal::permit<PredictApp>())
    }

    public(friend) fun generate_auth_as_app(arg0: &0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account_registry::AccountRegistry) : 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::Auth {
        0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account_registry::generate_auth_as_app<PredictApp>(arg0, 0x1::internal::permit<PredictApp>())
    }

    public fun has_position(arg0: &0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::Account, arg1: 0x2::object::ID, arg2: u256) : bool {
        if (!0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::has_data<PredictApp>(arg0)) {
            return false
        };
        0x2::table::contains<PositionKey, Position>(&data(arg0).positions, position_key(arg1, arg2))
    }

    fun new_data(arg0: &mut 0x2::tx_context::TxContext) : PredictData {
        PredictData{
            positions       : 0x2::table::new<PositionKey, Position>(arg0),
            builder_code_id : 0x1::option::none<0x2::object::ID>(),
        }
    }

    fun position_key(arg0: 0x2::object::ID, arg1: u256) : PositionKey {
        PositionKey{
            expiry_market_id : arg0,
            order_id         : arg1,
        }
    }

    public(friend) fun position_opened_at_ms(arg0: &0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::Account, arg1: 0x2::object::ID, arg2: u256) : u64 {
        let v0 = data(arg0);
        let v1 = position_key(arg1, arg2);
        assert!(0x2::table::contains<PositionKey, Position>(&v0.positions, v1), 1);
        0x2::table::borrow<PositionKey, Position>(&v0.positions, v1).opened_at_ms
    }

    public(friend) fun remove_position(arg0: &mut 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::Account, arg1: 0x2::object::ID, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) : u256 {
        let v0 = data_mut(arg0, arg3);
        let v1 = position_key(arg1, arg2);
        assert!(0x2::table::contains<PositionKey, Position>(&v0.positions, v1), 1);
        let Position {
            root_id      : v2,
            opened_at_ms : _,
        } = 0x2::table::remove<PositionKey, Position>(&mut v0.positions, v1);
        v2
    }

    public fun set_builder_code(arg0: &mut 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::AccountWrapper, arg1: 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::Auth, arg2: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::builder_code::BuilderCode, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::load_account_mut(arg0, arg1);
        let v1 = 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::builder_code::id(arg2);
        let v2 = data_mut(v0, arg3);
        v2.builder_code_id = 0x1::option::some<0x2::object::ID>(v1);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::builder_code_events::emit_builder_code_set(0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::account_id(v0), 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::owner(v0), 0x1::option::some<0x2::object::ID>(v1));
    }

    public fun unset_builder_code(arg0: &mut 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::AccountWrapper, arg1: 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::Auth, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::load_account_mut(arg0, arg1);
        let v1 = data_mut(v0, arg2);
        v1.builder_code_id = 0x1::option::none<0x2::object::ID>();
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::builder_code_events::emit_builder_code_set(0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::account_id(v0), 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::owner(v0), 0x1::option::none<0x2::object::ID>());
    }

    // decompiled from Move bytecode v7
}

