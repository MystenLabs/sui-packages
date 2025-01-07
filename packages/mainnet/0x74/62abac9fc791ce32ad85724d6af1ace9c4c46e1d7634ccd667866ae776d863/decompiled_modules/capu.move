module 0x7462abac9fc791ce32ad85724d6af1ace9c4c46e1d7634ccd667866ae776d863::capu {
    struct CAPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPU>(arg0, 6, b"CAPU", b"Capuchin Monkeyz", b"the ultimate digital banana stash for all you tree swingers and banana munchers out there", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/capu_6ba1ceb163.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPU>>(v1);
    }

    // decompiled from Move bytecode v6
}

