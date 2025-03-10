module 0x4c73c9ff6db4bbc9d705cdacf00330026511dcb23d834b749d5b0298fc6cb0be::t53 {
    struct T53 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T53, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T53>(arg0, 9, b"T53", b"TOKEN53", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6TrakUcDrsHf-41q2AsXH6ifQrgV76oIGCw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<T53>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T53>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T53>>(v2);
    }

    // decompiled from Move bytecode v6
}

