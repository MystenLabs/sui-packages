module 0x9db4345aedfced36117210568fa4a3bd1ec633c390074cf1d4318ba8b35fd9c0::t36 {
    struct T36 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T36, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T36>(arg0, 9, b"T36", b"TOKEN36", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6TrakUcDrsHf-41q2AsXH6ifQrgV76oIGCw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<T36>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T36>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T36>>(v2);
    }

    // decompiled from Move bytecode v6
}

