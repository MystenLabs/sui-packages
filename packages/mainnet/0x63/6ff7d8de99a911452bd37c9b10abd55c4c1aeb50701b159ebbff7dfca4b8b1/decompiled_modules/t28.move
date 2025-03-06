module 0x636ff7d8de99a911452bd37c9b10abd55c4c1aeb50701b159ebbff7dfca4b8b1::t28 {
    struct T28 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T28, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T28>(arg0, 9, b"T28", b"token28", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6TrakUcDrsHf-41q2AsXH6ifQrgV76oIGCw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<T28>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T28>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T28>>(v2);
    }

    // decompiled from Move bytecode v6
}

