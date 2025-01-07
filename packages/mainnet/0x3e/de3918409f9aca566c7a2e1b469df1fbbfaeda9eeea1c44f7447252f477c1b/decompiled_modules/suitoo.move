module 0x3ede3918409f9aca566c7a2e1b469df1fbbfaeda9eeea1c44f7447252f477c1b::suitoo {
    struct SUITOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOO>(arg0, 6, b"SUITOO", b"Suiet Tooth", x"4c657473206272696e67206120535549455420746173746520746f206f75722062616773207769746820537569657420546f6f7468207468652066757475726520535549206d6173636f74206f662053554920636861696e21204675636b2074686520746f6f74682066616972792c20537569657420546f6f746820776174657220626f617264656420746861742077696e67656420626974636820616e64206973206e6f772070757474696e672053554920756e64657220796f75722070696c6c6f7773207768656e20796f752062616720736f6d652053554945544f4f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiettooth_c444122586.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

