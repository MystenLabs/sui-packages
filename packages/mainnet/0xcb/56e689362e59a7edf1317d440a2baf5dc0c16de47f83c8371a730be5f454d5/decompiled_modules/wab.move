module 0xcb56e689362e59a7edf1317d440a2baf5dc0c16de47f83c8371a730be5f454d5::wab {
    struct WAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAB>(arg0, 6, b"WAB", b"Water Balloon", x"54686520666972737420616e64206f6e6c792057617465722042616c6c6f6f6e2070726f6a656374206f6e205355490a0a4465762077616c6c65742077696c6c20626520646f78786564200a4c6574732072756e20746869732070726f6a65637420757020746f20746865206d696c6c696f6e7320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/09_FE_9117_FA_40_48_D4_9511_F5_CECB_481203_561a274a49.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

