module 0xff3f85e7ead0ecebb3d8f4d853fb25badfdc5b32cde871ab6fadf9b61a2f3afc::suicamel {
    struct SUICAMEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAMEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAMEL>(arg0, 6, b"SuiCamel", b"Sui Camel", b"The camel coming on sui ,just enjoy it .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/camel_61f37fda9a.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAMEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICAMEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

