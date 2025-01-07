module 0x225bd66a73ef26946cc13e9a040ebb54c8c36cb16f4c27c1dc0773e32ad8e21::suibome {
    struct SUIBOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBOME>(arg0, 6, b"Suibome", b"Sui bome", x"54686520737569626f6d65206d656d652077696c6c20646566696e6974656c79206265206e756d626572206f6e650a0a50756d7020697420757020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8887_c546a801d4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBOME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBOME>>(v1);
    }

    // decompiled from Move bytecode v6
}

