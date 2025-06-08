module 0x5801466db59fcb2925e232aa8fdd3dcd8e6e9a82d77147056037a8a035463572::raid {
    struct RAID has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAID>(arg0, 6, b"RAID", b"Raiden", b"SADASD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreief42c3mlplx2flddtuiddtdi7tucm6c3myqdlus2ama2m3awkeye")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RAID>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

