module 0xdaf20a4d79f04494c407657595d9a285635b1fc2f11d6d50daa9baf7820aab57::hoper {
    struct HOPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPER>(arg0, 6, b"HOPER", b"Hoper", x"57657265206e6f7420736179696e67207765726520616c72656164792074686520746f702031206f6e2053756920436861696e2028796574292c2062757420696620796f75766520676f7420686f7065732c20647265616d732c20616e64206d617962652061207370616365737569742c207765766520676f7420796f7572206261636b2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hoper1_d4cd85ea1f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

