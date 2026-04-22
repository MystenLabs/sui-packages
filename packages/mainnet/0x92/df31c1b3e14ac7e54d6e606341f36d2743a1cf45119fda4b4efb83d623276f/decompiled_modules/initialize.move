module 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::initialize {
    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::initialize(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::initialize(v0, v1, v2, v3, arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::price_feed::initialize(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::initialize(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::vault::create_vault_config(0x2::tx_context::sender(arg0), 1000000000000000000000000000, 10000000000000000000, 0x2::tx_context::sender(arg0), arg0);
    }

    // decompiled from Move bytecode v6
}

