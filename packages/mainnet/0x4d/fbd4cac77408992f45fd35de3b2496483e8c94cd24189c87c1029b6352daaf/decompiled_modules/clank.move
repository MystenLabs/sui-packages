module 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::clank {
    struct CLANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLANK, arg1: &mut 0x2::tx_context::TxContext) {
        0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::admin::create_and_transfer(arg1);
        0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::registry::create_and_share(arg1);
    }

    // decompiled from Move bytecode v6
}

