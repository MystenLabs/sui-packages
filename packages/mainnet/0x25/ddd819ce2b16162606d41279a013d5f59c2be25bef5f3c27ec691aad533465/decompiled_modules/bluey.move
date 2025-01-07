module 0x25ddd819ce2b16162606d41279a013d5f59c2be25bef5f3c27ec691aad533465::bluey {
    struct BLUEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEY>(arg0, 6, b"Bluey", b"Sui Bluey", x"53756920426c756579206973206a757374206d65616e7420746f2062652e200a426c756579206973206120596f7554756265206368616e6e656c2077697468206f7665722039206d696c6c696f6e20666f6c6c6f7765727320616e64206d6f7265207468616e20362062696c6c696f6e2076696577732e0a0a0a46756c6c7920446f7820446576200a4e6f742068696464656e20626568696e64206120504650200a596f75747562657220776974682031382c3030302073756273726962657273200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bluey_S3_Exercise_010_scaled_6598bc8492.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

