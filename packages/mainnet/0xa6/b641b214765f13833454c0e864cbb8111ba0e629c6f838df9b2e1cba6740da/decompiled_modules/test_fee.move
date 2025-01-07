module 0x2644af05a059ad4c8f1d851919c6d0ef77eda1382091b250c7249698aee187c5::test_fee {
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

    public fun test(arg0: &0xc6311775f6ebad4515fd5d60cd96c40ae2f688eeb0e21d90c26ae7135ca09e9a::state::FeeManagerState) {
        let v0 = FeeCaptured{fee: 0xc6311775f6ebad4515fd5d60cd96c40ae2f688eeb0e21d90c26ae7135ca09e9a::calculate_fee_rate::calculate_fee(arg0, 3, @0x0, 2, @0x0, 0, 0, @0x0, 3)};
        0x2::event::emit<FeeCaptured>(v0);
    }

    // decompiled from Move bytecode v6
}

