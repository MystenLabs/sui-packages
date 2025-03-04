module 0xd6eff24c7f840bd575170336a9912b9e7ae55aac8811dfde3d41884f7f393c3e::tken1 {
    struct TKEN1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TKEN1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TKEN1>(arg0, 9, b"TKEN1", b"Token15", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6TrakUcDrsHf-41q2AsXH6ifQrgV76oIGCw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TKEN1>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TKEN1>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TKEN1>>(v2);
    }

    // decompiled from Move bytecode v6
}

