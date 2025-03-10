module 0xd9027c1efb6a3d34def2fb59f665e6a342a1553fced4c4a85869856efa3b0a36::mingtest {
    struct MINGTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINGTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINGTEST>(arg0, 9, b"MINGTEST", b"MINGTEST", b"MINGTEST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6TrakUcDrsHf-41q2AsXH6ifQrgV76oIGCw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MINGTEST>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINGTEST>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MINGTEST>>(v2);
    }

    // decompiled from Move bytecode v6
}

