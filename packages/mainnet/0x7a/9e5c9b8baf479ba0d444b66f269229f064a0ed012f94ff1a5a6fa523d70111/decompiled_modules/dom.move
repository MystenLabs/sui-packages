module 0x7a9e5c9b8baf479ba0d444b66f269229f064a0ed012f94ff1a5a6fa523d70111::dom {
    struct DOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOM>(arg0, 6, b"DOM", b"Dom", x"f09f8c9f204120737061636520666f722074686f73652077686f2077616e7420746f206d61737465722074686569722066696e616e6369616c206675747572652e20f09f92b0204665656c206672656520746f2061736b207175657374696f6e732c206c6561726e20f09f939a2c20616e6420636f6e6e6563742077697468206120636f6d6d756e697479207468617420756e6465727374616e64732074686520706f776572206f662063727970746f2120f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731112385824.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

