module 0xa2871851ac8533e977cfad3f77aad092ef9b79ad9343f95cb7e68f82b41c70e2::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 6, b"Test", b"Test coin- learning", x"496e74726f647563696e67205465737420436f696e20e280932074686520756c74696d617465206d656d6520636f696e20666f72206c6561726e696e6720686f7720746f206e617669676174652074686520535549206e6574776f726b2120f09f9a800a5465737420436f696e20686173207a65726f207265616c2d776f726c642076616c75652c20627579206f6e2073756920616e64206c6561726e20686f7720746f20627579206d656d65732e205768657468657220796f75277265206120626c6f636b636861696e206e6577626965206f72206a757374206c6f6f6b696e6720746f207368617270656e20796f757220736b696c6c732e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736291408493.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

