module 0xf435e16e002dd0cbe7afe9a449498ae5f589712365cad41ad0854a9cec5487e2::global_config {
    struct GlobalConfig has key {
        id: 0x2::object::UID,
        dao_admin_address: address,
        emergency_admin_address: address,
        fee_admin_address: address,
        default_swap_fee: u64,
        default_dao_fee: u64,
    }

    struct UpdateDefaultFeeEvent has copy, drop {
        fee: u64,
    }

    public fun assert_valid_dao_fee(arg0: u64) {
        assert!(0 <= arg0 && arg0 <= 100, 302);
    }

    public fun assert_valid_fee(arg0: u64) {
        assert!(1 <= arg0 && arg0 <= 100, 302);
    }

    public fun get_dao_admin(arg0: &GlobalConfig) : address {
        arg0.dao_admin_address
    }

    public fun get_default_dao_fee(arg0: &GlobalConfig) : u64 {
        arg0.default_dao_fee
    }

    public fun get_default_fee(arg0: &GlobalConfig) : u64 {
        arg0.default_swap_fee
    }

    public fun get_emergency_admin(arg0: &GlobalConfig) : address {
        arg0.emergency_admin_address
    }

    public fun get_fee_admin(arg0: &GlobalConfig) : address {
        arg0.fee_admin_address
    }

    public(friend) fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0xff34e26a2e24909ddd4e606ba479766570b0ff4e0b02f73a4684ed4cffbcddee, 303);
        let v0 = GlobalConfig{
            id                      : 0x2::object::new(arg0),
            dao_admin_address       : @0xff34e26a2e24909ddd4e606ba479766570b0ff4e0b02f73a4684ed4cffbcddee,
            emergency_admin_address : @0xff34e26a2e24909ddd4e606ba479766570b0ff4e0b02f73a4684ed4cffbcddee,
            fee_admin_address       : @0xff34e26a2e24909ddd4e606ba479766570b0ff4e0b02f73a4684ed4cffbcddee,
            default_swap_fee        : 30,
            default_dao_fee         : 33,
        };
        0x2::transfer::share_object<GlobalConfig>(v0);
    }

    public entry fun set_dao_admin(arg0: &mut GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xff34e26a2e24909ddd4e606ba479766570b0ff4e0b02f73a4684ed4cffbcddee, 301);
        arg0.dao_admin_address = arg1;
    }

    public entry fun set_default_dao_fee(arg0: &mut GlobalConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fee_admin_address == 0x2::tx_context::sender(arg2), 301);
        assert_valid_dao_fee(arg1);
        arg0.default_dao_fee = arg1;
        let v0 = UpdateDefaultFeeEvent{fee: arg1};
        0x2::event::emit<UpdateDefaultFeeEvent>(v0);
    }

    public entry fun set_default_fee(arg0: &mut GlobalConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fee_admin_address == 0x2::tx_context::sender(arg2), 301);
        assert_valid_fee(arg1);
        arg0.default_swap_fee = arg1;
        let v0 = UpdateDefaultFeeEvent{fee: arg1};
        0x2::event::emit<UpdateDefaultFeeEvent>(v0);
    }

    public entry fun set_emergency_admin(arg0: &mut GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xff34e26a2e24909ddd4e606ba479766570b0ff4e0b02f73a4684ed4cffbcddee, 301);
        arg0.emergency_admin_address = arg1;
    }

    public entry fun set_fee_admin(arg0: &mut GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xff34e26a2e24909ddd4e606ba479766570b0ff4e0b02f73a4684ed4cffbcddee, 301);
        arg0.fee_admin_address = arg1;
    }

    // decompiled from Move bytecode v6
}

