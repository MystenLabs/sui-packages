module 0x8e6f06cd3c9f5f9cdb47f6d22fcfc93744d213ef4924fccd05025f90e0c37b9e::aamd {
    struct AAMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAMD>(arg0, 6, b"AAMD", b"AAA MOO DENG", b"Aaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000005889_2e4f274ba1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAMD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAMD>>(v1);
    }

    // decompiled from Move bytecode v6
}

