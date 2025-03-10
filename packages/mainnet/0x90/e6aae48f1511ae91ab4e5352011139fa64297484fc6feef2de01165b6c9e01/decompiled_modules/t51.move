module 0x90e6aae48f1511ae91ab4e5352011139fa64297484fc6feef2de01165b6c9e01::t51 {
    struct T51 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T51, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T51>(arg0, 9, b"T51", b"Token51", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6TrakUcDrsHf-41q2AsXH6ifQrgV76oIGCw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<T51>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T51>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T51>>(v2);
    }

    // decompiled from Move bytecode v6
}

