module 0xd508bcfc2b413e3409b00ef4891b4c10da5e9ea441fd60fce6c55213cc26d4e8::mowww {
    struct MOWWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOWWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOWWW>(arg0, 9, b"MOWWW", b"MOWWWW", b"aaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/3abffd278cea6ba720fe8cd65acdad59blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOWWW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOWWW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

