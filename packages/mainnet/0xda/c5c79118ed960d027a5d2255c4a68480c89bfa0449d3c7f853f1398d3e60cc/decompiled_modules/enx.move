module 0xdac5c79118ed960d027a5d2255c4a68480c89bfa0449d3c7f853f1398d3e60cc::enx {
    struct ENX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENX>(arg0, 9, b"ENX", b"Eonix", x"45766f6c7574696f6e20616e64205375737461696e6162696c6974790a4465736372697074696f6e3a20456f6e697820726570726573656e7473207468652065766f6c7574696f6e206f66206d6f6e65792c20666f73746572696e67207375737461696e61626c652065636f6e6f6d69632067726f7774682c20616e642070726f6d6f74696e672065636f2d667269656e646c792070726163746963657320696e20746865206469676974616c2063757272656e63792073706163652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/faaedb7f-3951-4c67-ab4f-3e7a2fb29711.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ENX>>(v1);
    }

    // decompiled from Move bytecode v6
}

