module 0x5087e8e7a7eb0d57624e6f65041d7cdccb5cf5d4e739c3c26e5e08fc861891c1::t56 {
    struct T56 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T56, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T56>(arg0, 9, b"T56", b"Token56", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6TrakUcDrsHf-41q2AsXH6ifQrgV76oIGCw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<T56>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T56>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T56>>(v2);
    }

    // decompiled from Move bytecode v6
}

