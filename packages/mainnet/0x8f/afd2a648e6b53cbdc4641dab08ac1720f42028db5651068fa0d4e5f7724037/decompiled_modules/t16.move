module 0x8fafd2a648e6b53cbdc4641dab08ac1720f42028db5651068fa0d4e5f7724037::t16 {
    struct T16 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T16, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T16>(arg0, 9, b"T16", b"Test16", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6TrakUcDrsHf-41q2AsXH6ifQrgV76oIGCw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<T16>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T16>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T16>>(v2);
    }

    // decompiled from Move bytecode v6
}

