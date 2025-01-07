module 0x93c6c09c7e50a8a21aac35de6955540bff993ce6e68fb5968db75ce54b230e27::suikoden {
    struct SUIKODEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKODEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKODEN>(arg0, 6, b"SUIKODEN", b"Suikoden", x"54686520535549205374617273206f662044657374696e7920617373656d626c65206f6e2053554921204a6f696e2074686520245355494b4f44454e2041726d792061732077652067617468657220616c6c2074727565206761696e7320696e2074686520626c6f636b636861696e207265616c6d2e200a5765277265206e6f7420796f75722061766572616765206d656d6520636f696e2c207765277265206275696c64696e67206120662a636b696e672061726d79212054696d6520746f20636f6e7175657220746865206d656d65207265616c20f09f8fb0e29a94efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734545453595.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIKODEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKODEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

