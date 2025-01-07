module 0x4b093d46d2dd40372850f92c51f497a8540c84d09df51d759282a9d6ae922182::test_fee {
    struct FeeCaptured has copy, drop {
        fee: u8,
    }

    struct State has key {
        id: 0x2::object::UID,
        data: u8,
        version: u64,
    }

    public fun change_state(arg0: &mut State, arg1: u8) {
        assert!(arg0.version == 2, 88);
        arg0.data = arg1;
        let v0 = FeeCaptured{fee: arg1};
        0x2::event::emit<FeeCaptured>(v0);
    }

    public fun create_state(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = State{
            id      : 0x2::object::new(arg0),
            data    : 10,
            version : 2,
        };
        0x2::transfer::share_object<State>(v0);
    }

    public fun migrate_state(arg0: &mut State) {
        arg0.version = 2;
    }

    public fun test(arg0: 0x7647efebba2627670463fa7aee1568ca0c1efa0069db86b4ed8998e03e69356c::calculate_swift_fee::SwiftInitParams) {
        let v0 = FeeCaptured{fee: 0x7647efebba2627670463fa7aee1568ca0c1efa0069db86b4ed8998e03e69356c::calculate_swift_fee::unpack_swift_init_params(arg0)};
        0x2::event::emit<FeeCaptured>(v0);
    }

    // decompiled from Move bytecode v6
}

