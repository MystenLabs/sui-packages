module 0x7b84dfe0b85985ba6046fb3de9acb2aab5ecb3b4dc7187e7ffb48984df9b8336::t48 {
    struct T48 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T48, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T48>(arg0, 9, b"T48", b"Token48", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6TrakUcDrsHf-41q2AsXH6ifQrgV76oIGCw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<T48>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T48>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T48>>(v2);
    }

    // decompiled from Move bytecode v6
}

