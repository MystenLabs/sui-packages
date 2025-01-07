module 0x7972404af3c3939842afd7c21acd9a020d2c7481469857b0c8d5aacc967b7e02::sol {
    struct SOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOL>(arg0, 6, b"SOL", b"Solana", x"54686520666972737420536f6c616e612077697468206e6f206f75746167657320746861742061637475616c6c7920776f726b732e20496d6167696e65206966207765206d61646520746869732068616c66206f6620746865206d61726b6574636170206f6620536f6c202e2e2e2e68616861686120636f6d65206a6f696e207467200a0a5820636f6d696e6720736f6f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5cc0b99a8dd84fbfa4e150d84b5531f2_1_7c3d04e75c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

