module 0x7182b166c2461a4eda64f06b95dd69326bc9001656cc413b255eaa845ada8767::init {
    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x7182b166c2461a4eda64f06b95dd69326bc9001656cc413b255eaa845ada8767::admin::create_admin_cap(arg0);
    }

    // decompiled from Move bytecode v6
}

