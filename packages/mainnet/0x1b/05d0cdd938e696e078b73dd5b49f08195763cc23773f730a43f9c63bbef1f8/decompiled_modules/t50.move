module 0x1b05d0cdd938e696e078b73dd5b49f08195763cc23773f730a43f9c63bbef1f8::t50 {
    struct T50 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T50, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T50>(arg0, 9, b"T50", b"Token50", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6TrakUcDrsHf-41q2AsXH6ifQrgV76oIGCw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<T50>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T50>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T50>>(v2);
    }

    // decompiled from Move bytecode v6
}

