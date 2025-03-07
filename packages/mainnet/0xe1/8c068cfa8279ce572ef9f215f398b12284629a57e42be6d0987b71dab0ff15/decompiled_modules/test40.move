module 0xe18c068cfa8279ce572ef9f215f398b12284629a57e42be6d0987b71dab0ff15::test40 {
    struct TEST40 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST40, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST40>(arg0, 9, b"TEST40", b"TEST40", b"TEST40", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6TrakUcDrsHf-41q2AsXH6ifQrgV76oIGCw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST40>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST40>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TEST40>>(v2);
    }

    // decompiled from Move bytecode v6
}

