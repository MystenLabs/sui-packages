module 0x71d5dd5175dc68211d970770ec3c83f13e8225bfe4d69419652aaf80edc33982::prod1 {
    struct PROD1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PROD1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROD1>(arg0, 9, b"PROD1", b"PROD1", b"PROD1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6TrakUcDrsHf-41q2AsXH6ifQrgV76oIGCw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PROD1>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PROD1>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PROD1>>(v2);
    }

    // decompiled from Move bytecode v6
}

