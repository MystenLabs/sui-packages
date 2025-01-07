module 0x475e66f9fffa9aabe32de68d376b80ccef424126c7256e95e1fd97f577959eb::bully {
    struct BULLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLY>(arg0, 6, b"BULLY", b"SUIYAN CAT", x"53554959414e20434154204953205245414459210a0a4e61206e61206e61206e61206e61206e61206e61206e61206e610a0a4a6f696e20544720616e6420646f6e74206c6f7365206d6f6e6579206f6e2066616b657321204f6e6c79206f6e205820616e642074656c656772616d2077652077696c6c20706f7374206f7572206f6666696369616c206c61756e6368206f662053756979616e20436174202d2068747470733a2f2f742e6d652f73756979616e636174", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_640_A_640_10_23_2024_12_57_AM_f9a84eb550.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

