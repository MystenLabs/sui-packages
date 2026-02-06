module 0x84a3b7161e525ad820fee1684bcb14294f2cc6da7ac5899808669ccc72dfbfce::clank {
    struct CLANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLANK, arg1: &mut 0x2::tx_context::TxContext) {
        0x84a3b7161e525ad820fee1684bcb14294f2cc6da7ac5899808669ccc72dfbfce::admin::create_and_transfer(arg1);
        0x84a3b7161e525ad820fee1684bcb14294f2cc6da7ac5899808669ccc72dfbfce::registry::create_and_share(arg1);
    }

    // decompiled from Move bytecode v6
}

