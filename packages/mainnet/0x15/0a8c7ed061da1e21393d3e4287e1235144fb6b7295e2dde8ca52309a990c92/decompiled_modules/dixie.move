module 0x150a8c7ed061da1e21393d3e4287e1235144fb6b7295e2dde8ca52309a990c92::dixie {
    struct DIXIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIXIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIXIE>(arg0, 6, b"DIXIE", b"Dixie Dolphin", x"496e2074686520766173742043727970746f204f6365616e2c2061206c6567656e6461727920626c756520646f6c7068696e206e616d656420446978696520646973636f76657265642024444958494520436f696e2c2061206e65772063757272656e637920696d62756564207769746820686572206d61676963616c20746f7563682c2070726f6d6973696e672066696e616e6369616c2067726f7774682c20636f6d6d756e6974792c20616476656e747572652c20616e642066756e210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/s_Qi_Cp0_TS_400x400_97ae47913c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIXIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIXIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

