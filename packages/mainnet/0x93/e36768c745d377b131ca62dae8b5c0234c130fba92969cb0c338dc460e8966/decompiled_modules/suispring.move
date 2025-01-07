module 0x93e36768c745d377b131ca62dae8b5c0234c130fba92969cb0c338dc460e8966::suispring {
    struct SUISPRING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISPRING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISPRING>(arg0, 6, b"SUISPRING", b"SUI SPRING", x"526563656976696e67206472697073206f66207761746572207768656e20696e206e6565642c20616e642049207368616c6c2072657475726e20746865206b696e646e6573732077697468206120737072696e672e0a0a596f75206469206461206469206461206d652c204920687561206c6120687561206c6120796f752e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wechat_IMG_163_6d8bb2f9a8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISPRING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISPRING>>(v1);
    }

    // decompiled from Move bytecode v6
}

