module 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::app {
    struct APP has drop {
        dummy_field: bool,
    }

    fun init(arg0: APP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = init_internal(arg0, arg1);
        0x2::transfer::public_transfer<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::admin::AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    fun init_internal(arg0: APP, arg1: &mut 0x2::tx_context::TxContext) : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::admin::AdminCap {
        0x2::package::claim_and_keep<APP>(arg0, arg1);
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::new(arg1);
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::new(arg1);
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::liquidity_book::new(arg1);
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::dispatcher::new(arg1);
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::new(arg1);
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::admin::new(arg1)
    }

    // decompiled from Move bytecode v6
}

