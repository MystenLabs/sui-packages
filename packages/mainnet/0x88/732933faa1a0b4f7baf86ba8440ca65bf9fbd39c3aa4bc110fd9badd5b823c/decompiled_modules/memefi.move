module 0x88732933faa1a0b4f7baf86ba8440ca65bf9fbd39c3aa4bc110fd9badd5b823c::memefi {
    struct MEMEFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEFI>(arg0, 9, b"MEMEFI", b"MEMEFI", b"MEMEFI is a community-driven token powering the MemeFi consumer ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.memefi.club/landing/logo/memefi.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEFI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MEMEFI>>(0x2::coin::mint<MEMEFI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MEMEFI>>(v2);
    }

    // decompiled from Move bytecode v6
}

