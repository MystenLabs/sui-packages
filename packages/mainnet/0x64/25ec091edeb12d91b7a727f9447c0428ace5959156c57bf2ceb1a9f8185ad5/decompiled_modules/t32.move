module 0x6425ec091edeb12d91b7a727f9447c0428ace5959156c57bf2ceb1a9f8185ad5::t32 {
    struct T32 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T32, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T32>(arg0, 9, b"T32", b"TOKEN32", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6TrakUcDrsHf-41q2AsXH6ifQrgV76oIGCw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<T32>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T32>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T32>>(v2);
    }

    // decompiled from Move bytecode v6
}

