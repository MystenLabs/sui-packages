module 0x3fc626d0c9bf153f88de845711f09447c4b9aafb574eec63fae4a2d1115a9852::shin {
    struct SHIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIN>(arg0, 9, b"SHIN", b"Shin-chan", x"4f6e2073756e6e7920646179732c2049206c696b6520746f20656e6a6f79206d656d65636f696e20f09f929a204f6e207261696e7920646179732c204920616c736f206c696b6520746f20696e64756c676520696e206d656d65636f696e20f09f929a20245348494e20245348494e20245348494e20245348494e20245348494e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/shinchansui/shin/refs/heads/main/2221786-middle.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHIN>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

