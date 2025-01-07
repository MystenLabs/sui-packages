module 0x7f6eb4833458dce5939ab06aa9b03c75a9876a5ff2e12634b13055a48c7decef::lilly {
    struct LILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LILLY>(arg0, 6, b"Lilly", b"Lilly the Chihuahua", x"4c696c6c79206973206120352079656172206f6c6420646f672077686f20636f6e7374616e746c792072756e7320616674657220686572206d61737465722c206275742069732061206c6f76696e6720646f672077686f20636f6e7374616e746c792077616e747320746f20637564646c6520616e6420646f65736e27742077616e7420746f206861726d20616e796f6e652e0a446f20796f75206c696b65204c696c6c793f205468656e20796f7527766520636f6d6520746f2074686520726967687420706c61636521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lilly_profilbild_17c8251b65.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

