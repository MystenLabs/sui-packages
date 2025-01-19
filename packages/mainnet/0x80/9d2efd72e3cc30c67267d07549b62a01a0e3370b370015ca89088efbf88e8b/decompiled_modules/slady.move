module 0x809d2efd72e3cc30c67267d07549b62a01a0e3370b370015ca89088efbf88e8b::slady {
    struct SLADY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLADY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLADY>(arg0, 6, b"SLADY", b"Suilady", x"5375696c6164792c206261736564206f6e20766974616c696b2773206e657720582070726f66696c652070696374757265210a0a68747470733a2f2f742e6d652f7375696c616479737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mil_b3cfeffbf3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLADY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLADY>>(v1);
    }

    // decompiled from Move bytecode v6
}

