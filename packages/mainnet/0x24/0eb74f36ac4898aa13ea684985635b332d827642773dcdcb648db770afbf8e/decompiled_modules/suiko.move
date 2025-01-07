module 0x240eb74f36ac4898aa13ea684985635b332d827642773dcdcb648db770afbf8e::suiko {
    struct SUIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKO>(arg0, 6, b"SUIKO", b"Suikoden", x"313038205374617273206f662044657374696e7920756e697465206f6e205355492e205765277265206e6f7420796f75722061766572616765206d656d6520636f696e2c207765277265206275696c64696e67206120662a636b696e672061726d79212054696d6520746f20636f6e7175657220746865206d656d65207265616c6d20f09f8fb0e29a94efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734297127336.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIKO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

