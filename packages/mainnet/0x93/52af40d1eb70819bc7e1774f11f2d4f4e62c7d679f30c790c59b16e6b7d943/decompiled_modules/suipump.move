module 0x9352af40d1eb70819bc7e1774f11f2d4f4e62c7d679f30c790c59b16e6b7d943::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, b"SUIPUMP", b"Sui Pump", x"5355492050554d50202d20546865206669727374204d4d202453554920564f4c554d4520424f5420676f742061206c6f74206f6620696d70726f76656d656e742e0a0a4073756970756d705f626f740a0a5355492050554d5020697320746865206669727374206d61726b65742d6d616b696e6720626f74207468617420757365732066726573682077616c6c65747320746f20626f6f737420746f6b656e207669736962696c69747920616e64206d656574205472656e64696e67206f6e20446578732c20434720616e6420636d63206c697374696e672063726974657269612e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029468_2efceae57d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

