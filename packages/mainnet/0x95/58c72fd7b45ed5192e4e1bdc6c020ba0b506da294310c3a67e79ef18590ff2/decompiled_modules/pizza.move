module 0x9558c72fd7b45ed5192e4e1bdc6c020ba0b506da294310c3a67e79ef18590ff2::pizza {
    struct PIZZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIZZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIZZA>(arg0, 6, b"PIZZA", b"Pizza", x"5468652053746f727920426568696e6420426974636f696e2050697a7a610a4f6e204d61792032322c20323031302c206120466c6f72696461206d616e206e616d6564204c61737a6c6f2048616e7965637a206d61646520686973746f727920627920636f6e64756374696e6720746865206669727374206b6e6f776e207265616c2d776f726c64207472616e73616374696f6e207573696e6720426974636f696e2e2048652065786368616e6765642031302c30303020426974636f696e7320666f722074776f206c617267652070697a7a61732066726f6d2050617061204a6f686e27732e204174207468652074696d652c207468652077", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731460906123.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIZZA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIZZA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

