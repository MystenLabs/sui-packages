module 0xbd0fc42b49ad1ee1ace5c2ed21aec4f647bf6d135329436dfebcd495c66c7819::mangrove_lp {
    struct MANGROVE_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANGROVE_LP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANGROVE_LP>(arg0, 6, b"Mangrove LP", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANGROVE_LP>>(v1);
        0xbd0fc42b49ad1ee1ace5c2ed21aec4f647bf6d135329436dfebcd495c66c7819::farm::new<MANGROVE_LP, 0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

