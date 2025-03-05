module 0x6e2276ef598f3a518f28c8252f048f7557f322c9915ff6a114e5d5ecc503a68c::t21 {
    struct T21 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T21, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T21>(arg0, 9, b"T21", b"TOKEN21", b"non3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6TrakUcDrsHf-41q2AsXH6ifQrgV76oIGCw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<T21>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T21>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T21>>(v2);
    }

    // decompiled from Move bytecode v6
}

