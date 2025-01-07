module 0x85f7b3774e4d55b634335d916e2db3056da48108e431275d67332909a23ec3d4::plop {
    struct PLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLOP>(arg0, 6, b"PLOP", b"", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://api.movepump.com/uploads/PFP_e019216c48.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PLOP>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLOP>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PLOP>>(v2);
    }

    // decompiled from Move bytecode v6
}

