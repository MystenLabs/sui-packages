module 0x904fb7c99200bf61491e48745c52b619bcab74168de6e37b87f9a7439365992c::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x904fb7c99200bf61491e48745c52b619bcab74168de6e37b87f9a7439365992c::pyth::create_pyth_integration_object_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

