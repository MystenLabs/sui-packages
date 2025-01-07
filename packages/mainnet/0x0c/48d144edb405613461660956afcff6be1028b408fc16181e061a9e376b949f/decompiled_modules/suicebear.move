module 0xc48d144edb405613461660956afcff6be1028b408fc16181e061a9e376b949f::suicebear {
    struct SUICEBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICEBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICEBEAR>(arg0, 6, b"SUICEBEAR", b"SuiceBear", x"5375696365626561722061696d7320746f2068656c702077696c6420616e696d616c7320616e6420656e64616e676572656420616e696d616c7320696e207468652065766f6c76696e6720616e6420646576656c6f70696e6720776f726c642c20616e642077652077696c6c207472616e73666572206120706f7274696f6e206f66206f75722070726f6669747320746f2074686520726573637565206f6620746865736520616e696d616c730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000038132_3fadd82386.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICEBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICEBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

