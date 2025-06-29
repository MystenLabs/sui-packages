module 0x3c674dafd6dbaeaaa4a59af509c0133ea5bdc5202b415c917ecbd9b7fd9a01db::go {
    struct GO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GO>(arg0, 8, b"GO", b"NodeG", x"4e6f6465476f2e4169207c20412070726f64756374206f662050726f6f66466c6f77204c61627320e29da4efb88f207c20446563656e7472616c697a656420636f6d707574696e6720666f722065766572796f6e652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/a6951416-bae2-4c25-9cd8-b056aa92f74c.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GO>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GO>>(v1);
    }

    // decompiled from Move bytecode v6
}

