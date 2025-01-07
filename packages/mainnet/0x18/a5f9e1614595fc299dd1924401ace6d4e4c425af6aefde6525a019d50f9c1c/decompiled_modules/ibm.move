module 0x18a5f9e1614595fc299dd1924401ace6d4e4c425af6aefde6525a019d50f9c1c::ibm {
    struct IBM has drop {
        dummy_field: bool,
    }

    fun init(arg0: IBM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IBM>(arg0, 9, b"IBM", b"IBM", b"IBM Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IBM>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IBM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IBM>>(v1);
    }

    // decompiled from Move bytecode v6
}

