module 0x2609a5d99772af4df0775c6167f9d72b428ce621a289fe5e5de2cb887ded6f4c::af_lp {
    struct AF_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP, arg1: &mut 0x2::tx_context::TxContext) {
        0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::interface::create_vault_cap<AF_LP>(arg0, 9, b"afLP", b"afLP", b"The LP Coin underpinning Aftermath's afLP Vault", b"https://aftermath.finance/coins/perpetuals/af-lp.svg", arg1);
    }

    // decompiled from Move bytecode v6
}

