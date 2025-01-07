module 0x4a2b075ba81f99ec41982a103e21692cc052abbb0e9fb209b68d9f94be4bc544::suidog {
    struct SUIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOG>(arg0, 6, b"SUIDOG", b"SATSHI DOG", x"496e2061206469676974616c20776f726c642c2053756920446f67206973206f757220706177207468617420636f6e6e6563747320796f7520746f207468652066696e616e6369616c206675747572652e0a0a4a6f696e20746865207061636b20616e642062652070617274206f662074686973207265766f6c7574696f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/snapedit_1730004078023_a011824e11.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

