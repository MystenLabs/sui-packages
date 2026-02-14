module 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::cannibal {
    struct CANNIBAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANNIBAL, arg1: &mut 0x2::tx_context::TxContext) {
        0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::admin::create_and_transfer(arg1);
    }

    // decompiled from Move bytecode v6
}

