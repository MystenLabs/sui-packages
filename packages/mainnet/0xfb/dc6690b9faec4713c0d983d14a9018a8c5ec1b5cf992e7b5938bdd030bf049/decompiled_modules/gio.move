module 0xfbdc6690b9faec4713c0d983d14a9018a8c5ec1b5cf992e7b5938bdd030bf049::gio {
    struct GIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIO>(arg0, 6, b"GIO", b"GioCandies", x"4d616b696e672074686520776f726c6420612062657474657220706c6163652077697468206d757368726f6f6d732e200a0a4d757368204c4f5645203c33", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gio_Gummies_Watermelon_page_0001_9de6ff1482.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

