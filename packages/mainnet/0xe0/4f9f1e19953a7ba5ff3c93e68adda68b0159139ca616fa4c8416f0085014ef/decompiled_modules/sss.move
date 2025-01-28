module 0xe04f9f1e19953a7ba5ff3c93e68adda68b0159139ca616fa4c8416f0085014ef::sss {
    struct SSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSS>(arg0, 6, b"SSS", b"Sharky Sharkx Sui", x"536861726b7920536861726b78205375692024535353202d204120666561726c657373206d656d65636f696e207377696d6d696e67207468726f756768207468652063727970746f0a6f6365616e207769746820756e73746f707061626c65206d6f6d656e74756d20616e6420737472656e67746821", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul84_20250129024729_9a91a6ebdf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

