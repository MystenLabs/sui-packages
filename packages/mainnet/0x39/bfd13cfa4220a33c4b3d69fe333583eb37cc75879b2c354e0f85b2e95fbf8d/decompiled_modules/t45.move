module 0x39bfd13cfa4220a33c4b3d69fe333583eb37cc75879b2c354e0f85b2e95fbf8d::t45 {
    struct T45 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T45, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T45>(arg0, 9, b"T45", b"TOKEN45", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6TrakUcDrsHf-41q2AsXH6ifQrgV76oIGCw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<T45>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T45>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T45>>(v2);
    }

    // decompiled from Move bytecode v6
}

