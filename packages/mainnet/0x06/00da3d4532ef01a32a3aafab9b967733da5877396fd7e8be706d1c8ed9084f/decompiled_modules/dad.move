module 0x600da3d4532ef01a32a3aafab9b967733da5877396fd7e8be706d1c8ed9084f::dad {
    struct DAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAD>(arg0, 9, b"DAD", b"TESTDAO1", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6TrakUcDrsHf-41q2AsXH6ifQrgV76oIGCw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DAD>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAD>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DAD>>(v2);
    }

    // decompiled from Move bytecode v6
}

