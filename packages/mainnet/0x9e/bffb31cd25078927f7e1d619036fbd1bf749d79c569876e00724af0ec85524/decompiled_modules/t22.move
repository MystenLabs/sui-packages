module 0x9ebffb31cd25078927f7e1d619036fbd1bf749d79c569876e00724af0ec85524::t22 {
    struct T22 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T22, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T22>(arg0, 9, b"T22", b"token22", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6TrakUcDrsHf-41q2AsXH6ifQrgV76oIGCw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<T22>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T22>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T22>>(v2);
    }

    // decompiled from Move bytecode v6
}

