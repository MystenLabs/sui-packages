module 0xb29a80c5c028da0f3f201389f9098997fb5c8df1cdfd9f69868b71a9807783ad::test42 {
    struct TEST42 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST42, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST42>(arg0, 9, b"TEST42", b"TEST42", b"TEST42", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6TrakUcDrsHf-41q2AsXH6ifQrgV76oIGCw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST42>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST42>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TEST42>>(v2);
    }

    // decompiled from Move bytecode v6
}

