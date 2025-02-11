module 0xeb24351d388a48dfd44ac813723cf482044ebb93be9100faa1a9c71216b0fcfa::wruh {
    struct WRUH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WRUH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WRUH>(arg0, 6, b"WRUH", b"Wolruh", x"4d65657420576f6c7275682c20612073746f6e65722077616c7275732e204865207370656e6473206869732064617973206c6561726e696e672053756920616e642072656164696e672061626f75742057616c727573207768696c65206d61696e7461696e696e6720616e20756e6865616c74687920776f726b2d626c617a652062616c616e63652e200a0a54727920736179696e6720627275682077697468207475736b732e2e2e575255482120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739235590275.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WRUH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRUH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

