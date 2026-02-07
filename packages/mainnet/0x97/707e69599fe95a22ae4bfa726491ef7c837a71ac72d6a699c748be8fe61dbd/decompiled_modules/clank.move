module 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::clank {
    struct CLANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLANK, arg1: &mut 0x2::tx_context::TxContext) {
        0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::admin::create_and_transfer(arg1);
    }

    // decompiled from Move bytecode v6
}

