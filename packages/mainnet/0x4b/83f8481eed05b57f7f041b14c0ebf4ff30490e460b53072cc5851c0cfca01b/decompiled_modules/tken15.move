module 0x4b83f8481eed05b57f7f041b14c0ebf4ff30490e460b53072cc5851c0cfca01b::tken15 {
    struct TKEN15 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TKEN15, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TKEN15>(arg0, 9, b"TKEN15", b"Token15", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6TrakUcDrsHf-41q2AsXH6ifQrgV76oIGCw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TKEN15>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TKEN15>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TKEN15>>(v2);
    }

    // decompiled from Move bytecode v6
}

