module 0x6ab47eca1c3c6476ba13fc26ab7a6682faf0eb42cb303ddb79d7bc45df52db7a::navi_admin_entry {
    public entry fun init_navi_account_cap<T0, T1>(arg0: &0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_admin::LLVGlobal, arg1: &mut 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_pool::LLVPool<T0, T1>, arg2: &0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_admin::LLVPoolAdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_admin::assert_version(arg0);
        0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_pool::store_protocol_cap<T0, T1, 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_pool::NaviAccountCapKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg1, arg2, 0xb9b67cf78b0dd24400363d1027ff01c720c64c3a446309885fcbef24abd799e8::llv_pool::navi_account_cap_key(), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg3));
    }

    // decompiled from Move bytecode v6
}

