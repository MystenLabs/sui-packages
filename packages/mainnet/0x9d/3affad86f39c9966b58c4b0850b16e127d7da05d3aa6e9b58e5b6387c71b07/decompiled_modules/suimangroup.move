module 0x9d3affad86f39c9966b58c4b0850b16e127d7da05d3aa6e9b58e5b6387c71b07::suimangroup {
    struct SUIMANGROUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMANGROUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMANGROUP>(arg0, 6, b"SUIMANGROUP", b"Sui Man Group", x"4f7574206f662074686520626c75652c20726967687420696e746f207468652053756921205468652069636f6e6963207472696f206973206e6f772074616b696e67206f76657220537569202e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_6bce10ddcb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMANGROUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMANGROUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

