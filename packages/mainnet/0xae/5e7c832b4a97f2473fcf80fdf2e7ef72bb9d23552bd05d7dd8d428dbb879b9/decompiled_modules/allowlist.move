module 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::allowlist {
    struct Allowlist has store {
        enabled: bool,
        coins: 0x2::table::Table<0x1::ascii::String, vector<address>>,
        objects: 0x2::table::Table<0x2::object::ID, vector<address>>,
        default: vector<address>,
    }

    struct AllowlistEnableEvent has copy, drop {
        enable: bool,
    }

    struct AllowlistCoinUpdateEvent has copy, drop {
        coin: 0x1::ascii::String,
        addresses: vector<address>,
    }

    struct AllowlistObjectUpdateEvent has copy, drop {
        object: 0x2::object::ID,
        addresses: vector<address>,
    }

    struct AllowlistCoinDeleteEvent has copy, drop {
        coin: 0x1::ascii::String,
    }

    struct AllowlistObjectDeleteEvent has copy, drop {
        object: 0x2::object::ID,
    }

    struct AllowlistDefaultUpdateEvent has copy, drop {
        addresses: vector<address>,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : Allowlist {
        Allowlist{
            enabled : false,
            coins   : 0x2::table::new<0x1::ascii::String, vector<address>>(arg0),
            objects : 0x2::table::new<0x2::object::ID, vector<address>>(arg0),
            default : 0x1::vector::empty<address>(),
        }
    }

    fun delete_coin(arg0: &mut Allowlist, arg1: 0x1::ascii::String) {
        0x2::table::remove<0x1::ascii::String, vector<address>>(&mut arg0.coins, arg1);
        let v0 = AllowlistCoinDeleteEvent{coin: arg1};
        0x2::event::emit<AllowlistCoinDeleteEvent>(v0);
    }

    fun delete_object(arg0: &mut Allowlist, arg1: 0x2::object::ID) {
        0x2::table::remove<0x2::object::ID, vector<address>>(&mut arg0.objects, arg1);
        let v0 = AllowlistObjectDeleteEvent{object: arg1};
        0x2::event::emit<AllowlistObjectDeleteEvent>(v0);
    }

    fun disable(arg0: &mut Allowlist) {
        arg0.enabled = false;
        let v0 = AllowlistEnableEvent{enable: arg0.enabled};
        0x2::event::emit<AllowlistEnableEvent>(v0);
    }

    fun enable(arg0: &mut Allowlist) {
        arg0.enabled = true;
        let v0 = AllowlistEnableEvent{enable: arg0.enabled};
        0x2::event::emit<AllowlistEnableEvent>(v0);
    }

    public(friend) fun execute(arg0: &mut Allowlist, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation) {
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::is_admin_operation(arg1), 1000);
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_sub_type(arg1);
        if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_op_allowlist_enable(v0)) {
            execute_allowlist_enable(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::deserialize_allowlist_enable(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)));
        } else if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_op_allowlist_coin_update(v0)) {
            execute_allowlist_coin_update(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::deserialize_allowlist_coin_update(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)));
        } else if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_op_allowlist_object_update(v0)) {
            execute_allowlist_object_update(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::deserialize_allowlist_object_update(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)));
        } else if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_op_allowlist_default_update(v0)) {
            execute_allowlist_default_update(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::deserialize_allowlist_default_update(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)));
        } else if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_op_allowlist_coin_delete(v0)) {
            execute_allowlist_coin_delete(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::deserialize_allowlist_coin_delete(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)));
        } else {
            assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_op_allowlist_object_delete(v0), 1002);
            execute_allowlist_object_delete(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::deserialize_allowlist_object_delete(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)));
        };
    }

    fun execute_allowlist_coin_delete(arg0: &mut Allowlist, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::AllowlistCoinDelete) {
        delete_coin(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::allowlist_coin_delete_destruct(arg1));
    }

    fun execute_allowlist_coin_update(arg0: &mut Allowlist, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::AllowlistCoinUpdate) {
        let (v0, v1) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::allowlist_coin_update_destruct(arg1);
        update_coin(arg0, v0, v1);
    }

    fun execute_allowlist_default_update(arg0: &mut Allowlist, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::AllowlistDefaultUpdate) {
        update_default(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::allowlist_default_update_destruct(arg1));
    }

    fun execute_allowlist_enable(arg0: &mut Allowlist, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::AllowlistEnable) {
        if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::allowlist_enable_destruct(arg1)) {
            enable(arg0);
        } else {
            disable(arg0);
        };
    }

    fun execute_allowlist_object_delete(arg0: &mut Allowlist, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::AllowlistObjectDelete) {
        delete_object(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::allowlist_object_delete_destruct(arg1));
    }

    fun execute_allowlist_object_update(arg0: &mut Allowlist, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::AllowlistObjectUpdate) {
        let (v0, v1) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::allowlist_object_update_destruct(arg1);
        update_object(arg0, v0, v1);
    }

    public fun is_coin_allowed(arg0: &Allowlist, arg1: 0x1::ascii::String, arg2: address) : bool {
        if (!is_enabled(arg0)) {
            return true
        };
        let v0 = if (0x2::table::contains<0x1::ascii::String, vector<address>>(&arg0.coins, arg1)) {
            0x2::table::borrow<0x1::ascii::String, vector<address>>(&arg0.coins, arg1)
        } else {
            &arg0.default
        };
        0x1::vector::contains<address>(v0, &arg2)
    }

    fun is_enabled(arg0: &Allowlist) : bool {
        arg0.enabled
    }

    public fun is_object_allowed(arg0: &Allowlist, arg1: 0x2::object::ID, arg2: address) : bool {
        if (!is_enabled(arg0)) {
            return true
        };
        let v0 = if (0x2::table::contains<0x2::object::ID, vector<address>>(&arg0.objects, arg1)) {
            0x2::table::borrow<0x2::object::ID, vector<address>>(&arg0.objects, arg1)
        } else {
            &arg0.default
        };
        0x1::vector::contains<address>(v0, &arg2)
    }

    fun update_coin(arg0: &mut Allowlist, arg1: 0x1::ascii::String, arg2: vector<address>) {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::utils::validate_coin_type(&arg1);
        assert!(0x1::vector::length<address>(&arg2) <= 1024, 1003);
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::utils::update_table<0x1::ascii::String, vector<address>>(&mut arg0.coins, arg1, arg2);
        let v0 = AllowlistCoinUpdateEvent{
            coin      : arg1,
            addresses : arg2,
        };
        0x2::event::emit<AllowlistCoinUpdateEvent>(v0);
    }

    fun update_default(arg0: &mut Allowlist, arg1: vector<address>) {
        assert!(0x1::vector::length<address>(&arg1) <= 1024, 1003);
        arg0.default = arg1;
        let v0 = AllowlistDefaultUpdateEvent{addresses: arg1};
        0x2::event::emit<AllowlistDefaultUpdateEvent>(v0);
    }

    fun update_object(arg0: &mut Allowlist, arg1: 0x2::object::ID, arg2: vector<address>) {
        assert!(0x1::vector::length<address>(&arg2) <= 1024, 1003);
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::utils::update_table<0x2::object::ID, vector<address>>(&mut arg0.objects, arg1, arg2);
        let v0 = AllowlistObjectUpdateEvent{
            object    : arg1,
            addresses : arg2,
        };
        0x2::event::emit<AllowlistObjectUpdateEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

