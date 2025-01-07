module 0xf36cec5abf7cbbdca7d769d4fcdd12c1c9756f34ea534582ee8c8c59fafb1da7::package_state {
    struct PACKAGE_STATE has drop {
        dummy_field: bool,
    }

    struct State has store, key {
        id: 0x2::object::UID,
        available_version: u64,
        admin: address,
        operators: vector<address>,
        features: vector<u256>,
    }

    public(friend) fun check_admin(arg0: &State, arg1: &0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, arg1), 1);
    }

    public(friend) fun check_license(arg0: &State, arg1: u8, arg2: u8) {
        check_version(arg0);
        assert!(get_feature_bit(arg0, arg1, arg2), 2);
    }

    public(friend) fun check_license_without_admin(arg0: &State, arg1: u8, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        if (is_admin(arg0, arg3)) {
            return
        };
        check_version(arg0);
        check_license(arg0, arg1, arg2);
    }

    public(friend) fun check_license_without_op(arg0: &State, arg1: u8, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        if (is_admin(arg0, arg3) || is_op(arg0, arg3)) {
            return
        };
        check_version(arg0);
        check_license(arg0, arg1, arg2);
    }

    public(friend) fun check_op(arg0: &State, arg1: &0x2::tx_context::TxContext) {
        assert!(is_op(arg0, arg1) || is_admin(arg0, arg1), 1);
    }

    public(friend) fun check_version(arg0: &State) {
        assert!(0xf36cec5abf7cbbdca7d769d4fcdd12c1c9756f34ea534582ee8c8c59fafb1da7::consts::VERSION() >= arg0.available_version, 3);
    }

    fun get_feature_bit(arg0: &State, arg1: u8, arg2: u8) : bool {
        0xf36cec5abf7cbbdca7d769d4fcdd12c1c9756f34ea534582ee8c8c59fafb1da7::utils::get_bit(*0x1::vector::borrow<u256>(&arg0.features, (arg1 as u64)), arg2)
    }

    fun init(arg0: PACKAGE_STATE, arg1: &mut 0x2::tx_context::TxContext) {
        init_(arg1);
    }

    public(friend) fun init_(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = State{
            id                : 0x2::object::new(arg0),
            available_version : 0xf36cec5abf7cbbdca7d769d4fcdd12c1c9756f34ea534582ee8c8c59fafb1da7::consts::VERSION(),
            admin             : 0x2::tx_context::sender(arg0),
            operators         : vector[@0xac1de43f8cd3166d21e580f669f85d24ab85f320aa8a085d7a7688ee0a0763dd],
            features          : vector[115792089237316195423570985008687907853269984665640564039457584007913129639935],
        };
        0x2::transfer::public_share_object<State>(v0);
    }

    public(friend) fun is_admin(arg0: &State, arg1: &0x2::tx_context::TxContext) : bool {
        arg0.admin == 0x2::tx_context::sender(arg1)
    }

    public(friend) fun is_op(arg0: &State, arg1: &0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg1);
        0x1::vector::contains<address>(&arg0.operators, &v0) || 0x2::tx_context::sender(arg1) == arg0.admin
    }

    entry fun set_admin(arg0: &mut State, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_admin(arg0, arg2);
        arg0.admin = arg1;
    }

    entry fun set_available_version(arg0: &mut State, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_op(arg0, arg2);
        arg0.available_version = arg1;
    }

    entry fun set_feature_entire(arg0: &mut State, arg1: u8, arg2: u256, arg3: &0x2::tx_context::TxContext) {
        check_op(arg0, arg3);
        0x1::vector::push_back<u256>(&mut arg0.features, arg2);
        0x1::vector::swap_remove<u256>(&mut arg0.features, (arg1 as u64));
    }

    entry fun set_op(arg0: &mut State, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        check_admin(arg0, arg2);
        arg0.operators = arg1;
    }

    // decompiled from Move bytecode v6
}

