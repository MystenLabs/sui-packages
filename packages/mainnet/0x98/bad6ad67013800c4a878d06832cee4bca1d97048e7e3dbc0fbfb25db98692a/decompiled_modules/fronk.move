module 0x98bad6ad67013800c4a878d06832cee4bca1d97048e7e3dbc0fbfb25db98692a::fronk {
    struct FRONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRONK>(arg0, 6, b"FRONK", b"FRONK SUI", x"46524f4e4b206973206120737569206d656d65636f696e206669676874696e6720616761696e737420696e6a7573746963652e205468657265206973206e6f206e65656420746f20626520756e666169722e200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_QRU_5fz_R_400x400_27bbf9d50a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

