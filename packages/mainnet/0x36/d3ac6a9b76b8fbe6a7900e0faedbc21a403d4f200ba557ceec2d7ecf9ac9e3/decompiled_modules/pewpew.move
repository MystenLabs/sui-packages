module 0x36d3ac6a9b76b8fbe6a7900e0faedbc21a403d4f200ba557ceec2d7ecf9ac9e3::pewpew {
    struct PEWPEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEWPEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEWPEW>(arg0, 9, b"PEWPEW", b"PewPew", x"466f7267657420446f67652e20466f726765742053686962612e20466f7267657420506570652e2024504557504557206973206865726520746f20646f6d696e61746520616e64206c65617665206576657279206f74686572206d656d6520746f6b656e20696e2074686520647573742e205768696c65207468652072657374206f66207468656d206261726b2c20686f702c206f722063726f616b2c2077652066697265206c6173657273207374726169676874207468726f75676820746865206d61726b6574e28094616e6420737472616967687420696e746f20796f75722077616c6c65742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8f27ea12-35fe-4911-a95e-832c7aefc634.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEWPEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEWPEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

