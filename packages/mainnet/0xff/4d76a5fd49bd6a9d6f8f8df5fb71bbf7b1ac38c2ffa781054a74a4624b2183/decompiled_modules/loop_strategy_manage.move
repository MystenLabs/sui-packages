module 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::loop_strategy_manage {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        init: bool,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun migrate(arg0: &AdminCap, arg1: &mut 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::loop_strategy_core::Strategy) {
        0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::loop_strategy_core::migrate(arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id   : 0x2::object::new(arg0),
            init : true,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun init_strategy_config(arg0: &mut AdminCap, arg1: 0x2::coin::TreasuryCap<0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::vaultlpt::VAULTLPT>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.init, 1);
        0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::loop_strategy_core::initialize(arg1, arg2);
        arg0.init = true;
    }

    public entry fun set_operator_cap_to_address(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<OperatorCap>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

