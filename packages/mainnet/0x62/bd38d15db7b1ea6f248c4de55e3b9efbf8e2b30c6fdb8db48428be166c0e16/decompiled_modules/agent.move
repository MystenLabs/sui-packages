module 0x62bd38d15db7b1ea6f248c4de55e3b9efbf8e2b30c6fdb8db48428be166c0e16::agent {
    struct AGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGENT>(arg0, 6, b"AGENT", b"AGENT", x"4147454e542069732061206d656d6520636f696e20666f7220226d61726b657420737069657322e2809474686f73652077686f2068756e7420666f7220616c706861207369676e616c732c206c65616b20696e666f726d6174696f6e2c20616e6420656e74657220747261646573206265666f7265207468652063726f77642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AGENT>(&mut v2, 3000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AGENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

