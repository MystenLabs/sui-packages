module 0xfbb8f89c584a354e36c7508b8b0f42f66ce76ba0fb80ab8b57958c48acd0ecc5::poc_lp {
    struct POC_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POC_LP, arg1: &mut 0x2::tx_context::TxContext) {
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::transfer_create_pool_cap<POC_LP>(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_factory::create_lp_coin<POC_LP>(arg0, 9, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

